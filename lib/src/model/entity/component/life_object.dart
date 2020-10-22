import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/effects/scale_effect.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:ihm_2020_3/src/model/abstracts/customs/custom_sprite_entity.dart';
import 'package:ihm_2020_3/src/model/utils/game_model_constants.dart';

class LifeObject {
  final List<SpriteComponent> _lifes = [];

  CustomSpriteEntity _entity;

  LifeObject(this._entity) {
    Sprite.loadSprite(AnotherConsts.HEARTH_STATUS, x: 0, y: 0, width: 65, height: 55)
        .then((life) {
      final width = life.size.x * 0.15;
      final height = life.size.y * 0.15;

      this._lifes.clear();
      for (var i = 1; i <= this._entity.life; i++) {
        final _tlife =
            SpriteComponent.fromSprite(width, life.size.y * 0.15, life);

        _tlife.addEffect(ScaleEffect(
            size: Position(width * 1.5, height * 1.5).toSize(),
            speed: 0.01,
            curve: Curves.bounceInOut,
            isInfinite: true,
            isAlternating: true));
        this._lifes.add(_tlife);
      }

    });
  }

  bool loaded() => this._lifes.every((e) => e.loaded());

  void render(Canvas canvas) {
    if (this._lifes.isEmpty || !this.loaded()) return;

    for (var i = this._entity.life; i >= 1; i--) {
       canvas.save();
      _lifes[i - 1].render(canvas);
      canvas.restore();
    }
  }

  void update(double dt) {
    if (this._lifes.isEmpty || !this.loaded()) return;
    final double x = _entity.posX + _entity.tileMap.x;
    final double y = _entity.posY + _entity.tileMap.y;
    final double height = _entity.colisionBoxHeight.toDouble();
    final double width = _entity.colisionBoxWidth.toDouble();
    final bool g = _entity.isGravityInverted;

    final lifes = _entity.life;

    var onX = 1.0;
    var onY = 1.0;

    for (var i = lifes; i >= 1; i--) {
      final _life = _lifes[i - 1];

      if (i == 3) {
        onX = 0.35;
        onY = (g ? 0.9 : 1.1);
      } else if (i == 2) {
        onX = -0.15;
        onY = (g ? 0.9 : 1.1);
      } else {
        onX = 0.1;
        onY = (g ? 0.7 : 0.9);
      }

      _life.renderFlipY = g;
      _life.x = x - width * onX;
      _life.y = y - height * (g ? -onY : onY);
      _life.update(dt);
    }
  }
}
