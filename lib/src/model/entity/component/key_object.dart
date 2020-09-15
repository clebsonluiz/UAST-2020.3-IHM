import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:ihm_2020_3/src/model/abstracts/customs/custom_sprite_entity.dart';
import 'package:ihm_2020_3/src/model/abstracts/customs/custom_tiled_component.dart';

import 'package:ihm_2020_3/src/model/entity/component/mixin_entity_component.dart';
import 'package:ihm_2020_3/src/model/utils/assets_acess.dart';

abstract class KeyObject implements MixinEntityComponent {

  Position _position = Position.empty();
  
  set posX(double x) => _position.x = x;
  set posY(double y) => _position.y = y;

  double get posX => _position.x;
  double get posY => _position.y;

  void setPosition({double x, double y}) {
    this.posX = x ?? this.posX;
    this.posY = y ?? this.posY;
  }

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

  void renderOnTiled(Canvas canvas, CustomTiledComponent t){
    if (!isVisibleOnTiled(t)) return;
    this.component.x = posX + t.x;
    this.component.y = posY + t.y;
    canvas.save();
    this.component.render(canvas);
    canvas.restore();
  }

  @override
  void renderOnPositioned(Canvas canvas, CustomSpriteEntity e,
      {double onX = 1.0, double onY = 1.0}) {
    if (component == null || !component.loaded() || !e.hasMapReady ||!e.isVisible) return;

    final double x = e.posX + e.tileMap.x;
    final double y = e.posY + e.tileMap.y;
    final double height = e.colisionBoxHeight.toDouble();
    final double width = e.colisionBoxWidth.toDouble();
    final bool g = e.isGravityInverted;

    this.posX = x - width * onX;
    this.posY = y - height * (g ? -onY : onY);

    component.x = this.posX;
    component.y = this.posY;

    canvas.save();
    component.renderFlipY = g;
    component.render(canvas);
    canvas.restore();
  }

  int get keyCode;


    /// Retorna `true` se o elemento estiver dentro do quadrante onde se concentra a tela
  bool isVisibleOnTiled(CustomTiledComponent t) {
    
    return this.posX + t.x + this.component.width > 0 &&
        this.posX + t.x - this.component.width < t.renderSize.width &&
        this.posY + t.y + this.component.height > 0 &&
        this.posY + t.y - this.component.height < t.renderSize.height;
  }


}
