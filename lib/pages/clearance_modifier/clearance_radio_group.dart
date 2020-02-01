import 'package:dwimay_backend/dwimay_backend.dart';
import 'package:flutter/material.dart';

/// The radio button group used to select the clearance level
class ClearanceRadioFormField extends StatefulWidget {

  /// Function to be called when the form is saved.
  final void Function(int) onSaved;

  ClearanceRadioFormField({@required this.onSaved});

  @override
  _ClearanceRadioFormFieldState createState() => _ClearanceRadioFormFieldState();
}

class _ClearanceRadioFormFieldState extends State<ClearanceRadioFormField> {

  /// The group value of the radio buttons
  int _group;

  @override
  void initState() {
    super.initState();

    // initializing the group value
    _group = 0;
  }

  @override
  Widget build(BuildContext context) {
    return FormField<int>(
      initialValue: _group,
      builder: (FormFieldState<int> state) => _radioButtons(state: state),
      onSaved: widget.onSaved,
    );
  }

  /// The radio buttons.
  Widget _radioButtons({@required FormFieldState<int> state}) =>
    Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        
        // first row of radio buttons
        Row(
          children: <Widget>[

            // button for level 0
            ..._radioButtonEntry(level: 0, state: state),

            // gap
            Expanded(child: Container(),),

            // button for level 1
            ..._radioButtonEntry(level: 1, state: state),

            // gap
            SizedBox(width: 20,),
          ],
        ),

        // gap
        SizedBox(height: 20,),

        // second row of radio buttons
        Row(
          children: <Widget>[

            // button for level 2
            ..._radioButtonEntry(level: 2, state: state),

            // gap
            Expanded(child: Container(),),

            // button for level 3
            ..._radioButtonEntry(level: 3, state: state),
            // gap
            SizedBox(width: 20,),
          ],
        ),
      ],
    );

  /// A radio button plus its label
  List<Widget> _radioButtonEntry({@required int level, @required FormFieldState<int> state}) {
    if (User.instance.getClearanceLevel() > level)
      return [
        // the button
        Radio<int> (
          value: level,
          groupValue: _group,
          onChanged: (int value) {
            state.didChange(level);
            setState(() => _group = value);
          },
        ),

        // Text describing the button
        Text(
          "Level " + level.toString(),
            style: Theme.of(context).textTheme.subhead,
        ),
      ];

    else 
      return [Container()];
  }
}