import 'package:ihm_2020_3/src/model/abstracts/customs/custom_sprite_entity.dart';
import 'dart:ui';

import 'package:ihm_2020_3/src/model/entity/component/key_object.dart';

class KeyRed extends KeyObject{
  
  static final KeyRed _instance = KeyRed._();
  
  factory KeyRed() => _instance;

  KeyRed._() : super.fromPosition(1);

  @override
  void renderOn(Canvas canvas, CustomSpriteEntity e) {
    this.renderOnPositioned(canvas, e, onX: - 0.5, onY: 0.6);
  }

  @override
  int get keyCode => 4;

}