import 'package:dwimay/strings.dart';
import 'package:flutter/material.dart';

class FAQPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // title
          Text(
            Strings.faqTitle,
            style: Theme.of(context).textTheme.title,
          ),

          // gap
          SizedBox(height: 40,),

          // the questions and answers
          Expanded(
            child: ListView.separated(
              physics: BouncingScrollPhysics(),
              itemCount: Strings.faqs.length,
              itemBuilder: (BuildContext context, int index) => 
                ListTile(
                  title: Text(
                    Strings.faqs[index]["question"],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    Strings.faqs[index]["answer"],
                  ),
                ),
              separatorBuilder: (BuildContext context, int index) => 
                SizedBox(height: 20,),
            ),
          ),

          // gap
          SizedBox(height: 140,)
        ],
      ),
      
    );
  }
}