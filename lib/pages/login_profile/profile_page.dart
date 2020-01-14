import 'package:dwimay_backend/dwimay_backend.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:async';
import 'package:flutter/services.dart';

/// The profile page. The user logs in using the profile page.
/// The details of the user and the QR code for entering will
/// be present after logging in.
class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final message = User.instance.getEmailID();

    Future<ui.Image> _loadOverlayImage() async {
      final completer = Completer<ui.Image>();
      final byteData = await rootBundle.load('assets/images/talk.png');
      ui.decodeImageFromList(byteData.buffer.asUint8List(), completer.complete);
      return completer.future;
    }

    final qrFutureBuilder = FutureBuilder(
      future: _loadOverlayImage(),
      builder: (ctx, snapshot) {
        final size = 280.0;
        if (!snapshot.hasData) {
          return Container(width: size, height: size);
        }
        return CustomPaint(
          size: Size.square(size),
          painter: QrPainter(
            data: message,
            version: QrVersions.auto,
            color: Colors.black,
            emptyColor: Color(0x00),
            // size: 320.0,
            embeddedImage: snapshot.data,
            embeddedImageStyle: QrEmbeddedImageStyle(
              size: Size.square(60),
            ),
          ),
        );
      },
    );

    final level = User.instance.getClearanceLevel();

    final _buildQrReader = RaisedButton(
      onPressed: () async {
        String res = await QrScanner.scan();
      },
      child: Text("Scan"),
    );

    final pass = (level != 0) ? qrFutureBuilder : _buildQrReader;

    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            pass,
            SizedBox(height: 20),
            Text(
              "Profile page",
              style: Theme.of(context).textTheme.title.copyWith(
                    color: Colors.white,
                  ),
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              child: Text("Logout"),
              onPressed: () {
                LoginWidget.of(context).logout();
              },
            )
          ]),
    );
  }
}
