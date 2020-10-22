import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:ihm_2020_3/src/controller/views/components/dpad_widgets_controllers.dart';

mixin MixinGameActions {

  void actionObjective();

  void actionButtonOne();
  void actionButtonTwo();
  void actionButtonTree();
  void actionButtonFour();

  void actionMovement(Offset offset, JoystickDirection direction);

}