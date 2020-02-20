import 'package:dwimay/strings.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class FAQPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // title
          Text(
            Strings.faqTitle,
            style: Theme.of(context).textTheme.title,
          ),

          // gap
          SizedBox(
            height: 40,
          ),

          // the questions and answers
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ListView.separated(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: Strings.faqs.length,
                    itemBuilder: (BuildContext context, int index) => ListTile(
                      title: Text(
                        Strings.faqs[index]["question"],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      subtitle: Text(
                        Strings.faqs[index]["answer"],
                      ),
                    ),
                    separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(
                      height: 20,
                    ),
                  ),

                  SizedBox(height: 20,),

                  // POC vivek
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      Strings.faqPoc,
                      style: Theme.of(context).textTheme.subhead.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),

                  SizedBox(height: 5,),

                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      children: <Widget>[
                        FloatingActionButton(
                          child: Icon(
                            FontAwesomeIcons.phoneAlt,
                          ),
                          mini: true,
                          // iconSize: 20,
                          onPressed: () async {
                            String phoneNumber = "tel:93401 40230";
                            if (await canLaunch(phoneNumber))
                              await launch(phoneNumber);
                            else
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text(Strings.callError),
                                backgroundColor: Colors.red,
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Vivek Badani"),
                            SizedBox(
                              height: 5,
                            ),
                            Text("+91 93401 40230"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // gap
          SizedBox(
            height: 180,
          )
        ],
      ),
    );
  }
}
