import 'package:flame/components/component.dart';
import 'package:ihm_2020_3/src/model/abstracts/customs/custom_sprite_animation.dart';
import 'package:ihm_2020_3/src/model/utils/const_colors.dart';

import 'door_object.dart';

class DoorObjectGreen extends DoorObject{
  
  static final _instance = DoorObjectGreen._();

  factory DoorObjectGreen() => _instance;

  CustomSpriteAnimation _customSpriteAnimation;

 
  DoorObjectGreen._() : super.empty(){
    _customSpriteAnimation = CustomSpriteAnimation.fromAnimations([
      this.spriteSheet.createAnimation(0, toRow: 0, loop: true, scale: 0.2, stepTime: 0.1)
    ]);
  }

  @override
  int get colorCode => ConstColors.COLOR_GREEN;

  @override
  SpriteComponent get component => _customSpriteAnimation.currentSpriteFrame;

  void update(double dt){
    _customSpriteAnimation.update(dt);
  }

}