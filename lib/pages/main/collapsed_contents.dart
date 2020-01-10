import 'package:flutter/material.dart';

/// contents of the bottom sheet when its collapsed
class CollapsedContents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF222831),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // gap
          SizedBox(height: 10,),

          // the small horizontal bar which indicates the location 
          // to pull the sheet from
          Container(
            height: 5,
            width: 30,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(20))
            ),
          ),

          // gap
          SizedBox(height: 7,),

          // title
          Text(
            "Pass",
            style: Theme.of(context).textTheme.title.copyWith(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}