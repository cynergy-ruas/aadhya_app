import 'package:dwimay/pages/clearance_modifier/clearance_modifier_form.dart';
import 'package:dwimay/widgets/build_button.dart';
import 'package:dwimay/widgets/confirmation_dialog.dart';
import 'package:dwimay_backend/dwimay_backend.dart';
import 'package:flutter/material.dart';

/// The page where the user can modify clearance level of 
/// users.
class ClearanceModifier extends StatelessWidget {

  /// The function to execute when the backbutton is pressed
  final void Function() onBackPress;

  /// The key for the form
  final GlobalKey<ClearanceModifierFormState> formKey;

  ClearanceModifier({@required this.onBackPress}) : 
    formKey = GlobalKey<ClearanceModifierFormState>();

  @override
  Widget build(BuildContext context) {
    // The combination of [LayoutBuilder], [SingleChildScrollView], [ConstrainedBox]
    // and [IntrinsicHeight] is used so that [Expanded] can be used inside a 
    // [SingleChildScrollView].
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 30.0, left: 20.0, right: 20.0),
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
                      "Update Clearance",
                      style: Theme.of(context).textTheme.title.copyWith(
                        color: Colors.white
                      ),
                    ),

                    // the forms
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: ClearanceModifierForm(
                          key: formKey,
                          onSaved: (String email, int clearance) =>
                            _onSaved(context, email, clearance),
                        ),
                      ),
                    ),

                    // the back and submit button
                    _buttonBar(),
                  ],
                ),
              ),
            )
          ),
      ),
    );
  }

  // shows the confirmation dialog
  void _onSaved(BuildContext context, String email, int clearance) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => 
        ConfirmationDialog(
          title: "Update Clearance",
          successMessage: "Clearance updated.",
          future: () async {
            Map<String, dynamic> res = Map<String, dynamic>.from(await FunctionsManager.instance.updateClearance(
              email: email,
              clearance: clearance
            ));

            // checking if the result of the operation was successful
            if (res["status"] != 200) {
              if (res["status"] == 401)
                throw Exception("Insufficient permissions");
              if (res["status"] == 500)
                throw Exception("User may not exist");
              else
                throw Exception("Unknown error");  
            }

            // return true to indicate success
            return true;
          },
        )
    );
  }

  // the back and submit buttons
  Widget _buttonBar() => 
    // Back button
    Row(
      children: <Widget>[
        // back button
        SizedBox(
          width: 120,
          child: BuildButton(
            data: "Back",
            onPressed: onBackPress,
          ),
        ),

        // center gap
        Expanded(child: Container(),),

        // the confirm button
        SizedBox(
          width: 120,
          child: BuildButton(
            data: "Confirm",
            onPressed: () => formKey.currentState.saveForm(),
          ),
        ),
      ],
    );
}