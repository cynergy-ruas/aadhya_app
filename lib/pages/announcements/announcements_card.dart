import 'package:dwimay_backend/dwimay_backend.dart';
import 'package:flutter/material.dart';

/// The card displaying brief information of an announcement
/// / notification
class AnnouncementCard extends StatelessWidget {

  final Announcement announcement;

  AnnouncementCard({@required this.announcement});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: ListTile(
        title: Text(announcement.title),
        subtitle: Text(announcement.body),
      ),
    );
  }
}