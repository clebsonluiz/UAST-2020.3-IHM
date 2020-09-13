import 'dart:ui';

import 'custom_sprite_position.dart';
import 'custom_sprite_colision.dart';
import 'custom_sprite_moviment.dart';

import 'custom_sprite_animation.dart';
import 'custom_tiled_component.dart';

//Definição dos atributos padrões que irão compor uma entidade com Sprites
mixin CustomSpriteEntity
    on CustomSpritePosition, CustomSpriteMoviment, CustomSpriteColision 
    {

  bool isLookingAtLeft = false;

  CustomTiledComponent tileMap;

  void calcularPosicaoNoMapa(double x, double y) {
    if (tileMap == null || !tileMap.loaded()) return;

    int leftTile = ((x - colisionBoxWidth / 2) ~/ tileMap.tileWidth);
    int rightTile = ((x + colisionBoxWidth / 2 - 1) ~/ tileMap.tileWidth);
    int topTile = ((y - colisionBoxHeight / 2) ~/ tileMap.tileHeight);
    int bottomTile = ((y + colisionBoxHeight / 2 - 1) ~/ tileMap.tileHeight);

    this.colisionOnTopLeft = colisionFactor().contains(tileMap.tileMatrix()[topTile][leftTile]);
    this.colisionOnTopRight = colisionFactor().contains(tileMap.tileMatrix()[topTile][rightTile]);
    this.colisionOnBottomLeft = colisionFactor().contains(tileMap.tileMatrix()[bottomTile][leftTile]);
    this.colisionOnBottomRight = colisionFactor().contains(tileMap.tileMatrix()[bottomTile][rightTile]);
  }

  void checkTileMapColision() {
    if (tileMap == null || !tileMap.loaded()) return;

    int currCol = (this.posX ~/ tileMap.tileWidth);
    int currRow = (this.posY ~/ tileMap.tileHeight);

    double xdest = posX + dX;
    double ydest = posY + dY;

    double xtemp = posX;
    double ytemp = posY;

    calcularPosicaoNoMapa(posX, ydest);

    if (dY < 0) {
      if (this.colisionOnTopLeft || this.colisionOnTopRight) {
        dY = 0;
        ytemp = currRow * tileMap.tileHeight + colisionBoxHeight / 2;
        if (this.isGravityInverted) this.stopFall();
      } else
        ytemp += dY;
    }
    if (dY > 0) {
      if (this.colisionOnBottomLeft || this.colisionOnBottomRight) {
        dY = 0;
        if (!this.isGravityInverted) stopFall();
        ytemp = (currRow + 1) * tileMap.tileHeight - colisionBoxHeight / 2;
      } else
        ytemp += dY;
    }

    calcularPosicaoNoMapa(xdest, posY);

    if (dX < 0) {
      if (this.colisionOnTopLeft || this.colisionOnBottomLeft) {
        dX = 0;
        xtemp = currCol * tileMap.tileWidth + colisionBoxWidth / 2;
      } else
        xtemp += dX;
    }

    if (dX > 0) {
      if (this.colisionOnTopRight || this.colisionOnBottomRight) {
        dX = 0;
        xtemp = (currCol + 1) * tileMap.tileWidth - colisionBoxWidth / 2;
      } else
        xtemp += dX;
    }

    if (!isFalling) {
      calcularPosicaoNoMapa(posX, ydest + this.gravityValue);

      if ((this.isGravityInverted)
          ? (!this.colisionOnTopLeft && !this.colisionOnTopRight)
          : (!this.colisionOnBottomLeft && !this.colisionOnBottomRight))
        doFall();
    }
    setPosition(x: xtemp, y: ytemp);
  }


  /// Retorna `true` se o elemento estiver dentro do quadrante onde se concentra a tela
  bool get isVisible {

    return this.posX + this.tileMap.x + this.spriteAnimation.currWidth > 0 &&
        this.posX + this.tileMap.x - this.spriteAnimation.currWidth < this.tileMap.renderSize.width &&
        this.posY + this.tileMap.y + this.spriteAnimation.currHeight > 0 &&
        this.posY + this.tileMap.y - this.spriteAnimation.currHeight < this.tileMap.renderSize.height;
  }

  void render(Canvas canvas);
  void update(double dt);

  int get nextAnimation;

  CustomSpriteAnimation get spriteAnimation;

  int get life;

  @override
  Rect toRect() {
    if (this.spriteAnimation.animations == null ||
        this.spriteAnimation.animations.length == 0) return Rect.zero;

    var sprite = this
        .spriteAnimation
        .animations[this.spriteAnimation.currRow]
        .getSpriteComponent();

    return Rect.fromLTWH(
        this.posX - sprite.anchor.relativePosition.dx * colisionBoxWidth,
        this.posY - sprite.anchor.relativePosition.dy * colisionBoxHeight,
        colisionBoxWidth.toDouble(),
        colisionBoxHeight.toDouble());
  }
}
