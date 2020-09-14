import 'dart:ui';

import 'package:ihm_2020_3/src/model/abstracts/customs/custom_sprite_entity.dart';

mixin MixinEntityComponent{

  void renderOnPositioned(Canvas canvas, CustomSpriteEntity e, {double onX = 1.0, double onY = 1.0});
  void renderOn(Canvas canvas, CustomSpriteEntity e);

}