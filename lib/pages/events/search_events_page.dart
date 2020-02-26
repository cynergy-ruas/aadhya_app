import 'dart:io';

import 'package:dwimay_backend/dwimay_backend.dart';
import 'package:flutter/material.dart';

import 'list_card.dart';

/// A page that is used to search events
class SearchEventsPage extends StatefulWidget {

  /// The list of events
  final List<Event> events;

  SearchEventsPage({@required this.events});

  @override
  _SearchEventsPageState createState() => _SearchEventsPageState();
}

class _SearchEventsPageState extends State<SearchEventsPage> {

  /// List containing the filtered events
  List<Event> _filteredEvents;

  /// The controller for the text field
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    // initializing the filtered list
    _filteredEvents = List<Event>();

    // initializing the controller
    _controller = TextEditingController();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // The title of the page
              Text(
                "Search",
                style: Theme.of(context).textTheme.title,
              ),
              
              // gap
              SizedBox(height: 20,),

              // Search text field
              Row(
                children: <Widget>[
                  // the back button
                  InkWell(
                    child: Icon(Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back),
                    onTap: () => Navigator.of(context).pop()
                  ),

                  // gap
                  SizedBox(width: 10,),

                  // the text field
                  Expanded(
                    child: TextField(
                      
                      controller: _controller,
                      autofocus: true,
                      style: Theme.of(context).textTheme.body1,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(hintText: "Search an event"),
                      onChanged: (String value) {
                        setState(() {
                          _filterEvents(value);
                        });
                      }
                    ),
                  ),

                  // gap
                  SizedBox(width: 10,),

                  // the clear button
                  InkWell(
                    child: Icon(Icons.clear),
                    onTap: () => setState(() {
                      _controller.text = "";
                      _filterEvents("");
                    })
                  )
                ],
              ),

              SizedBox(height: 20,),

              Expanded(
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemCount: _filteredEvents.length,
                  itemBuilder: (BuildContext context, int index) =>
                    // the card
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 10),
                      child: ListCard(event: _filteredEvents[index], useAllDates: true,),
                    ),
                  separatorBuilder: (BuildContext context, int index) => 
                    SizedBox(height: 10,),
                ),
              )
            ],
          ),
        ),
      )
    );
  }

  /// filters events based on input string. The filter is applied on the 
  /// name of the event and the name of the department of the event.
  void _filterEvents(String searchString) {
    RegExp reg = new RegExp(searchString, caseSensitive: false);
    _filteredEvents = widget.events.where(
      (event) => reg.hasMatch(event.name) || reg.hasMatch(DepartmentExtras.getNameFromId(event.department))
    ).toList();
  }
}