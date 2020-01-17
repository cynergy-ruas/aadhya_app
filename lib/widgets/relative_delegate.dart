import 'package:flutter/cupertino.dart';

enum Slot {
  bottom,
  top
}

/// Layout delegate that positions a [top] widget at the 
/// center of a [bottom] widget, given its [objectCenter].
class RelativeDelegate extends MultiChildLayoutDelegate {

  /// The offset that defines where the center
  /// of the top widget should be.
  final FractionalOffset objectCenter;

  RelativeDelegate({@required this.objectCenter});

  @override
  void performLayout(Size size) {
    Size bottomWidgetSize = Size.zero;
    Offset bottomWidgetPos = Offset.zero;
    
    // performing layout for the bottom widget
    if (hasChild(Slot.bottom)) {
      bottomWidgetSize = layoutChild(Slot.bottom, BoxConstraints.loose(size));

      // center the top widget in the available space
      bottomWidgetPos = (size - bottomWidgetSize as Offset) * 0.5;
      positionChild(Slot.bottom, bottomWidgetPos);
    }

    // performing layout for the top widget
    if (hasChild(Slot.top)) {
      Size topWidgetSize = layoutChild(Slot.top, BoxConstraints());
      positionChild(
        Slot.top, 
        bottomWidgetPos + objectCenter.alongSize(bottomWidgetSize) - topWidgetSize.center(Offset.zero)
      );
    }
  }

  @override
  bool shouldRelayout(MultiChildLayoutDelegate oldDelegate) => false;
}