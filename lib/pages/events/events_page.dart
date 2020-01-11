import 'package:dwimay/pages/events/events_page_contents.dart';
import 'package:dwimay/pages/login_profile/login_loading.dart';
import 'package:dwimay_backend/dwimay_backend.dart';
import 'package:flutter/material.dart';

class EventsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: EventLoader(
        beginLoad: true,

        onUninitialized: Container(),

        onLoading: LoadingWidget(),

        onLoaded: (List<Event> events) {
          return EventsPageContents(
            events: events,
          );
        },

        onError: (BuildContext context, dynamic e) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                "Error loading events. Please try again.",
                style: Theme.of(context).textTheme.body1.copyWith(
                  color: Colors.white
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}