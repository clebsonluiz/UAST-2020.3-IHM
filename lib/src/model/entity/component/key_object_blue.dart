import 'package:ihm_2020_3/src/model/abstracts/customs/custom_sprite_entity.dart';
import 'dart:ui';

import 'package:ihm_2020_3/src/model/entity/component/key_object.dart';

class KeyBlue extends KeyObject {

  static final KeyBlue _instance = KeyBlue._();

  factory KeyBlue() => _instance;

  KeyBlue._() : super.fromPosition(2);

  @override
  void renderOn(Canvas canvas, CustomSpriteEntity e) {
    this.renderOnPositioned(canvas, e, onX: -0.7, onY: 0.3);
  }

  @override
  int get keyCode => 3;
}
