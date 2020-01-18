import 'package:flutter/material.dart';

import 'loading_widget.dart';

/// A dialog box that executes a [Future] when the user
/// presses the confirm button, shows a loading screen
/// and an appropriate message after the [Future] finishes
class ConfirmationDialog extends StatefulWidget {

  /// The title of the dialog box
  final String title;

  /// The confirmation message that is asked to 
  /// the user.
  final String confirmationMessage;

  /// The message showed when the user confirms said
  /// action and the action is carried out.
  final String successMessage;

  /// The message showed when an error occurs
  final String errorMessage;

  /// The function that returns the future to wait on
  final Future<dynamic> Function() future;

  ConfirmationDialog({
    @required this.title,
    @required this.future,
    this.confirmationMessage = "Do you want to proceed?",
    this.successMessage = "Complete.",
    this.errorMessage = "Error occured. Please try again."
  });

  @override
  _ConfirmationDialogState createState() => _ConfirmationDialogState();
}

class _ConfirmationDialogState extends State<ConfirmationDialog> {

  /// value that controls whether the user confirmed
  /// the dialog or not.
  bool _confirmed;

  @override
  void initState() {
    super.initState();

    // initializing [_confirmed] to false
    _confirmed = false;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: _DialogContents(
        future: widget.future,
        confirmed: _confirmed,
        confirmationMessage: widget.confirmationMessage,
        successMessage: widget.successMessage,
        errorMessage: widget.errorMessage,
      ),
      actions: <Widget>[]
      ..addAll(
        (! _confirmed)
        ? [
          FlatButton(
            child: Text("Confirm"),
            onPressed: () => setState(() => _confirmed = true),
          )
        ]
        : []
      )
      ..addAll(
        (! _confirmed)
        ? [
          FlatButton(
            child: Text("Cancel"),
            onPressed: () => Navigator.of(context).pop(),
          )
        ]
        : []
      ),
    );
  }
}

/// The contents of the dialog box
class _DialogContents extends StatelessWidget {

  /// value that controls whether the user confirmed
  /// the dialog or not.
  final bool confirmed;

  /// The confirmation message that is asked to 
  /// the user.
  final String confirmationMessage;

  /// The message showed when the user confirms said
  /// action and the action is carried out.
  final String successMessage;

  /// The message showed when an error occurs
  final String errorMessage;

  /// The function that returns the future to wait on
  final Future<dynamic> Function() future;

  _DialogContents({
    @required this.confirmed,
    @required this.future,
    @required this.confirmationMessage,
    @required this.successMessage,
    @required this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    if (! confirmed)
      return Container(
        child: Text(confirmationMessage,)
      );

    return FutureBuilder(
      future: future(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          Future.delayed(Duration(seconds: 3)).then((_) => Navigator.of(context).pop());

          return Text(successMessage);
        }

        if (snapshot.hasError) {
          Future.delayed(Duration(seconds: 3)).then((_) => Navigator.of(context).pop());
          
          return Text(errorMessage);
        }

        else 
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              LoadingWidget(),
            ],
          );
      },
    );
  }
}