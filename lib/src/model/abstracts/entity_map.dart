import 'dart:ui';

import 'package:ihm_2020_3/src/model/entity/life/life_status.dart';

import 'customs/custom_sprite_entity.dart';
import 'customs/custom_sprite_animation.dart';
import 'customs/custom_tiled_component.dart';

abstract class EntityMap extends CustomSpriteEntity {
  CustomTiledComponent tileMap;

  int _life = 0;

  int get maxLifes => 3;

  void resetLifes() => this._life = maxLifes;

  set life(int life) {
    if (life >= 0 && life < this.maxLifes)
      this._life = life;
    else
      this.resetLifes();
  }

  int get life => this._life;

  bool get drawLife => true;
  bool get isDead => this.life <= 0;

  EntityMap(List<CustomAnimation> animations,
      {bool isLookingAtLeft = false, this.tileMap})
      : super(animations, isLookingAtLeft: isLookingAtLeft) {
    this.resetLifes();
  }

  int get nextAnimation => 0;

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

  @override
  void render(Canvas canvas) async {
    if (!this.isVisible) return;

    final x = this.posX + this.tileMap.x - this.spriteAnimation.currWidth / 2;
    final y = this.posY + this.tileMap.y - this.spriteAnimation.currHeight / 2;

    final invertX = isLookingAtLeft ? (!this.isWalkingLeft) : (!this.isWalkingRight);
    final invertY = this.isGravityInverted;
    final scale = 1.0;
    canvas.save(); // Analisar a necessidade de deixar aqui
    this.spriteAnimation.renderAtPosition(canvas,
        x: x, y: y, invertX: invertX, invertY: invertY, scale: scale);
    canvas.restore(); // Analisar a necessidade de deixar aqui

    if (this.drawLife) LifeEntity.instance.render(canvas, this);
  }

  @override
  void update(double dt) async {

    // if (this.spriteAnimation.lo)


    nextPosition();
    checkTileMapColision();
    checkNextMove();

    final int currentAnimation = this.nextAnimation;

    this.spriteAnimation.update(dt, currentRow: currentAnimation);
  }

  /// Retorna `true` se o elemento estiver dentro do quadrante onde se concentra a tela
  bool get isVisible {
    // print("Player: ($posX, $posY) :::: Colision: (${this.currWidth}, ${this.currHeight})");
    // print("TileMap: (${tileMap.x}, ${tileMap.y}) :::: TileMap: ${this.tileMap.renderSize}");

    // print("Esquerda: ${this.posX + this.tileMap.x + this.currWidth > 0}");
    // print("Direita: ${this.posX + this.tileMap.x - this.currWidth < this.tileMap.renderSize.width}");
    // print("Cima: ${this.posY + this.tileMap.y + this.currHeight > 0 }");
    // print("Baixo: ${this.posY + this.tileMap.y - this.currHeight < this.tileMap.renderSize.height}");

    return this.posX + this.tileMap.x + this.spriteAnimation.currWidth > 0 &&
        this.posX + this.tileMap.x - this.spriteAnimation.currWidth < this.tileMap.renderSize.width &&
        this.posY + this.tileMap.y + this.spriteAnimation.currHeight > 0 &&
        this.posY + this.tileMap.y - this.spriteAnimation.currHeight < this.tileMap.renderSize.height;
  }
}
