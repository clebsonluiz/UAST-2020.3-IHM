import 'package:flame/components/component.dart';
import 'package:ihm_2020_3/src/model/abstracts/customs/custom_sprite_animation.dart';
import 'package:ihm_2020_3/src/model/utils/const_colors.dart';

import 'door_object.dart';

class DoorObjectRed extends DoorObject{
  
  static final _instance = DoorObjectRed._();

  factory DoorObjectRed() => _instance;

  CustomSpriteAnimation _customSpriteAnimation;

 
  DoorObjectRed._() : super.empty(){
    _customSpriteAnimation = CustomSpriteAnimation.fromAnimations([
      this.spriteSheet.createAnimation(4, toRow: 4, loop: true, scale: 0.2, stepTime: 0.1)
    ]);
  }

  @override
  int get colorCode => ConstColors.COLOR_RED;

  @override
  SpriteComponent get component => _customSpriteAnimation.currentSpriteFrame;

  void update(double dt){
    _customSpriteAnimation.update(dt);
  }

}