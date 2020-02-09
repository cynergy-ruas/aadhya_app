import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {

  /// variable that defines whether the countdown should be shown or not
  bool _displayCountDown;

  /// The date of the fest
  final DateTime festDate = DateTime(2020, 2, 28);

  @override
  void initState() {
    super.initState();

    // initializng [_displayCountDown]
    if (DateTime.now().compareTo(festDate) >= 0)
      _displayCountDown = false;
    else
      _displayCountDown = true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // the fest logo
          SvgPicture.asset(
            "assets/svg/fest_logo.svg",
          ),

          // row containing the count down timer and the tag line
          Row(
            children: <Widget>[]
            ..addAll(
              // displaying countdown if it should be displayed
              (_displayCountDown)
              ? 
                [
                  Expanded(child: Container(),), 
                  CountdownTimer(
                    endTime: festDate.millisecondsSinceEpoch,
                    textStyle: TextStyle(fontSize: 30, color: Theme.of(context).primaryColor),
                    daysSymbol: "\t\t",
                    hoursSymbol: ":",
                    secSymbol: "",
                    minSymbol: ":",
                    onEnd: () => setState(() => _displayCountDown = false),
                  )
                ]
              : [
                  Expanded(child: Container(),),
                ]
            )
            ..addAll([
              // the rag line
              Expanded(child: Container(),),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Column(
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
                ],
              )
            ])  
          )
        ]
      ),
    );
  }
}