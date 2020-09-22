import 'package:flame/components/component.dart';
import 'package:ihm_2020_3/src/model/abstracts/customs/custom_sprite_animation.dart';
import 'package:ihm_2020_3/src/model/utils/const_colors.dart';

import 'door_object.dart';

class DoorObjectYellow extends DoorObject{
  
  static final _instance = DoorObjectYellow._();

  factory DoorObjectYellow() => _instance;

  CustomSpriteAnimation _customSpriteAnimation;

 
  DoorObjectYellow._() : super.empty(){
    _customSpriteAnimation = CustomSpriteAnimation.fromAnimations([
      this.spriteSheet.createAnimation(1, toRow: 1, loop: true, scale: 0.2, stepTime: 0.1)
    ]);
  }

  @override
  int get colorCode => ConstColors.COLOR_YELLOW;

  @override
  SpriteComponent get component => _customSpriteAnimation.currentSpriteFrame;

  void update(double dt){
    _customSpriteAnimation.update(dt);
  }

}