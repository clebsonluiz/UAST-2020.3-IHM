import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:ihm_2020_3/src/model/abstracts/customs/custom_sprite_entity.dart';
import 'package:ihm_2020_3/src/model/entity/component/mixin_entity_component.dart';

class LifeObject implements MixinEntityComponent {
  
  static final LifeObject _this = LifeObject._();

  factory LifeObject() {
    return _this;
  }

  SpriteComponent _life;

  LifeObject._() {
    Sprite.loadSprite('Vida.png', x: 0, y: 0, width: 65, height: 55)
        .then((life) {
      this._life = SpriteComponent.fromSprite(
          life.size.x * 0.15, life.size.y * 0.15, life);
    });
  }

  void renderOn(Canvas canvas, CustomSpriteEntity e) async {
    final lifes = e.life;
    final g = e.isGravityInverted;

    for (int i = 1; i <= lifes; i++) {
      if (i == 3) {
        this.renderOnPositioned(canvas, e, onX: 0.35, onY: (g ? 0.9 : 1.1));
      } else if (i == 2) {
        this.renderOnPositioned(canvas, e, onX: - 0.15, onY: (g ? 0.9 : 1.1));
      } else {
        this.renderOnPositioned(canvas, e, onX: 0.1, onY: (g ? 0.7 : 0.9));
      }
    }
  }

  @override
  void renderOnPositioned(Canvas canvas, CustomSpriteEntity e,
      {double onX = 1.0, double onY = 1.0}) {
    if (_life == null || !_life.loaded()) return;

    double x = e.posX + e.tileMap.x;
    double y = e.posY + e.tileMap.y;
    double height = e.colisionBoxHeight.toDouble();
    double width = e.colisionBoxWidth.toDouble();
    bool g = e.isGravityInverted;

    _life.x = x - width * onX;
    _life.y = y - height * (g ? -onY : onY);

    canvas.save();
    _life.renderFlipY = g;
    _life.render(canvas);
    canvas.restore();
  }
}
