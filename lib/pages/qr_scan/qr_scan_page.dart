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
      _apiFuture = TownscriptAPI.instance.getRegisteredUsers(eventCode: _eventid);
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
        onLoaded: (List<Event> events) => _contents(events),
      );

    else 
      body = _contents();

    return FutureBuilder<List<AttendeeInfo>>(
      future: _apiFuture,
      builder: (BuildContext context, AsyncSnapshot<List<AttendeeInfo>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // if the info was loaded without any error, update [_regIds] list
          if (snapshot.data != null)
            _regIds = snapshot.data.map((info) => info.registrationId).toList();

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
                    _apiFuture = TownscriptAPI.instance.getRegisteredUsers(eventCode: _eventid);
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
          ? [
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
                        // for detecting the app generated QR code
                        if (value.split(",").contains(_eventid)) {
                          _displayText = value.split(",")[0] + " " + Strings.qrScanSuccess;
                          _textColor = Colors.green;
                        }
                        // for detecting the QR code in townscript confirmation emails
                        else if (_regIds != null && _regIds.contains(value)) {
                          _displayText = "User " + Strings.qrScanSuccess;
                          _textColor = Colors.green;
                        }
                        else {
                          List<String> splitVal = value.split(",");

                          if (splitVal[0] != null && double.tryParse(splitVal[0]) != null) {
                            _displayText = "User " + Strings.qrScanFail;
                          }
                          else {
                            _displayText = splitVal[0] + " " + Strings.qrScanFail;
                          }
                          _textColor = Colors.red;
                        }
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
}