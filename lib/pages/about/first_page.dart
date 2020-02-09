import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[ 
          SvgPicture.asset(
            "assets/svg/fest_logo.svg",
          ),

          Container(
            width: double.infinity,
            padding: EdgeInsets.only(right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                // gap
                SizedBox(height: 20,),

                
                Text(
                  "evolve.",
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.title.copyWith(
                    color: Theme.of(context).primaryColor
                  ),
                ),

                // gap
                SizedBox(height: 10,),

                Text(
                  "engage.",
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.title.copyWith(
                    color: Theme.of(context).primaryColor
                  ),
                ),

                // gap
                SizedBox(height: 10,),

                Text(
                  "elevate.",
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.title.copyWith(
                    color: Theme.of(context).primaryColor
                  ),
                ),
              ],
            ),
          )
        ]
      ),
    );
  }
}