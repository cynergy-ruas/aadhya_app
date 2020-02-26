import 'package:dwimay/pages/details/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:dwimay_backend/dwimay_backend.dart';

/// The card for the horizontal [ListView]/carousel
class CarouselCard extends StatelessWidget {

  /// The event that the card represents
  final Event event;

  /// The selected day
  final int day;

  CarouselCard({@required this.event, @required this.day});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0),),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // the date
              Text(
                event.getTime()
              ),

              // gap
              SizedBox(height: 10,),

              // the title
              Text(
                event.name,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),

      onTap: () => Navigator.of(context).push(
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 500),
          pageBuilder: (_, __, ___) => DetailPage(
            event: event,
            day: day,
          ),
          transitionsBuilder:
              (context, animation, secondaryAnimation, child) =>
                  FadeTransition(opacity: animation, child: child),
        ),
      )
    );
  }
}