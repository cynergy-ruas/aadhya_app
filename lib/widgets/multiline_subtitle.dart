import 'package:dwimay/theme_data.dart';
import 'package:flutter/material.dart';

class MultilineSubtitle extends StatelessWidget {

  final List<MultilineSubtitleData> data;

  MultilineSubtitle({@required this.data});

  @override
  Widget build(BuildContext context) {  
    return Column(
      children: data.map<List<Widget>>(
        (MultilineSubtitleData data) =>
          [
            _constructRow(data),
            SizedBox(height: 8,)
          ]
        )
        .expand((i) => (i))
        .toList()
        ..add(SizedBox(height: 10,))
    );
  }

  Widget _constructRow(MultilineSubtitleData data) =>
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // alarm icon
        Icon(
          data.icon,
          size: 14.0,
        ),

        // gap
        SizedBox(
          width: 4.0,
        ),

        // date and time
        Text(
          data.text,
          style: Style.smallTextStyle,
        ),
      ],
    );
}

class MultilineSubtitleData {
  final IconData icon;
  final String text;

  MultilineSubtitleData({@required this.icon, @required this.text});
}