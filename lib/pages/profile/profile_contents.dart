import 'package:dwimay/strings.dart';
import 'package:dwimay/widgets/build_button.dart';
import 'package:dwimay_backend/dwimay_backend.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

/// The profile page. The user logs in using the login page.
/// The details of the user and the QR code for entering will
/// be present after logging in.
/// if the user is not a participant then a qr code will be present
/// if the users clearence level is higher than 3,
/// then the user can edit the event data
class ProfileContents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // get the email id of the logged in user
    final _email = User.instance.getEmailID();
    // get the clearance level of the logged in user
    final level = User.instance.getClearanceLevel();

    /// function to encrypt a [string]
    encrypt(message) {
      var bytes = utf8.encode(message);
      var base64Str = base64.encode(bytes);
      return base64Str;
    }

    /// function to decrypt the [string]
    /// encoded by [encrypt]
    decrypt(String base64Str) {
      var len = base64Str.length;
      var output =
          (len % 4 == 0) ? utf8.decode(base64Decode(base64Str)) : "INVALID";
      return output;
    }

    // building the Qr code scanner button
    final _buildQrReader = BuildButton(
      data: Strings.scanButton,
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

        // TODO: check with registered events and show result
        print(result);
      },
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 35),
    );

    //building the Qr code
    final _qrCode = QrImage(
      // the data of the Qr code
      data: encrypt(_email),

      // the size
      size: 280,

      // the background color
      backgroundColor: Colors.white,

      // TODO: Use fest logo
      embeddedImage: AssetImage(
        "assets/images/talk.png",
      ),

      // the style of the embedded image
      embeddedImageStyle: QrEmbeddedImageStyle(
        size: Size.square(60),
      ),
    );

    // build the logout button
    final _logoutButton = BuildButton(
      data: Strings.logoutButton,
      onPressed: () {
        BackendProvider.of<AuthBloc>(context).logout();
      },

      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 35),
    );

    // if user is participant then build a Qr Code
    // else build a Qr scanner
    final pass = (level == 0) ? _qrCode : _buildQrReader;

    return Center(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.only(bottom: 30.0, left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Title of profile page. Wrapping with [Row] to center it
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Welcome " + _email.substring(0, _email.indexOf('@')),
                  style: Theme.of(context).textTheme.title.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),

            // gap
            SizedBox(height: 30),
          ]
          ..addAll(
            (level == 0)
            // widgets for normal user
            ? [
                // the title for the qr code
                Text(
                  Strings.qrTitle,
                  style: Theme.of(context).textTheme.body1.copyWith(
                    color: Colors.white,
                  ),
                ),

                // gap
                SizedBox(height: 15),

                // the qr code
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[pass],
                ),

                // gap
                SizedBox(height: 25),

                // the title for registered events
                Text(
                  Strings.registeredEvents,
                  style: Theme.of(context).textTheme.body1.copyWith(
                    color: Colors.white,
                  ),
                ),

                // TODO: add registered events UI

                // gap
                SizedBox(height: 40,),

                // logout button
                Center(child: _logoutButton,)
              ]
            // UI for coordinators and above
            : [ 
                Flexible(child: Center(child: pass)),

                // gap
                SizedBox(height: 20,),

                // the logout button
                Flexible(child: Center(child: _logoutButton))
              ]
          ),
        ),
      ),
    );
  }
}
