import 'package:flutter/material.dart';

/// The background of the details page
class DetailPageBackground extends StatelessWidget {

  /// The place from where the gradient should start
  final double gradientStart;

  /// The height of the gradient
  final double gradientHeight;

  DetailPageBackground({@required this.gradientStart, @required this.gradientHeight});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // background image
        Image.network(
          // TODO: use  [Image.asset] instead of network image
          "https://www.sxsw.com/wp-content/uploads/2019/06/2019-Hackathon-Photo-by-Randy-and-Jackie-Smith.jpg",
          fit: BoxFit.cover,
          height: gradientStart + gradientHeight,
          color: Theme.of(context).backgroundColor.withAlpha(128),
          colorBlendMode: BlendMode.hardLight,
        ),

        // the gradient
        Container(
          margin: EdgeInsets.only(top: gradientStart),
          height: gradientHeight,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                // the transparent color
                Theme.of(context).backgroundColor.withAlpha(0),
                // the main color
                Theme.of(context).backgroundColor,
              ],
              stops: [0.0, 0.9],
              // The offset at which stop 0.0 of the gradient is placed
              begin: FractionalOffset(0.0, 0.0),
              // The offset at which stop 1.0 of the gradient is placed.
              end: FractionalOffset(0.0, 1.0),
            ),
          ),
        ),
      ],
    );
  }
}