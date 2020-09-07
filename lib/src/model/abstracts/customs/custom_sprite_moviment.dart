import 'package:ihm_2020_3/src/model/abstracts/customs/custom_sprite_position.dart';

mixin CustomSpriteMoviment on CustomSpritePosition {
  //Direção do Movimento, em plataforma up pode ser o pulo(Jump) e down pode ser a queda(Fall)
  bool _idle = true;
  bool _up = false;
  bool _down = false;
  bool _left = false;
  bool _right = false;

  bool _gravityInverted = false;

  void checkNextMove() {
    if (this.isDyGreaterOrInvertedThan()) {
      if (!isFalling) doFall();
    } else if (this.isDyLessOrInvertedThan()) {
      if (!isJumping) doJump();
    }
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

      if (this.isGravityInverted ? (dY < maxFallSpeed) : (dY > maxFallSpeed))
        dY = maxFallSpeed;
    }
  }

  bool isDyLessOrInvertedThan(
      {double lessThan = 0.0, double greaterThan = 0.0}) {
    return (!isGravityInverted) ? (dY < lessThan) : (dY > greaterThan);
  }

  bool isDyGreaterOrInvertedThan(
      {double lessThan = 0.0, double greaterThan = 0.0}) {
    return (!isGravityInverted) ? (dY > greaterThan) : (dY > lessThan);
  }

  //Movimento somente em duas direções(Esquerda ou direita)
  void walkTo({bool esquerda = false, bool direita = false}) {
    this._left = esquerda;
    this._right = direita;
    stopIdle();
  }

  void doIdle() => this._idle = true;
  void doJump() => this._up = true;
  void doFall() => this._down = true;
  void stopIdle() => this._idle = false;
  void stopJump() => this._up = false;
  void stopFall() => this._down = false;

  bool get isJumping => this._up;
  bool get isFalling => this._down;

  bool get isIdle => this._idle;
  bool get isWalkingLeft => this._left;
  bool get isWalkingRight => this._right;

  
  //velocidades de movimento

  double get moveSpeed => 0.5; // Vel in X axis
  double get maxMoveSpeed => 2.0; // Max Vel in X axis
  double get stopSpeed => 0.3; // Stop speed in X axis
  double get jumpStarts => this.gravityValue * -5.5;
  double get stopJumpSpeed => this.gravityValue * 0.3;
  double get fallSpeed => this.gravityValue * 0.2;
  double get maxFallSpeed => this.gravityValue * 4.0;

  // Direção da Gravidade
  double get gravityValue => (this._gravityInverted) ? -1.0 : 1.0;

  void changeGravity() => this._gravityInverted = !this._gravityInverted;

  bool get isGravityInverted => this._gravityInverted;

}
