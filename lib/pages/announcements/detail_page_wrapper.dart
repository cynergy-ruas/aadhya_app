import 'package:dwimay/pages/details/detail_page.dart';
import 'package:dwimay/widgets/loading_widget.dart';
import 'package:dwimay_backend/dwimay_backend.dart';
import 'package:flutter/material.dart';

class DetailPageWrapper extends StatefulWidget {

  /// The id of the event
  final String eventID;

  DetailPageWrapper({@required this.eventID});

  @override
  _DetailPageWrapperState createState() => _DetailPageWrapperState();
}

class _DetailPageWrapperState extends State<DetailPageWrapper> {

  /// The bloc. Using a new bloc since using the 
  /// root [EventLoadBloc] causes errors after dismissing
  /// the [Announcement].
  EventLoadBloc _bloc;

  @override
  void initState() {
    super.initState();

    // initialing the bloc
    _bloc = EventLoadBloc();
  }

  @override
  Widget build(BuildContext context) {
    return EventLoader(
      beginLoad: true,
      bloc: _bloc,
      onLoading: Scaffold(body: Center(child: LoadingWidget()),),
      onLoaded: (List<Event> events) {

        // getting the event from the event id
        Event event = events.firstWhere((event) => event.id == widget.eventID);

        return DetailPage(
          event: event,
          day: 0,
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();

    // closing the bloc
    _bloc.close();
  }
}