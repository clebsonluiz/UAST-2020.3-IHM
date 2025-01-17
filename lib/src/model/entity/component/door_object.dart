import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/position.dart';
import 'package:ihm_2020_3/src/model/abstracts/customs/custom_sprite_animation.dart';
import 'package:ihm_2020_3/src/model/abstracts/customs/custom_sprite_sheet.dart';
import 'package:ihm_2020_3/src/model/abstracts/customs/custom_tiled_component.dart';
import 'package:ihm_2020_3/src/model/utils/game_model_constants.dart';

abstract class DoorObject {
  Position _position = Position.empty();

  set posX(double x) => _position.x = x;
  set posY(double y) => _position.y = y;

  double get posX => _position.x;
  double get posY => _position.y;

  void setPosition({double x, double y}) {
    this.posX = x ?? this.posX;
    this.posY = y ?? this.posY;
  }

  CustomSpriteSheet _spriteSheet;

  CustomSpriteSheet get spriteSheet => _spriteSheet;

  CustomSpriteAnimation customSpriteAnimation;

  DoorObject.empty() {
    this._spriteSheet = CustomSpriteSheet(
      imageName: AnotherConsts.PORTAS,
      textureWidth: 32 * 7,
      textureHeight: 32 * 8,
      jumpPixelX: 32,
      jumpPixelY: 32,
      rows: 5,
      columns: 6,
    );
  }

  void renderOnTiled(Canvas canvas, CustomTiledComponent t) {
    if (!isVisibleOnTiled(t)) return;
    this.component.x += t.x;
    this.component.y += t.y;
    canvas.save();
    this.component.render(canvas);
    canvas.restore();
  }

  void update(double dt) {
    this.customSpriteAnimation?.update(dt);
    this.component.x = posX;
    this.component.y = posY;
  }

  SpriteComponent get component => customSpriteAnimation?.currentSpriteFrame;

  int get colorCode;

  /// Retorna `true` se o elemento estiver dentro do quadrante onde se concentra a tela
  bool isVisibleOnTiled(CustomTiledComponent t) {
    return this.posX + t.x + this.component.width > 0 &&
        this.posX + t.x - this.component.width < t.renderSize.width &&
        this.posY + t.y + this.component.height > 0 &&
        this.posY + t.y - this.component.height < t.renderSize.height;
  }

  Rect toRect(){
    return (Rect.fromLTWH(posX + this.component.width / 2, posY, this.component.width, this.component.height));
  }
}
