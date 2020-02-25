import 'package:dwimay/pages/qr_scan/qr_scan_form.dart';
import 'package:dwimay/pages/qr_scan/qr_scan_segment.dart';
import 'package:dwimay/strings.dart';
import 'package:dwimay/widgets/build_button.dart';
import 'package:dwimay/widgets/loading_widget.dart';
import 'package:dwimay_backend/dwimay_backend.dart';
import 'package:flutter/material.dart';

class QrScanPage extends StatefulWidget {

  /// The function to execute when the back button is pressed
  final void Function() onBackPressed;
  
  QrScanPage({@required this.onBackPressed});
  
  @override
  _QrScanPageState createState() => _QrScanPageState();
}

class _QrScanPageState extends State<QrScanPage> {

  /// The display text
  String _displayText;

  /// The color of the display text
  Color _textColor;

  /// The id of the event to scan for
  String _eventid;

  /// The registerations ids from townscript. The participant can show the QR code received 
  /// as a mail from townscript as well, this list is used in validating that QR code.
  List<String> _regIds;

  /// The attendee information
  List<AttendeeInfo> info;

  /// The future that is used to get the info from townscript
  Future<List<AttendeeInfo>> _apiFuture;

  /// The initial text of the form used for level 3+ users
  String _initialFormText;

  /// boolean that defines whether the alert was shown or not
  bool _alertShown;

  @override
  void initState() {
    super.initState();

    // initializing
    _displayText = "";
    _initialFormText = "";
    _alertShown = false;
    _textColor = Colors.white;
    if (User.instance.getClearanceLevel() == 1)
      _eventid = User.instance.getEventId();

    // loading the data
    if (_eventid != null)
      _apiFuture = TownscriptAPI.instance.getRegisteredUsers(eventCode: _eventid, includePasses: true);
    else
      _apiFuture = Future.delayed(Duration(milliseconds: 100)).then((_) => []);
  }

