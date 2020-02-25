import 'package:dwimay/strings.dart';
import 'package:dwimay/widgets/back_confirm_button_bar.dart';
import 'package:dwimay/widgets/confirmation_dialog.dart';
import 'package:dwimay/widgets/loading_widget.dart';
import 'package:dwimay_backend/dwimay_backend.dart';
import 'package:flutter/material.dart';
import 'assign_events_form.dart';

/// The page where the user can assign events to other level 1 users
class AssignEvents extends StatefulWidget {

  /// The function to execute when the backbutton is pressed
  final void Function() onBackPress;

  AssignEvents({@required this.onBackPress});

  @override
  _AssignEventsState createState() => _AssignEventsState();
}

class _AssignEventsState extends State<AssignEvents> {

  /// The key for the form
  GlobalKey<AssignEventsFormState> _formKey = GlobalKey<AssignEventsFormState>();

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
                      Strings.assignEventsPageTitle,
                      style: Theme.of(context).textTheme.title,
                    ),

                    // the forms
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: EventLoader(
                          beginLoad: true,
                          onLoading: Center(child: LoadingWidget(),),
                          onLoaded: (List<Event> events, List<Pass> passes) {
                            if (User.instance.getClearanceLevel() > 1) {
                              return AssignEventsForm(
                                key: _formKey,
                                events: events,
                                onSaved: (String email, String eventID) =>
                                  _onSaved(context, email, eventID),
                              );
                            }
                            else {
                              Event event = events.firstWhere((event) => event.id == User.instance.getEventId(), orElse: () => null);

                              if (event != null) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      "Assigning user for event: " + event.name,
                                      style: Theme.of(context).textTheme.subhead.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    // gap
                                    SizedBox(height: 20,),

                                    // the form
                                    AssignEventsForm(
                                      key: _formKey,
                                      events: events,
                                      onSaved: (String email, String eventID) =>
                                        _onSaved(context, email, eventID),
                                    )
                                  ],
                                );
                              }
                              
                              // displaying error text
                              return RichText(
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
                              );
                            }
                          }
                        )
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
  void _onSaved(BuildContext context, String email, String eventID) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => 
        ConfirmationDialog(
          title: Strings.assignEventsPageTitle,
          successMessage: Strings.assignEventsSuccess,
          useSnapshotErrorMessage: true,
          future: () async {
            await CloudFunctions.instance.assignEventsToUser(
              email: email,
              eventID: eventID
            );

            // returning true to indicate success
            return true;
          },
        )
    );
  }
}