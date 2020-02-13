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
      onLoaded: (List<Event> events, List<Pass> passes) {
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
                onLoading: LoadingWidget(),
                onLoaded: (BuildContext context, List<RegisteredEvent> registeredEvents) {
                  
                  if (registeredEvents == null || registeredEvents.length == 0) {
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
                    itemCount: registeredEvents.length,
                    itemBuilder: (BuildContext context, int index) {
                      RegisteredEvent reg = registeredEvents[index];

                      Event event;
                      Pass pass;

                      if (reg.isPass) {
                        pass = passes.firstWhere((pass) => pass.id == reg.id, orElse: () => null);
                      }
                      else {
                        event = events.firstWhere((event) => event.id == reg.id, orElse: () => null);
                      }

                      if (event != null || pass != null) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 40.0, right: 20),
                          child: ListCard(
                            event: event,
                            pass: pass,
                            passEventNames: reg.eventNames,
                            heroTag: (event?.id ?? pass.id) + "${Random().nextInt(1000)}",
                          ),
                        );
                      }

                      return Container();
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