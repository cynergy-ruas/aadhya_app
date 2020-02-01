import 'package:dwimay/strings.dart';
import 'package:flutter/material.dart';

/// contents of the bottom sheet when its collapsed
class CollapsedContents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
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
          SizedBox(height: 15,),

          // title
          Text(
            Strings.collapsedSheetTitle,
            style: Theme.of(context).textTheme.title,
          ),
        ],
      ),
    );
  }
}