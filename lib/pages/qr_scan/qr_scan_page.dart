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

  @override
  void initState() {
    super.initState();

    // initializing
    _displayText = "";
    _textColor = Colors.white;
    if (User.instance.getClearanceLevel() == 1)
      _eventid = User.instance.getEventId();
  }

  @override
  Widget build(BuildContext context) {
    if (User.instance.getClearanceLevel() > 1)
      return EventLoader(
        beginLoad: true,
        onLoading: LoadingWidget(),
        onError: (BuildContext context, dynamic error) =>
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text("Error loading events. Try again."),
              backgroundColor: Colors.red,
            )
          ),
        onLoaded: (List<Event> events) => body(events),
      );

    return body();
  }

  Widget body([List<Event> events]) => 
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
                onSelected: (Event event) {
                  setState(() {
                    _eventid = event.id;
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
                        print(_eventid);
                        if (value.split(",").contains(_eventid)) {
                          _displayText = value.split(",")[0] + " " + Strings.qrScanSuccess;
                          _textColor = Colors.green;
                        }
                        else {
                          _displayText = value.split(",")[0] + " " + Strings.qrScanFail;
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
}