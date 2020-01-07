import 'package:flutter/material.dart';

class RegisteredEvents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // a column containing the contents
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        // gap
        SizedBox(height: 20,),

        // the small horizontal bar which indicates the location 
        // to pull the sheet from
        Container(
          height: 5,
          width: 50,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(20))
          ),
        ),

        // gap
        SizedBox(height: 20,),

        // the body
        Text("Registered Events", style: Theme.of(context).textTheme.title,)
      ],
    );
  }
}