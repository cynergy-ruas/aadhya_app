import 'package:dwimay/widgets/build_button.dart';
import 'package:dwimay_backend/dwimay_backend.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:convert';
import 'dart:async';
import 'package:flutter/services.dart';

/// The profile page. The user logs in using the login page.
/// The details of the user and the QR code for entering will
/// be present after logging in.
/// if the user is not a participant then a qr code will be present
/// if the users clearence level is higher than 3,
/// then the user can edit the event data
class ProfileContents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // get the emial id of the logged in user
    final _email = User.instance.getEmailID();
    // get the clearance level of the logged in user
    final level = User.instance.getClearanceLevel();

    /// function to encrypt a [string]
    encrypt(message) {
      var bytes = utf8.encode(message);
      var base64Str = base64.encode(bytes);
      return base64Str;
    }

    /// functuion to decrypt the [string]
    /// encoded by [encrypt]
    decrypt(String base64Str) {
      var len = base64Str.length;
      var output =
          (len % 4 == 0) ? utf8.decode(base64Decode(base64Str)) : "INVALID";
      return output;
    }

    // await the load of the image to be embedded in the Qr code
    Future<ui.Image> _loadOverlayImage() async {
      final completer = Completer<ui.Image>();
      final byteData = await rootBundle.load('assets/images/talk.png');
      ui.decodeImageFromList(byteData.buffer.asUint8List(), completer.complete);
      return completer.future;
    }

    // building the Qr code scanner button
    final _buildQrReader = BuildButton(
      data: "SCAN",
      onPressed: () async {
        // the output of the scan is stored in res
        // if  scan is successful then
        // the string in the Qr code is stored
        // or else the string about the error is stored
        String res = await QrScanner.scan();

        // if the scan is successful then we decrypt the code
        // the decrypted code is stored in result
        // if the scan doesnt complete then
        // decrypt returns "INVALID"
        String result = decrypt(res);
        print(result);
      },
      verticalPadding: 25.0,
      horizontalPadding: 100.0,
    );

    //building the Qr code
    final qrFutureBuilder = FutureBuilder(
      future: _loadOverlayImage(),
      builder: (ctx, snapshot) {
        // the size of the Qr code
        final size = 250.0;
        if (!snapshot.hasData) {
          return Container(width: size, height: size);
        }
        return CustomPaint(
          size: Size.square(size),
          painter: QrPainter(
            // the data of the Qr code
            data: encrypt(_email),
            version: QrVersions.auto,

            // the main color of the code
            color: Colors.black,

            // the color of the empty part
            emptyColor: Color(0x00),

            embeddedImage: snapshot.data,
            embeddedImageStyle: QrEmbeddedImageStyle(
              size: Size.square(60),
            ),
          ),
        );
      },
    );

    // build the logout button
    final _logoutButton = BuildButton(
      data: "LOGOUT",
      onPressed: () {
        LoginWidget.of(context).logout();
      },
      verticalPadding: 25.0,
      horizontalPadding: 100.0,
    );

    // if user is participant then build a Qr Code
    // else build a Qr scanner
    final pass = (level == 0) ? qrFutureBuilder : _buildQrReader;

    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(vertical: 25.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Title of profile page
              Text(
                "Welcome " + _email.substring(0, _email.indexOf('@')),
                style: Theme.of(context).textTheme.title.copyWith(
                      color: Colors.white,
                    ),
              ),

              // gap
              SizedBox(height: 30),

              // if user participant display entry pass else empty
              (level == 0)
                  ? Text(
                      "Your Pass: ",
                      style: Theme.of(context).textTheme.body1.copyWith(
                            color: Colors.white,
                          ),
                    )
                  : Container(),

              // gap
              (level == 0) ? SizedBox(height: 15) : Container(),

              // if user is participant then build a Qr Code
              // else build a Qr scanner
              pass,

              // gap
              (level == 0) ? SizedBox(height: 25) : Container(),

              // display the events of participants
              (level == 0)
                  ? Text(
                      "Your Events: ",
                      style: Theme.of(context).textTheme.body1.copyWith(
                            color: Colors.white,
                          ),
                    )
                  : Container(),

              // TODO: actually print the events registerd

              // logout button
              _logoutButton,
            ]),
      ),
    );
  }
}
