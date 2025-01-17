import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/text_component.dart';
import 'package:flame/effects/effects.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flame/text_config.dart';
import 'package:flutter/material.dart';
import 'package:ihm_2020_3/src/model/abstracts/customs/custom_text_config.dart';
import 'package:ihm_2020_3/src/model/abstracts/customs/custom_tiled_component.dart';

abstract class SymbolObject {
  TextComponent _textComponent;

  String _text = "";

  set text(String text) => this._text = text;
  get text => this._text;

  Position _position = Position.empty();

  ScaleEffect _effect;

  set posX(double x) => _position.x = x;
  set posY(double y) => _position.y = y;

  double get posX => _position.x;
  double get posY => _position.y;

  void setPosition({double x, double y}) {
    this.posX = x ?? this.posX;
    this.posY = y ?? this.posY;
  }

  double _scale = 1.0;

  SpriteComponent _component;

  SpriteComponent get component => _component;

  TextConfig get textConfig => CustomTextConfig(
      fontSize: 25.0,
      fontFamily: 'Awesome Font',
      color: const Color(0xFF303030));

  SymbolObject.fromAsset(String imgAsset,
      {double width,
      double height,
      double scaleX = 0.5,
      double scaleY,
      double x = 0.0,
      double y = 0.0}) {
    Sprite.loadSprite(imgAsset, x: x, y: y, width: width, height: height)
        .then((value) {
      final width = value.size.x * scaleX ?? 0.5;
      final height = value.size.y * (scaleY ?? scaleX ?? 0.5);

      _component = SpriteComponent.fromSprite(width, height, value);

      _effect = ScaleEffect(
          size: Position(width * 0.95, height * 0.95).toSize(),
          speed: 15,
          curve: Curves.bounceInOut,
          isInfinite: true,
          isAlternating: true);

      _component
        ..clearEffects()
        ..addEffect(_effect);
      _textComponent = TextComponent(_text, config: this.textConfig)
        ..anchor = Anchor.center;
    });
  }

  void renderOnTiled(Canvas canvas, CustomTiledComponent t) {
    if (!isVisibleOnTiled(t)) return;

    this.component.x += t.x;
    this.component.y += t.y;

    canvas.save();

    this.component.render(canvas);

    final width = this.component.width / 2;
    final height = this.component.height / 2;

    canvas.translate(width - width * _scale, height - height * _scale);
    canvas.scale(_scale);
    this._textComponent.text = text;
    this._textComponent.render(canvas);

    canvas.restore();
  }

  void renderOnPositioned(Canvas canvas, {double x, double y}) {
    if (!loaded()) return;
    this.component.x = x ?? posX;
    this.component.y = y ?? posY;

    canvas.save();
    this.component.render(canvas);
    this._textComponent.text = text;
    this._textComponent.x = this.component.width / 2;
    this._textComponent.y = this.component.height / 2;
    this._textComponent.render(canvas);
    canvas.restore();
  }

  /// Retorna `true` se o elemento estiver dentro do quadrante onde se concentra a tela
  bool isVisibleOnTiled(CustomTiledComponent t) {
    if (this.component == null ||
        !this.component.loaded() ||
        this._textComponent == null ||
        !this._textComponent.loaded()) return false;
    return this.posX + t.x + this.component.width > 0 &&
        this.posX + t.x - this.component.width < t.renderSize.width &&
        this.posY + t.y + this.component.height > 0 &&
        this.posY + t.y - this.component.height < t.renderSize.height;
  }

  void update(double dt) {
    if (!loaded()) return;
    this.component.update(dt);
    this._textComponent.update(dt);

    _scale = 1.0 + (-0.1 * this._effect.percentage);

    final p = Position(
      this.component.width / 2,
      this.component.height / 2,
    );

    this.component.x = posX - p.x;
    this.component.y = posY - p.y;

    this._textComponent.x = p.x;
    this._textComponent.y = p.y;
  }

  bool loaded() => !(this.component == null ||
      !this.component.loaded() ||
      this._textComponent == null ||
      !this._textComponent.loaded());


  @override
  String toString() {
    return super.toString() + "[$text]";
  }

  Rect toRect(){
    return (Rect.fromLTWH(posX, posY, this.component.width, this.component.height));
  }

}
