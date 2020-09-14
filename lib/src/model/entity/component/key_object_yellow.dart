import 'package:ihm_2020_3/src/model/abstracts/customs/custom_sprite_entity.dart';
import 'dart:ui';

import 'package:ihm_2020_3/src/model/entity/component/key_object.dart';

class KeyYellow extends KeyObject {
  
  static final KeyYellow _instance = KeyYellow._();

  factory KeyYellow() => _instance;

  KeyYellow._() : super.fromPosition(3);

  @override
  void renderOn(Canvas canvas, CustomSpriteEntity e) {
    this.renderOnPositioned(canvas, e, onX: -0.9, onY: 1.2);
  }

  @override
  int get keyCode => 2;

}
