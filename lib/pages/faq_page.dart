import 'package:dwimay/strings.dart';
import 'package:flutter/material.dart';

/// The Frequently Asked Questions page
class FAQPage extends StatefulWidget {
  @override
  _FAQPageState createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),

      // adding the contents in a column so they appear one after
      // the other.
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: 20,), // used to add a gap between the contents.

          // the title
          Text(
            Strings.faqTitle,
            style: Theme.of(context).textTheme.title,
          ),
          SizedBox(height: 20,),

          // the questions and answers. Fill the remaining space available
          Flexible(

            // using [SingleChildScrollView] to get the scroll physics working
            // at both start and at the end.
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),

              // the list of questions and answers
              child: ListView.builder(
                controller: _scrollController, // needed to be able to scroll.
                shrinkWrap: true,
                itemCount: Strings.faqs.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    
                    // the question
                    title: Text(
                      Strings.faqs[index]['question'],
                      style: Theme.of(context).textTheme.body2,
                    ),

                    // the answer
                    subtitle: Text(
                      Strings.faqs[index]['answer'],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}