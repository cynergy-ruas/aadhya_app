import 'package:flutter/material.dart';
import 'package:dwimay_backend/dwimay_backend.dart';

/// The card for the horizontal [ListView]/carousel
class CarouselCard extends StatelessWidget {

  /// The event that the card represents
  final Event event;

  CarouselCard({@required this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
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
    );
  }
}