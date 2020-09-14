import 'package:ihm_2020_3/src/model/abstracts/customs/custom_sprite_entity.dart';
import 'dart:ui';

import 'package:ihm_2020_3/src/model/entity/component/key_object.dart';

class KeyGreen extends KeyObject {
  
  static final KeyGreen _instance = KeyGreen._();

  factory KeyGreen() => _instance;

  KeyGreen._() : super.fromPosition(4);

  @override
  void renderOn(Canvas canvas, CustomSpriteEntity e) {
    this.renderOnPositioned(canvas, e, onX: -0.7, onY: 0.9);
  }

  @override
  int get keyCode => 1;

}
