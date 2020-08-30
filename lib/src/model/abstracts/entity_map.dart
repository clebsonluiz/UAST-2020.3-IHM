import 'dart:ui';

import 'package:ihm_2020_3/src/model/entity/life/life_status.dart';

import 'customs/custom_sprite_entity.dart';
import 'customs/custom_sprite_animation.dart';
import 'customs/custom_tiled_component.dart';

abstract class EntityMap extends CustomSpriteEntity {


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

  //velocidades

  double get moveSpeed => 0.5; // Vel in X axis
  double get maxMoveSpeed => 2.0; // Max Vel in X axis
  double get stopSpeed => 0.3; // Stop speed in X axis 
  double get jumpStarts => this.gravityValue * -5.5;
  double get stopJumpSpeed => this.gravityValue * 0.3;
  double get fallSpeed => this.gravityValue * 0.2;
  double get maxFallSpeed => this.gravityValue * 4.0;

  EntityMap(List<CustomAnimation> animations,
      {bool isLookingAtLeft = false, CustomTiledComponent tileMap})
      : super.fromAnimations(animations,
            isLookingAtLeft: isLookingAtLeft, tileMap: tileMap)
            {
              this.resetLifes();
            }

  int get nextAnimation => 0;

  void checkNextMove() {
    if (this.isDyGreaterOrInvertedThan()) {
      if (!isFalling) doFall();
    } else if (this.isDyLessOrInvertedThan()) {
      if (!isJumping) doJump();
    }
  }

  @override
  void render(Canvas canvas,
      {double x, double y, bool invertX, bool invertY, double scale}) async {
    canvas.save(); // Analisar a necessidade de deixar aqui
    super.render(canvas,
        x: x, y: y, invertX: invertX, invertY: this.isGravityInverted, scale: scale);
    canvas.restore(); // Analisar a necessidade de deixar aqui
    if (this.drawLife)
      LifeEntity.instance.render(canvas, this);
  }

  @override
  void update(double dt, {int currentRow = 0}) async {
    nextPosition();
    checkTileMapColision();
    checkNextMove();

    final int currentAnimation = nextAnimation;

    super.update(dt, currentRow: currentAnimation);
  }

  void nextPosition() {
    //Movimento
    if (isWalkingLeft && !isIdle) {
      dX -= moveSpeed;
      if (dX < -maxMoveSpeed) dX = -maxMoveSpeed;
    } else if (isWalkingRight && !isIdle) {
      dX += moveSpeed;
      if (dX > maxMoveSpeed) dX = maxMoveSpeed;
    } else {
      if (dX > 0) {
        dX -= stopSpeed;
        if (dX < 0) dX = 0;
      } else if (dX < 0) {
        dX += stopSpeed;
        if (dX > 0) dX = 0;
      }
    }

    // jumping
    if (isJumping && !isFalling) {
      dY = jumpStarts;
      doFall();
    }

    // falling
    if (isFalling) {
      dY += fallSpeed;

      if (this.isDyGreaterOrInvertedThan()) stopJump();
      if (this.isDyLessOrInvertedThan() && !isJumping) dY += stopJumpSpeed;

      if (this.isGravityInverted? (dY < maxFallSpeed) : (dY > maxFallSpeed)) dY = maxFallSpeed;
    }
  }

  bool isDyLessOrInvertedThan(
          {double lessThan = 0.0, double greaterThan = 0.0}) =>
      (!isGravityInverted) ? (dY < lessThan) : (dY > greaterThan);

  bool isDyGreaterOrInvertedThan(
          {double lessThan = 0.0, double greaterThan = 0.0}) =>
      (!isGravityInverted) ? (dY > greaterThan) : (dY > lessThan);
  
  
}
