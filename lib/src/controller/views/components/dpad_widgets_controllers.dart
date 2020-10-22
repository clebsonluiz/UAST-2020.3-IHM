import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ihm_2020_3/src/view/components/dpad_buttom_widget.dart';
import 'package:ihm_2020_3/src/view/components/dpad_joystick_widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class DpadJoystickController extends ControllerMVC {
  Offset get deltaOffset => this._delta;

  Offset _delta = Offset.zero;

  void _updateDelta(Offset newDelta) {
    JoystickDirection direction;

    if (newDelta.dx < 0.0)
      direction = JoystickDirection.LEFT;
    else if (newDelta.dx > 0.0)
      direction = JoystickDirection.RIGHT;
    else
      direction = JoystickDirection.NONE;

    (this.state.widget as DpadJoystickWidget).onChange(newDelta, direction);
    setState(() => _delta = newDelta);
  }

  void _calculateDelta(Offset offset) {
    Offset newDelta = offset - Offset(60, 60);
    _updateDelta(
      Offset.fromDirection(
        newDelta.direction,
        min(30, newDelta.distance),
      ),
    );
  }

  void onDragDown(DragDownDetails d) => _calculateDelta(d.localPosition);

  void onDragUpdate(DragUpdateDetails d) => _calculateDelta(d.localPosition);

  void onDragEnd(DragEndDetails d) => _updateDelta(Offset.zero);
}

enum JoystickDirection { LEFT, RIGHT, NONE }

class DpadButtonController extends ControllerMVC {
  bool _holding = false;
 
  bool get holding => this._holding;
 
  void onTapDown(TapDownDetails tdd) {
    setState(() => _holding = true);
    (this.state.widget as DpadButtonWidget).onAction();
  }

  void onTapUp(TapUpDetails tud) {
    setState(() => _holding = false);
  }

  void onTapCancel() {
    setState(() => _holding = false);
  }
}
