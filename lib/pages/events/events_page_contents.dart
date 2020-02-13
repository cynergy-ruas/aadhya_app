import 'dart:math';

import 'package:dwimay/strings.dart';
import 'package:dwimay_backend/dwimay_backend.dart';
import 'package:flutter/material.dart';

import 'carousel_card.dart';
import 'list_card.dart';

/// Shows all the events in a brief manner.
class EventsPageContents extends StatefulWidget {

  /// The events
  final List<Event> events;

  /// The passes
  final List<Pass> passes;

  /// The list of registered events
  final List<RegisteredEvent> regEvents;

  EventsPageContents({@required this.events, @required this.passes, this.regEvents});

  @override
  _EventsPageContentsState createState() => _EventsPageContentsState();
}

class _EventsPageContentsState extends State<EventsPageContents> {

  /// the index of the selected tab
  int _selected;

  /// the events of a day
  List<Event> events;

  /// The list of registered passes
  List<RegisteredEvent> _regPasses;

  @override
  void initState() {
    super.initState();

    // initializing selected to 1 (day 1)
    _selected = 1;

    // initializing the events of a day
    events = _filterEvents(day: _selected);

    // initializing the list of registered passes
    _regPasses = widget.regEvents?.where((RegisteredEvent event) => event.isPass)?.toList();
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
              Strings.eventsPageTitle,
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
        ]
        ..addAll(
          (_selected < 4)
          ? [
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
                    ..addAll(_eventsForDepartment(department: Department.All, displayName: Strings.eventsForAll))
                    ..addAll(_eventsForDepartment(department: Department.AerospaceAndAutomotive, displayName: Strings.aeroAndAuto))
                    ..addAll(_eventsForDepartment(department: Department.ComputerScience, displayName: Strings.cse))
                    ..addAll(_eventsForDepartment(department: Department.Civil, displayName: Strings.civil))
                    ..addAll(_eventsForDepartment(department: Department.ElectricAndElectronics, displayName: Strings.electricAndElectronics))
                    ..addAll(_eventsForDepartment(department: Department.Design, displayName: Strings.design))
                    ..addAll(_eventsForDepartment(department: Department.Mechanical, displayName: Strings.mechanical))
                    ..add(SizedBox(height: 100,))
                    ,
                  ),
                ),
              )
            ]
          : [
              // building the view for passes
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(left: 20.0),
                  physics: BouncingScrollPhysics(),
                  child: _buildPassesView()
                ),
              )
            ]
        ),
      ),
    );
  }

  /// Builds the view to show the passes
  Widget _buildPassesView() =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // title
        Text(
          Strings.passesViewTitle,
          style: Theme.of(context).textTheme.subhead.copyWith(
            fontWeight: FontWeight.bold
          ),
        ),

        // gap
        SizedBox(height: 20,),

        // the passes
        ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.only(right: 20),
          physics: BouncingScrollPhysics(),
          itemCount: widget.passes.length,
          itemBuilder: (BuildContext context, int index) {
            RegisteredEvent regPass = _regPasses?.firstWhere((regPass) => regPass.id == widget.passes[index].id, orElse: () => null);

            // the card
            return Padding(
              padding: const EdgeInsets.only(left: 30, right: 10),
              child: ListCard(pass: widget.passes[index], passEventNames: regPass?.eventNames ?? [],),
            );
          },
            
          separatorBuilder: (BuildContext context, int index) => 
            // gap
            SizedBox(height: 10,)
        ),

        SizedBox(height: 130,)
      ],
    );

  /// Builds the horizontal [ListView] for all the events
  Widget _allEventsCarousel() {
    return SizedBox( 
      // constraining the size of the [ListView]
      height: MediaQuery.of(context).size.height * 0.25 + 8,

      // the list view
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: events.length,
        itemBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 150, // constraining the width of the sized box
            child: CarouselCard(event: events[index],)
          );
        },
        separatorBuilder: (BuildContext context, int index) => 
          SizedBox(width: 15),
      ),
    );
  }

  /// Builds the title and the list of events per department
  List<Widget> _eventsForDepartment({@required Department department, @required String displayName}) {

    // getting the events that belong to the [department]
    List<Event> _events = events.where((e) => e.department == department.id).toList();
    
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
        padding: const EdgeInsets.only(left: 20.0),
        child: (_events.length > 0) // if there are events, then use a list view
                ? ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(right: 20),
                    physics: BouncingScrollPhysics(),
                    itemCount: _events.length,
                    itemBuilder: (BuildContext context, int index) =>
                      // the card
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 10),
                        child: ListCard(event: _events[index], day: _selected - 1,),
                      ),
                    separatorBuilder: (BuildContext context, int index) => 
                      // gap
                      SizedBox(height: 10,)
                  )
                : Text(Strings.noEventsMessage), // else display a text saying "no events"
      ),

      // gap
      SizedBox(height: 40,),
    ];
  }

  /// Builds the tab bar
  Widget _tabBar () {

    /// Function that builds a tab bar button
    Widget tabButton({int day, String title, VoidCallback onTap}) {
      // wrapping it in an [InkWell] to make it tappable
      return InkWell(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            (title == null) ? "Day " + day.toString() : title,
            style: Theme.of(context).textTheme.subhead.copyWith(
              color: (_selected == day) ? Theme.of(context).primaryColor : Theme.of(context).textTheme.body2.color,
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
              if (day < 4)
                events = _filterEvents(day: _selected);
            });
        }
      );
    }

    return Row(
      children: <Widget>[
        // day 1 tab
        tabButton(day: 1),

        // gap
        SizedBox(width: 10,),

        // day 2 tab
        tabButton(day: 2),

        // gap
        SizedBox(width: 10),

        // day 2 tab
        tabButton(day: 3),
      ]
      ..addAll(
        (widget.passes != null && widget.passes.length != 0)
        ? [
            // gap
            SizedBox(width: 10),
            
            // passes tab
            tabButton(day: 4, title: "Passes")
          ]
        : []
      ),
    );
  }

  /// Filters the events based on day, and sorts them based on time
  List<Event> _filterEvents({@required day}) {
    return Event.getEventsOfDay(day: _selected, events: widget.events)
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
