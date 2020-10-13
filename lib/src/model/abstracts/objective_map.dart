import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/components/text_component.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:flame/text_config.dart';
import 'package:ihm_2020_3/src/model/abstracts/customs/custom_sprite_position.dart';
import 'package:ihm_2020_3/src/model/objetivo/objetivo.dart';

abstract class ObjectiveMap extends Sprite with CustomSpritePosition{
  

  String _text = "";

  String get text => _text;


  TextConfig get textConfig => TextConfig(
      fontSize: 30.0,
      fontFamily: 'Consolas', 
      color: const Color(0xFF303030));


  TextComponent _textComponent;

  bool _visible = false;

  ObjectiveMap(String fileName, 
  {
    double x = 0, 
    double y = 0, 
    double width,
    double height,
  }) : super(fileName, x: x, y: y, width: width, height: height){
    _textComponent = TextComponent(text, config: this.textConfig)
        ..anchor = Anchor.center;
  }

  @override
  void render(Canvas canvas, {double width, double height, Paint overridePaint, double scale = 1.0, Position p}) {
    if (!loaded() || !this._visible)
      return;
    width ??= size.x;
    height ??= size.y;

    canvas.save();
    
    canvas.drawColor(const Color(0xFF303030), BlendMode.modulate);

    this.setPosition(x: (p?.x)?? posX, y: (p?.y)?? posY);
    super.renderRect(canvas,
        Rect.fromLTWH((posX / 2) - (width * scale ) / 2, (posY / 2) - (height * scale) / 2, width * scale, height * scale),
        overridePaint: overridePaint);

    this._textComponent.render(canvas);

    canvas.restore();

  }


  void update(double dt){
    if(!loaded() || !this._visible) return;

    _text = "";

    Objetivo().current.expressao.forEach((el) { 
      _text += el.text;
    });

    this._textComponent.x = posX / 2;
    this._textComponent.y =  posY / 2;
    this._textComponent.text = text;
  }


  @override
  bool loaded() {
    return super.loaded() && (_textComponent != null && _textComponent.loaded());
  }

  void changeVisible() => this._visible = !this._visible;

}
