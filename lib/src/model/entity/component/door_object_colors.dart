import 'package:ihm_2020_3/src/model/abstracts/customs/custom_sprite_animation.dart';
import 'package:ihm_2020_3/src/model/utils/game_model_constants.dart';

import 'door_object.dart';

class DoorObjectGreen extends DoorObject {
  static final _instance = DoorObjectGreen._();

  factory DoorObjectGreen() => _instance;

  DoorObjectGreen._() : super.empty() {
    customSpriteAnimation = CustomSpriteAnimation.fromAnimations([
      this
          .spriteSheet
          .createAnimation(0, toRow: 0, loop: true, scale: 0.2, stepTime: 0.1)
    ]);
  }

  @override
  int get colorCode => ConstColorsCode.COLOR_GREEN;
}

class DoorObjectYellow extends DoorObject {
  static final _instance = DoorObjectYellow._();

  factory DoorObjectYellow() => _instance;

  DoorObjectYellow._() : super.empty() {
    customSpriteAnimation = CustomSpriteAnimation.fromAnimations([
      this
          .spriteSheet
          .createAnimation(1, toRow: 1, loop: true, scale: 0.2, stepTime: 0.1)
    ]);
  }

  @override
  int get colorCode => ConstColorsCode.COLOR_YELLOW;
}

class DoorObjectBlue extends DoorObject {
  static final _instance = DoorObjectBlue._();

  factory DoorObjectBlue() => _instance;

  DoorObjectBlue._() : super.empty() {
    customSpriteAnimation = CustomSpriteAnimation.fromAnimations([
      this
          .spriteSheet
          .createAnimation(2, toRow: 2, loop: true, scale: 0.2, stepTime: 0.1)
    ]);
  }

  @override
  int get colorCode => ConstColorsCode.COLOR_BLUE;
}

class DoorObjectRed extends DoorObject {
  static final _instance = DoorObjectRed._();

  factory DoorObjectRed() => _instance;

  DoorObjectRed._() : super.empty() {
    customSpriteAnimation = CustomSpriteAnimation.fromAnimations([
      this
          .spriteSheet
          .createAnimation(3, toRow: 3, loop: true, scale: 0.2, stepTime: 0.1)
    ]);
  }

  @override
  int get colorCode => ConstColorsCode.COLOR_RED;
}

class DoorObjectWhite extends DoorObject {
  static final _instance = DoorObjectWhite._();

  factory DoorObjectWhite() => _instance;

  DoorObjectWhite._() : super.empty() {
    customSpriteAnimation = CustomSpriteAnimation.fromAnimations([
      this
          .spriteSheet
          .createAnimation(4, toRow: 4, loop: false, scale: 0.2, stepTime: 0.1)
    ]);
  }

  @override
  void setPosition({double x, double y}) {
    customSpriteAnimation.currentAnimation.reset();
    super.setPosition(x: x, y: y);
  }

  @override
  int get colorCode => ConstColorsCode.COLOR_WHITE;
}
