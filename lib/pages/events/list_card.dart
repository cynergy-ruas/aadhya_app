import 'dart:math';

import 'package:dwimay/pages/details/info_card.dart';
import 'package:flutter/material.dart';
import 'package:dwimay_backend/dwimay_backend.dart';

/// The card for the 'per-department' [ListView].
class ListCard extends StatelessWidget {
  /// The event the card represents
  final Event event;

  /// The day. Used to select the correct datetime from
  /// the list of datetimes in the [Event].
  final int day;

  ListCard({@required this.event, @required this.day});

  @override
  Widget build(BuildContext context) {
    int index = 0;
    if (event.datetimes.length > 1)
      index = min(event.datetimes.length - 1, day); // used to avoid IndexErrors
    return InfoCard(event);
  }
}
