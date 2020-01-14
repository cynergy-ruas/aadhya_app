import 'package:dwimay/pages/login_profile/build_button.dart';
import 'package:dwimay_backend/dwimay_backend.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart';

/// The profile page. The user logs in using the profile page.
/// The details of the user and the QR code for entering will
/// be present after logging in.
class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _email = User.instance.getEmailID();

    msgEncode(message) {
      var bytes = utf8.encode(message);
      var base64Str = base64.encode(bytes);
      return base64Str;
    }

    msgDecode(base64Str) {
      var bytes = base64Decode(base64Str);
      return utf8.decode(bytes);
    }

    Future<ui.Image> _loadOverlayImage() async {
      final completer = Completer<ui.Image>();
      final byteData = await rootBundle.load('assets/images/talk.png');
      ui.decodeImageFromList(byteData.buffer.asUint8List(), completer.complete);
      return completer.future;
    }

    final _buildQrReader = BuildButton(
      data: "SCAN",
      onPressed: () async {
        String res = await QrScanner.scan();
        res = msgDecode(res);
      },
      verticalPadding: 25.0,
      horizotalPadding: 100.0,
    );

    final qrFutureBuilder = FutureBuilder(
      future: _loadOverlayImage(),
      builder: (ctx, snapshot) {
        final size = 250.0;
        if (!snapshot.hasData) {
          return Container(width: size, height: size);
        }
        return CustomPaint(
          size: Size.square(size),
          painter: QrPainter(
            data: msgEncode(_email),
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

    final _logoutButton = BuildButton(
      data: "LOGOUT",
      onPressed: () {
        LoginWidget.of(context).logout();
      },
      verticalPadding: 25.0,
      horizotalPadding: 100.0,
    );

    final level = User.instance.getClearanceLevel();

    final pass = (level == 0) ? qrFutureBuilder : _buildQrReader;

    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(vertical: 25.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Welcome " + _email.substring(0, _email.indexOf('@')),
                style: Theme.of(context).textTheme.title.copyWith(
                      color: Colors.white,
                    ),
              ),
              SizedBox(height: 30),
              (level == 0)
                  ? Text(
                      "Your Pass: ",
                      style: Theme.of(context).textTheme.body1.copyWith(
                            color: Colors.white,
                          ),
                    )
                  : Container(),
              (level == 0) ? SizedBox(height: 15) : Container(),
              pass,
              (level == 0) ? SizedBox(height: 25) : Container(),
              (level == 0)
                  ? Text(
                      "Your Events: ",
                      style: Theme.of(context).textTheme.body1.copyWith(
                            color: Colors.white,
                          ),
                    )
                  : Container(),
              _logoutButton,
            ]),
      ),
    );
  }
}
