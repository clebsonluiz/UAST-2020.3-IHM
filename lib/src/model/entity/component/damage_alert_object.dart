import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/components/text_component.dart';
import 'package:flame/text_config.dart';
import 'package:flutter/material.dart';
import 'package:ihm_2020_3/src/model/abstracts/customs/custom_sprite_entity.dart';
import 'package:ihm_2020_3/src/model/abstracts/customs/custom_text_config.dart';

class DamageTextObject {

  final double _timeInMilliseconds = 1000;
  
  CustomSpriteEntity _entity;

  double _elapsed = 2.0;

  TextComponent _textComponent;

  DamageTextObject(this._entity) : assert(_entity != null) {
    _textComponent = TextComponent("-1 VIDA", config: this.textConfig)
      ..anchor = Anchor.topLeft;
  }

  TextConfig get textConfig => CustomTextConfig(
      fontSize: 12.0,
      color: const Color(0xFFF44336),
      fontStyle: FontStyle.italic);

  void render(Canvas canvas, {double onX = 1.0, double onY = 1.0}) {
    if (!loaded() || this.asFinished) return;

    canvas.save();
    this._textComponent.render(canvas);
    canvas.restore();
  }

  void update(double dt) {
    if (!loaded() || this.asFinished) return;

    double x = this._entity.posX + this._entity.tileMap.x;
    double y = this._entity.posY + this._entity.tileMap.y;
    double height = this._entity.colisionBoxHeight.toDouble();
    double width = this._entity.colisionBoxWidth.toDouble();

    this._textComponent.x = x + width * 0.6;
    this._textComponent.y = y + height * 0.1 - this._elapsed * 50;
    this._textComponent.update(dt);
    this._elapsed += dt;
  }

  bool loaded() {
    return !(this._textComponent == null || !this._textComponent.loaded());
  }

  void show() => this._elapsed = 0.0;
  
  bool get asFinished => _timeInMilliseconds <= this._elapsed * 1000;

}