  @override
  Widget build(BuildContext context) {
    Widget body;

    if (User.instance.getClearanceLevel() > 1)
      body = EventLoader(
        beginLoad: true,
        onLoading: LoadingWidget(),
        onError: (BuildContext context, dynamic error) =>
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text("Error loading events. Try again."),
              backgroundColor: Colors.red,
            )
          ),
        onLoaded: (List<Event> events, List<Pass> passes) => _contents(events),
      );

    else 
      body = _contents();

    return FutureBuilder<List<AttendeeInfo>>(
      future: _apiFuture,
      builder: (BuildContext context, AsyncSnapshot<List<AttendeeInfo>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // if the info was loaded without any error, update [_regIds] and [info] list
          if (snapshot.data != null) {
            info = snapshot.data;
            _regIds = snapshot.data.map((info) => info.registrationId).toList();
          }

          // else, show alert if not shown already for the current event
          if (snapshot.data == null && ! _alertShown) {
            _alertShown = true;
            _showAlert();
          }

          // returning the body
          return body;
        }
        else
          return LoadingWidget();
      },
    );
  }

  Widget _contents([List<Event> events]) => 
    Padding(
      padding: EdgeInsets.only(bottom: 30.0, left: 20.0, right: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  <Widget>[
          // The title
          Text(
            Strings.qrScanPageTitle,
            style: Theme.of(context).textTheme.title,            
          ),
        ]
        ..addAll(
          (User.instance.getClearanceLevel() > 1)
          ? [ 
              // gap
              SizedBox(height: 30,),

              // the form to select the event to scan for
              QrScanForm(
                events: events,
                initialFormText: _initialFormText,
                onSelected: (Event event) {
                  setState(() {
                    _eventid = event.id;
                    _apiFuture = TownscriptAPI.instance.getRegisteredUsers(eventCode: _eventid, includePasses: true);
                    _initialFormText = event.name;
                    _regIds = null;
                    _alertShown = false;
                    _displayText = "";
                  });
                },
              ),
            ]

          : []  
        )
        ..addAll(
          // if no event was selected
          (_eventid == null)
          ? 
            (User.instance.getClearanceLevel() == 1)
            ? [
                Expanded(
                  child: Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: Strings.level1ProfileErrorHeader,
                        style: Theme.of(context).textTheme.subtitle.copyWith(
                          fontWeight: FontWeight.normal,             
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: Strings.level1ProfileErrorSubtitle,
                            style:  Theme.of(context).textTheme.headline.copyWith(
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              height: 1.5
                            ),
                          )
                        ]
                      ),
                    ),
                  ),
                )
              ]
            : [
                // message that prompts member to select an event first
                Expanded(
                  child: Center(
                    child: Text(
                      Strings.noEventSelected,
                      style: Theme.of(context).textTheme.body2,
                    ),
                  ),
                )
              ]

          : [
              // scanner
              Expanded(
                child: Center(
                  child: QrScanSegment(
                    displayText: _displayText,
                    textColor: _textColor,
                    onScan: (String value) => 
                      setState(() {
                        _validate(value);
                      }),
                  ),
                ),
              ),
            ]
        )
        ..addAll([
          // back button
          BuildButton(
            data: Strings.backButton,
            onPressed: widget.onBackPressed,
            padding: const EdgeInsets.symmetric(vertical: 10),
          ) 
        ])
      )
    );

  void _showAlert() => 
    WidgetsBinding.instance.addPostFrameCallback((_) => 
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => 
          AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))
            ),
            title: Text(
              Strings.warning,
              style: TextStyle(color: Colors.orange,),
            ),
            content: Text(
              Strings.townscriptNotRecognized,
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  "OK",
                  style: TextStyle(color: Theme.of(context).accentColor),
                ),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          )
      )
    );

  void _validate(String value) {
    // splitting the qr code at comma
    List<String> values = value.split(",");

    // if the length of the split is 1, that means the scanner is scanning
    // a QR code in the townscript confirmation email
    if (values.length == 1) {
      // checking if the registration id in the QR code is valid
      if (_regIds.contains(values[0])) {

        // getting the index of the registration id in [_regIds]
        int index = _regIds.indexOf(values[0]);
        _displayText = "Pass Detected!\nEvents:\n- ${info[index].getAllAnswers().join("\n- ")}";
        _textColor = Colors.green;
      }
      else {
        _displayText = "User " + Strings.qrScanFail;
        _textColor = Colors.red;
      }
    }

    // if the length of the split is greater than 1, that means the scanner
    // is scanning a app generated QR code
    else if (values.length > 1) {
      // checking if the current event id is in the split
      // this is for an individual event
      if (values.contains(_eventid)) {
        _displayText = values[0] + " " + Strings.qrScanSuccess;
        _textColor = Colors.green;
      }

      // checking for passes, by getting the intersection of the registration ids
      // from townscript and the split, since the registration id of the pass
      // will be in the split, and if their are multiple passes, then there will
      // be mulitiple intersections
      else if (_regIds.toSet().intersection(values.toSet()).length != 0) {
        // getting the intersecting ids
        List<String> detectedPassRegIds = _regIds.toSet().intersection(values.toSet()).toList();

        // initializing the variable that will contain all the event names
        String eventNames = "";
        
        for (String regId in detectedPassRegIds) {
          // getting the index of the registration id in [_regIds]
          int index = _regIds.indexOf(regId);

          if (info[index].answerList != null && info[index].answerList.length != 0) 
            eventNames += "- " + info[index].getAllAnswers().join("\n- ") + "\n";
        }
        
        _displayText = "Pass Detected!\nEvents:\n$eventNames";
        _textColor = Colors.green;
      }

      else {
        _displayText = values[0] + " " + Strings.qrScanFail;
        _textColor = Colors.red;
      }
    }

    else {
      _displayText = "QR code not recognised";
      _textColor = Colors.red;
    }
  }
}