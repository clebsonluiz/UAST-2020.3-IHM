import 'dart:ui';

import 'package:ihm_2020_3/src/model/abstracts/customs/custom_sprite_entity.dart';
import 'package:ihm_2020_3/src/model/utils/game_model_constants.dart';

import 'key_object.dart';

class KeyGreen extends KeyObject {
  
  static final KeyGreen _instance = KeyGreen._();

  factory KeyGreen() => _instance;

  KeyGreen._() : super.fromPosition(4);

  @override
  void renderOn(Canvas canvas, CustomSpriteEntity e) {
    this.renderOnPositioned(canvas, e, onX: -0.7, onY: 0.9);
  }

  @override
  int get keyCode => ConstColorsCode.COLOR_GREEN;

}

class KeyYellow extends KeyObject {
  
  static final KeyYellow _instance = KeyYellow._();

  factory KeyYellow() => _instance;

  KeyYellow._() : super.fromPosition(3);

  @override
  void renderOn(Canvas canvas, CustomSpriteEntity e) {
    this.renderOnPositioned(canvas, e, onX: -0.9, onY: 1.2);
  }

  @override
  int get keyCode => ConstColorsCode.COLOR_YELLOW;

}

class KeyBlue extends KeyObject {

  static final KeyBlue _instance = KeyBlue._();

  factory KeyBlue() => _instance;

  KeyBlue._() : super.fromPosition(2);

  @override
  void renderOn(Canvas canvas, CustomSpriteEntity e) {
    this.renderOnPositioned(canvas, e, onX: -0.7, onY: 0.3);
  }

  @override
  int get keyCode => ConstColorsCode.COLOR_BLUE;
}

class KeyRed extends KeyObject{
  
  static final KeyRed _instance = KeyRed._();
  
  factory KeyRed() => _instance;

  KeyRed._() : super.fromPosition(1);

  @override
  void renderOn(Canvas canvas, CustomSpriteEntity e) {
    this.renderOnPositioned(canvas, e, onX: - 0.5, onY: 0.6);
  }

  @override
  int get keyCode => ConstColorsCode.COLOR_RED;

}

class KeyDark extends KeyObject {
  
  static final KeyDark _instance = KeyDark._();

  factory KeyDark() => _instance;

  KeyDark._() : super.fromPosition(0);

  @override
  void renderOn(Canvas canvas, CustomSpriteEntity e) {
    this.renderOnPositioned(canvas, e, onX: - 0.9, onY: 0.0);
  }

  @override
  int get keyCode => ConstColorsCode.COLOR_BLACK;
}
