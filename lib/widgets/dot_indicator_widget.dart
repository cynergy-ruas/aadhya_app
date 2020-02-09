import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

/// The dots indicator widget that is controlled
/// by a [PageController].
class DotIndicatorWidget extends StatefulWidget {

  /// [PageController] that controls which dot is highlighted
  final PageController controller;

  /// The number of dots
  final int dotCount;

  /// The axis, whether horizontal or vertical
  final Axis axis;

  DotIndicatorWidget({@required this.controller, @required this.dotCount, this.axis = Axis.vertical});
  
  @override
  _DotIndicatorWidgetState createState() => _DotIndicatorWidgetState();
}

class _DotIndicatorWidgetState extends State<DotIndicatorWidget> {

  /// [PageController] that controls which dot is highlighted
  PageController get _controller => widget.controller;

  /// The current page, used to know which dot to highlight
  double _currentPage;

  @override
  void initState() {
    super.initState();

    // initializing [_currentPage]
    _currentPage = 0;

    // adding listener to the page controller that will update
    // the [_currentPage] when the page changes.
    _controller.addListener(() {
      if (_controller.page.round() != _currentPage && this.mounted) {
        setState(() {
          _currentPage = _controller.page.round().toDouble();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DotsIndicator(
      dotsCount: widget.dotCount,
      position: _currentPage,
      axis: widget.axis,
      decorator: DotsDecorator(
        activeColor: Theme.of(context).accentColor,
        color: Theme.of(context).disabledColor
      ),
    );
  }
}