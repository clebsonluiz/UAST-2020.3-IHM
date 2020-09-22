import 'package:flame/components/component.dart';
import 'package:ihm_2020_3/src/model/abstracts/customs/custom_sprite_animation.dart';
import 'package:ihm_2020_3/src/model/utils/const_colors.dart';

import 'door_object.dart';

class DoorObjectWhite extends DoorObject{
  
  static final _instance = DoorObjectWhite._();

  factory DoorObjectWhite() => _instance;

  CustomSpriteAnimation _customSpriteAnimation;

 
  DoorObjectWhite._() : super.empty(){
    _customSpriteAnimation = CustomSpriteAnimation.fromAnimations([
      this.spriteSheet.createAnimation(5, toRow: 5, loop: false, scale: 0.2, stepTime: 0.1)
    ]);
  }

  @override
  void setPosition({double x, double y}) {
    _customSpriteAnimation.currentAnimation.reset();
    super.setPosition(x:x, y:y);
  }

  @override
  int get colorCode => ConstColors.COLOR_WHITE;

  @override
  SpriteComponent get component => _customSpriteAnimation.currentSpriteFrame;

  void update(double dt){
    _customSpriteAnimation.update(dt);
  }

}