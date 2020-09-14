import 'package:ihm_2020_3/src/model/abstracts/customs/custom_sprite_entity.dart';
import 'dart:ui';

import 'package:ihm_2020_3/src/model/entity/component/key_object.dart';

class KeyDark extends KeyObject {
  
  static final KeyDark _instance = KeyDark._();

  factory KeyDark() => _instance;

  KeyDark._() : super.fromPosition(0);

  @override
  void renderOn(Canvas canvas, CustomSpriteEntity e) {
    this.renderOnPositioned(canvas, e, onX: - 0.9, onY: 0.0);
  }

  @override
  int get keyCode => 6;
}
