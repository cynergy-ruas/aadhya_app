import 'package:dwimay/strings.dart';
import 'package:dwimay/theme_data.dart';
import 'package:dwimay/widgets/page_header.dart';
import 'package:flutter/material.dart';

/// The page displaying the faq
class FAQPage extends StatelessWidget {

  /// The height of the page header thumbnail
  final double thumbnailHeight = 80;

  /// The width of the page header thumbnail
  final double thumbnailWidth = 80;

  @override
  Widget build(BuildContext context) {

    // building the detail page
    return Scaffold(
      body: Container(
        // expan to fit the device
        constraints: BoxConstraints.expand(),
        // background color
        color: Color(0xFF3E3963),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Stack(
            children: <Widget>[
              // the background image of the detail page
              _buildBackground(),
              // building the coustom gradient color
              _buildGradient(),
              // the content of the detail page
              _buildContent(),
              // the toolbar (back button)
              _buildToolbar(context),
            ],
          ),
        ),
      ),
    );
  }

  /// the background image of the detail page
  Widget _buildBackground() {
    return Container(
      // TODO: use  [Image.asset] instead of network image
      child: Image.network(
        "https://image.shutterstock.com/image-vector/flat-line-design-website-banner-600w-389761060.jpg",
        fit: BoxFit.cover,
        height: 300.0,
      ),
      constraints: new BoxConstraints.expand(height: 295.0),
    );
  }

  /// building the background gradient color that covers the bg-image
  Widget _buildGradient() {
    return Container(
      margin: EdgeInsets.only(top: 190.0),
      height: 110.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            // the transperent color
            Color(0x003E3963),
            // the main color
            Color(0xFF3E3963),
          ],
          stops: [0.0, 0.9],
          // The offset at which stop 0.0 of the gradient is placed
          begin: FractionalOffset(0.0, 0.0),
          // The offset at which stop 1.0 of the gradient is placed.
          end: FractionalOffset(0.0, 1.0),
        ),
      ),
    );
  }

  /// the seperator used to sepertate title from content
  Widget separator() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          margin: new EdgeInsets.symmetric(vertical: 8.0),
          height: 2.0,
          width: 18.0,
          color: new Color(0xff00c6ff),
        )
      ],
    );
  }

  /// the main content of the detail page
  Widget _buildContent() {
    
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 72.0, 20.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          
          // gap
          SizedBox(height: 60,),

          // the header card
          PageHeader(
            title: Padding(
              padding: const EdgeInsets.only(left: 70.0, right: 70.0, top: 20.0),
              child: Text(
                Strings.faqTitle,
                style: Style.titleTextStyle,
                textAlign: TextAlign.center,
              ),
            ),

            thumbnail: Image.asset(
              "assets/images/faq.png",
              height: thumbnailHeight,
              width: thumbnailWidth,
            ),

            thumbnailHeight: thumbnailHeight,

            thumbnailWidth: thumbnailWidth,
          ),

          // gap
              SizedBox(height: 20,),

          // title
          Text(
            "Some frequently asked questions",
            style: Style.headerTextStyle,
          ),

          //seperator
          separator(),

          // the event overview or decription
          ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: Strings.faqs.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) => 
              ListTile(
                title: Text(
                  Strings.faqs[index]["question"],
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  Strings.faqs[index]["answer"],
                  style: TextStyle(color: Colors.white38),
                ),
              ),
          )
        ],
      ),
    );
  }

  /// building the toolbar
  /// it contains the back button
  Widget _buildToolbar(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: BackButton(color: Colors.white),
    );
  }
}
