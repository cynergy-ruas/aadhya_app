import 'package:dwimay/pages/clearance_modifier/clearance_modifier_form.dart';
import 'package:dwimay/strings.dart';
import 'package:dwimay/widgets/back_confirm_button_bar.dart';
import 'package:dwimay/widgets/confirmation_dialog.dart';
import 'package:dwimay_backend/dwimay_backend.dart';
import 'package:flutter/material.dart';

/// The page where the user can modify clearance level of 
/// users.
class ClearanceModifier extends StatefulWidget {

  /// The function to execute when the backbutton is pressed
  final void Function() onBackPress;


  ClearanceModifier({@required this.onBackPress});

  @override
  _ClearanceModifierState createState() => _ClearanceModifierState();
}

class _ClearanceModifierState extends State<ClearanceModifier> {
  /// The key for the form
  GlobalKey<ClearanceModifierFormState> _formKey = GlobalKey<ClearanceModifierFormState>();

  @override
  Widget build(BuildContext context) {
    // The combination of [LayoutBuilder], [SingleChildScrollView], [ConstrainedBox]
    // and [IntrinsicHeight] is used so that [Expanded] can be used inside a 
    // [SingleChildScrollView].
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) => 
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[

                    // title
                    Text(
                      Strings.clearancePageTitle,
                      style: Theme.of(context).textTheme.title,
                    ),

                    // the forms
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: ClearanceModifierForm(
                          key: _formKey,
                          onSaved: (String email, int clearance) =>
                            _onSaved(context, email, clearance),
                        ),
                      ),
                    ),

                    // the back and submit button
                    BackConfirmButtonBar(
                      onConfirmPressed: () => _formKey.currentState.saveForm(),
                      onBackPressed: widget.onBackPress,
                    ),

                    // gap
                    SizedBox(height: 30,),
                  ],
                ),
              ),
            )
          ),
      ),
    );
  }

  /// shows the confirmation dialog
  void _onSaved(BuildContext context, String email, int clearance) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => 
        ConfirmationDialog(
          title: Strings.clearancePageTitle,
          successMessage: Strings.clearancePageSuccess,
          useSnapshotErrorMessage: true,
          future: () async {
            await CloudFunctions.instance.updateClearanceForUser(
              email: email,
              clearance: clearance
            );

            // returning true to indicate success
            return true;
          }
        )
    );
  }
}