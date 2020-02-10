import 'package:dwimay_backend/dwimay_backend.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class QrScanSegment extends StatefulWidget {

  /// The function to execute when the QR code is scanned and
  /// decrypted
  final void Function(String) onScan;

  /// The display text
  final String displayText;

  /// The display text color
  final Color textColor;

  QrScanSegment({@required this.onScan, @required this.displayText, @required this.textColor});

  @override
  _QrScanSegmentState createState() => _QrScanSegmentState();
}

class _QrScanSegmentState extends State<QrScanSegment> {

  /// The size of the scan button
  double _buttonSize;

  @override
  void initState() {
    super.initState();

    // initializing
    _buttonSize = 70;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // the scan button
          SizedBox(
            height: _buttonSize,
            width: _buttonSize,
            child: FloatingActionButton(
              heroTag: "the_actual_scan_button",
              elevation: 10,
              child: Icon(MdiIcons.qrcodeScan, size: _buttonSize / 2,),
              onPressed: _scan,
            ),
          ),

          // gap
          SizedBox(height: 20,),

          // the result of scanning
          Text(
            widget.displayText,
            style: Theme.of(context).textTheme.headline.copyWith(
              color: widget.textColor,
            )
          )
        ],
      ),
    );
  }

  void _scan() async {
    // the output of the scan is stored in res
    // if  scan is successful then
    // the string in the Qr code is stored
    // or else the string about the error is stored
    String res = await QrScanner.scan();

    if (res != QrScanner.CameraAccessDenied && res != QrScanner.UnknownError && res != QrScanner.UserCancelled) {
      widget.onScan(res);
    }
  }
}