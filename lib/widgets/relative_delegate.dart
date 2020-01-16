import 'package:flutter/cupertino.dart';

enum Slot {
  bottom,
  top
}

class RelativeDelegate extends MultiChildLayoutDelegate {

  final FractionalOffset objectCenter;

  RelativeDelegate({@required this.objectCenter});

  @override
  void performLayout(Size size) {
    Size bottomWidgetSize = Size.zero;
    Offset bottomWidgetPos = Offset.zero;
    
    if (hasChild(Slot.bottom)) {
      bottomWidgetSize = layoutChild(Slot.bottom, BoxConstraints.loose(size));

      // center the top widget in the available space
      bottomWidgetPos = (size - bottomWidgetSize as Offset) * 0.5;
      positionChild(Slot.bottom, bottomWidgetPos);
    }

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