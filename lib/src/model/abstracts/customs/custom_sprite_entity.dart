import 'dart:ui';

import 'custom_sprite_position.dart';
import 'custom_sprite_colision.dart';
import 'custom_sprite_moviment.dart';

import 'custom_sprite_animation.dart';

//Definição dos atributos padrões que irão compor uma entidade com Sprites
abstract class CustomSpriteEntity
    with CustomSpritePosition, CustomSpriteMoviment, CustomSpriteColision {

  bool isLookingAtLeft = false;

  CustomSpriteAnimation _customSpriteAnimation;

  CustomSpriteEntity(List<CustomAnimation> animations,
      {this.isLookingAtLeft = false}) {
    this._customSpriteAnimation =
        CustomSpriteAnimation.fromAnimations(animations);
  }

  void render(Canvas canvas);

  void update(double dt);

  CustomSpriteAnimation get spriteAnimation => this._customSpriteAnimation;

  Rect toRect() {
    if (this._customSpriteAnimation.animations == null ||
        this._customSpriteAnimation.animations.length == 0) return Rect.zero;

    var sprite = this
        ._customSpriteAnimation
        .animations[this._customSpriteAnimation.currRow]
        .getSpriteComponent();

    return Rect.fromLTWH(
        this.posX - sprite.anchor.relativePosition.dx * colisionBoxWidth,
        this.posY - sprite.anchor.relativePosition.dy * colisionBoxHeight,
        colisionBoxWidth.toDouble(),
        colisionBoxHeight.toDouble());
  }
}
