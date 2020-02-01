import 'dart:math';

import 'package:dwimay/pages/events/list_card.dart';
import 'package:dwimay/strings.dart';
import 'package:dwimay/widgets/build_button.dart';
import 'package:dwimay/widgets/loading_widget.dart';
import 'package:dwimay_backend/dwimay_backend.dart';
import 'package:flutter/material.dart';

class RegisteredEventsPage extends StatelessWidget {

  final void Function() onBackPressed;

  RegisteredEventsPage({@required this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return EventLoader(
      beginLoad: true,
      onLoading: LoadingWidget(),
      onLoaded: (List<Event> events) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // The title of the page
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Text(
                Strings.registeredEvents,
                style: Theme.of(context).textTheme.title,
              ),
            ),

            // gap
            SizedBox(height: 20,),

            // The events
            Expanded(
              child: RegisteredEventsLoader(
                onLoading: Container(),
                onLoaded: (BuildContext context, List<String> eventIds) {
                  if (eventIds == null || eventIds.length == 0) {
                    return Center(
                      child: Text(
                        Strings.noRegEvents,
                        style: Theme.of(context).textTheme.body2,
                      ),
                    );
                  }
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: eventIds.length,
                    itemBuilder: (BuildContext context, int index) {
                      Event event = EventPool.events.firstWhere((event) => event.id == eventIds[index], orElse: () => null);
                      return Padding(
                        padding: const EdgeInsets.only(left: 40.0, right: 20),
                        child: ListCard(
                          event: event,
                          day: 0,
                          heroTag: event.id + "${Random().nextInt(1000)}",
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) => 
                      SizedBox(height: 10,),
                  );
                },
              ),
            ),
            
            // gap
            SizedBox(height: 20,),

            // Back button
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: BuildButton(
                data: Strings.backButton,
                onPressed: onBackPressed,
                padding: const EdgeInsets.symmetric(vertical: 10),
              ),
            ),

            SizedBox(height: 20,)
          ],
        );
      },
    );
  }
}