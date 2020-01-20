import 'package:dwimay/strings.dart';
import 'package:dwimay/widgets/build_button.dart';
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

  /// The event load bloc
  EventLoadBloc _bloc;

  /// The key for the form
  GlobalKey<AssignEventsFormState> _formKey;

  @override
  void initState() {
    super.initState();

    // initializing the bloc
    _bloc = EventLoadBloc();

    // initializing the form key
    _formKey = GlobalKey<AssignEventsFormState>();
  }

  @override
  Widget build(BuildContext context) {
    // The combination of [LayoutBuilder], [SingleChildScrollView], [ConstrainedBox]
    // and [IntrinsicHeight] is used so that [Expanded] can be used inside a 
    // [SingleChildScrollView].
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0, left: 20.0, right: 20.0),
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
                      style: Theme.of(context).textTheme.title.copyWith(
                        color: Colors.white
                      ),
                    ),

                    // the forms
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: EventLoader(
                          beginLoad: true,
                          bloc: _bloc,
                          onLoading: Center(child: LoadingWidget(),),
                          onLoaded: (List<Event> events) => 
                            AssignEventsForm(
                            key: _formKey,
                            events: events,
                            onSaved: (String email, String eventID) =>
                              _onSaved(context, email, eventID),
                          ),
                        )
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

  /// shows the confirmation dialog
  void _onSaved(BuildContext context, String email, String eventID) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => 
        ConfirmationDialog(
          title: Strings.assignEventsPageTitle,
          successMessage: Strings.assignEventsSuccess,
          future: () async {
            Map<String, dynamic> res = Map<String, dynamic>.from(await CloudFunctions.instance.assignEventToUser(
              email: email,
              eventID: eventID
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

  Widget _buttonBar() => 
    // Back button
    Row(
      children: <Widget>[
        // back button
        SizedBox(
          width: 120,
          child: BuildButton(
            data: Strings.backButton,
            onPressed: widget.onBackPress,
          ),
        ),

        // center gap
        Expanded(child: Container(),),

        // the confirm button
        SizedBox(
          width: 120,
          child: BuildButton(
            data: Strings.confirmButton,
            onPressed: () => _formKey.currentState.saveForm(),
          ),
        ),
      ],
    );

  @override
  void dispose() {
    super.dispose();

    // closing the bloc
    _bloc.close();
  }
}