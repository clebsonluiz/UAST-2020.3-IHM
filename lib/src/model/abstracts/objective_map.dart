import 'dart:ui';

import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:ihm_2020_3/src/model/abstracts/customs/custom_sprite_position.dart';

abstract class ObjectiveMap extends Sprite with CustomSpritePosition{

  bool _visible = false;

  ObjectiveMap(String fileName) : super(fileName);

  @override
  void render(Canvas canvas, {double width, double height, Paint overridePaint, double scale = 1.0, Position p}) {
    if (!loaded() || !this._visible)
      return;
    width ??= size.x;
    height ??= size.y;
    this.setPosition(x: (p?.x)?? posX, y: (p?.y)?? posY);
    super.renderRect(canvas,
        Rect.fromLTWH((posX / 2) - (width * scale ) / 2, (posY / 2) - (height * scale) / 2, width * scale, height * scale),
        overridePaint: overridePaint);
    
  }

  void changeVisible() => this._visible = !this._visible;

}
