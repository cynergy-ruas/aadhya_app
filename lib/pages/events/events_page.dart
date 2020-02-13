import 'package:dwimay/pages/events/events_page_contents.dart';
import 'package:dwimay/widgets/loading_widget.dart';
import 'package:dwimay_backend/dwimay_backend.dart';
import 'package:flutter/material.dart';

class EventsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return EventLoader(
      bloc: BackendProvider.of<EventLoadBloc>(context),
      
      beginLoad: true,

      onUninitialized: Container(),

      onLoading: LoadingWidget(),

      onLoaded: (List<Event> events, List<Pass> passes) {
        if (! User.instance.isLoggedIn || User.instance.getClearanceLevel() != 0) 
          return EventsPageContents(
            events: events,
            passes: passes,
          );

        return RegisteredEventsLoader(
          onLoading: LoadingWidget(),
          onLoaded: (BuildContext context, List<RegisteredEvent> regEvents) =>
            EventsPageContents(
              events: events,
              passes: passes,
              regEvents: regEvents,
            ),
        );
      },

      onError: (BuildContext context, dynamic e) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "Error loading events. Please try again.",
              style: Theme.of(context).textTheme.body1,
            ),
          ),
        );
      },
    );
  }
}