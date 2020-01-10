import 'dart:math';

import 'package:dwimay_backend/dwimay_backend.dart';
import 'package:flutter/material.dart';

import 'carousel_card.dart';
import 'list_card.dart';

/// Shows all the events in a brief manner.
class EventsPageContents extends StatefulWidget {

  final List<Event> events;

  EventsPageContents({@required this.events});

  @override
  _EventsPageContentsState createState() => _EventsPageContentsState();
}

class _EventsPageContentsState extends State<EventsPageContents> {

  /// the index of the selected tab
  int _selected;

  /// the events of a day
  List<Event> events;

  @override
  void initState() {
    super.initState();

    // initializing selected to 1 (day 1)
    _selected = 1;

    // initializing the events of a day
    events = _filterEvents(day: _selected);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
      
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          // the title of the page
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              "Events",
              style: Theme.of(context).textTheme.title,
            ),
          ),

          // gap
          SizedBox(height: 10,),

          // the tab bar
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: _tabBar(),
          ),

          // gap
          SizedBox(height: 20,),

          // the events
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  // The horizontal carousel having all events
                  _allEventsCarousel(),
                  
                  // gap
                  SizedBox(height: 40,),  
                ]
                // the following are the events per department
                ..addAll(_eventsForDepartment(department: Department.All, displayName: "For All"))
                ..addAll(_eventsForDepartment(department: Department.AerospaceAndAutomotive, displayName: "Aerospace and Automative"))
                ..addAll(_eventsForDepartment(department: Department.ComputerScience, displayName: "Computer Science"))
                ..addAll(_eventsForDepartment(department: Department.ElectricAndElectronics, displayName: "Electrical and Electronics"))
                ..addAll(_eventsForDepartment(department: Department.Design, displayName: "Design"))
                ..addAll(_eventsForDepartment(department: Department.Mechanical, displayName: "Mechanical"))
                ..add(SizedBox(height: 180,))
                ,
              ),
            ),
          )
          
        ],
      ),
    );
  }

  /// Builds the horizontal [ListView] for all the events
  Widget _allEventsCarousel() {
    return SizedBox( 
      // constraining the size of the [ListView]
      height: MediaQuery.of(context).size.height * 0.25,

      // the list view
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 20),
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: events.length,
        itemBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 150, // constraining the width of the sized box
            child: CarouselCard(event: events[index],)
          );
        },
      ),
    );
  }

  /// Builds the title and the list of events per department
  List<Widget> _eventsForDepartment({@required String department, @required String displayName}) {

    // getting the events that belong to the [department]
    List<Event> _events = events.where((e) => e.department == department).toList();
    
    return [

      // the department name
      Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Text(
          displayName,
          style: Theme.of(context).textTheme.subhead.copyWith(
            fontWeight: FontWeight.bold
          ),
        ),
      ),

      // gap
      SizedBox(height: 20,),

      // the events
      Padding(
        padding: const EdgeInsets.only(left:20.0),
        child: (_events.length > 0) // if there are events, then use a list view
                ? ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(right: 20),
                  physics: BouncingScrollPhysics(),
                  itemCount: _events.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListCard(event: _events[index], day: _selected - 1,);
                  },
                )
                : Text("No Events"), // else display a text saying "no events"
      ),

      // gap
      SizedBox(height: 40,),
    ];
  }

  /// Builds the tab bar
  Widget _tabBar () {

    /// Function that builds a tab bar button
    Widget tabButton({int day}) {
      // wrapping it in an [InkWell] to make it tappable
      return InkWell(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Day " + day.toString(),
            style: Theme.of(context).textTheme.subhead.copyWith(
              color: (_selected == day) ? Theme.of(context).accentColor : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        onTap: () {
          // if a different tab than the currently selected tab is tapped, then
          // execute if body
          if (day != _selected)
            setState(() {
              _selected = day;
              events = _filterEvents(day: _selected);
            });
        },
      );
    }

    return Row(
      children: <Widget>[
        // day 1 tab
        tabButton(day: 1),

        // gap
        SizedBox(width: 20,),

        // day 2 tab
        tabButton(day: 2),

        // gap
        SizedBox(width: 20),

        // day 2 tab
        tabButton(day: 3),
      ],
    );
  }

  /// Filters the events based on day, and sorts them based on time
  List<Event> _filterEvents({@required day}) {
    return EventPool.getEventsOfDay(day: _selected, events: widget.events)
                    ..sort((Event a, Event b) {
                      int indexA = 0;
                      int indexB = 0;

                      // getting the index of the correct element
                      // in the [Event.datetimes] list. it is calculated
                      // by checking if the length of the list is more than 1.
                      // if it is, then the minimum of the current day - 1 (one
                      // subtracted so that it can be used to index the array)
                      // and the total length of the list is taken as the index.
                      if (a.datetimes.length > 1)
                        indexA = min(a.datetimes.length - 1, day - 1);
                      
                      if (b.datetimes.length > 1)
                        indexB = min(b.datetimes.length - 1, day - 1);

                      return a.datetimes[indexA].compareTo(b.datetimes[indexB]);
                    });
  }
}
