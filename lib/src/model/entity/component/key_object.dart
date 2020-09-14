import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:ihm_2020_3/src/model/abstracts/customs/custom_sprite_entity.dart';

import 'package:ihm_2020_3/src/model/entity/component/mixin_entity_component.dart';
import 'package:ihm_2020_3/src/model/utils/assets_acess.dart';

abstract class KeyObject implements MixinEntityComponent {
  SpriteComponent _component;

  SpriteComponent get component => _component;

  KeyObject.fromPosition(
    int row, {
    double x = 0.0,
    double y = 0.0,
  }) {
    final width = 352.0;
    final height = 192.0;

    Sprite.loadSprite(Another.KEYS,
            x: x,
            y: y + (((row * height) + (row * 32))),
            width: width,
            height: height)
        .then((value) {
      _component = SpriteComponent.fromSprite(
          value.size.x * 0.05, value.size.y * 0.05, value);
    });
  }

  @override
  void renderOnPositioned(Canvas canvas, CustomSpriteEntity e,
      {double onX = 1.0, double onY = 1.0}) {
    if (component == null || !component.loaded()) return;

    double x = e.posX + e.tileMap.x;
    double y = e.posY + e.tileMap.y;
    double height = e.colisionBoxHeight.toDouble();
    double width = e.colisionBoxWidth.toDouble();
    bool g = e.isGravityInverted;

    component.x = x - width * onX;
    component.y = y - height * (g ? -onY : onY);

    canvas.save();
    component.renderFlipY = g;
    component.render(canvas);
    canvas.restore();
  }

  int get keyCode;

}
