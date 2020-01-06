import 'package:flutter/material.dart';
import 'package:dwimay_backend/dwimay_backend.dart';
import 'package:dwimay/pages/detail_page.dart';

class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  /// Global key for accessing the state of the [EventLoader].
  /// Used to begin loading the events
  final GlobalKey<EventLoaderState> loaderKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    ListTile makeListTile(Event event) => ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.white24))),
            child: Icon(Icons.autorenew, color: Colors.white),
          ),
          title: Text(
            event.name,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

          subtitle: Row(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(event.description,
                        style: TextStyle(color: Colors.white))),
              )
            ],
          ),
          trailing:
              Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailPage(
                          event: event,
                        )));
          },
        );

    Card makeCard(Event event) => Card(
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          child: Container(
            decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
            child: makeListTile(event),
          ),
        );

    makeBody(List<Event> events) => Container(
          // decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: events.length,
            itemBuilder: (BuildContext context, int index) {
              return makeCard(events[index]);
            },
          ),
        );

    return Scaffold(
      body: Center(
        // using a [Builder] widget so that snackbars can be
        // shown.
        child: EventLoader(
          key: loaderKey,

          // widget to display when the event loading has not begun.
          onUninitialized:
              Text("Events", style: Theme.of(context).textTheme.title),

          // widget to display when the event loading is going on.
          onLoading: CircularProgressIndicator(),

          // widget to display when the events are loaded.
          onLoaded: (List<Event> events) {
            return makeBody(events);
          },

          onError: (BuildContext context, Exception e) =>
              Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('${e.toString()}'),
            backgroundColor: Colors.red,
          )),

          beginLoad: true,
        ),
      ),
    );
  }
}
