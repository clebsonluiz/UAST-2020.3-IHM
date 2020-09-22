import 'package:flame/components/component.dart';
import 'package:ihm_2020_3/src/model/abstracts/customs/custom_sprite_animation.dart';
import 'package:ihm_2020_3/src/model/utils/const_colors.dart';

import 'door_object.dart';

class DoorObjectBlue extends DoorObject{
  
  static final _instance = DoorObjectBlue._();

  factory DoorObjectBlue() => _instance;

  CustomSpriteAnimation _customSpriteAnimation;

 
  DoorObjectBlue._() : super.empty(){
    _customSpriteAnimation = CustomSpriteAnimation.fromAnimations([
      this.spriteSheet.createAnimation(2, toRow: 2, loop: true, scale: 0.2, stepTime: 0.1)
    ]);
  }

  @override
  int get colorCode => ConstColors.COLOR_BLUE;

  @override
  SpriteComponent get component => _customSpriteAnimation.currentSpriteFrame;

  void update(double dt){
    _customSpriteAnimation.update(dt);
  }

}