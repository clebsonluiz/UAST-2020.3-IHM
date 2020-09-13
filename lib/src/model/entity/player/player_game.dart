import 'dart:ui';

import 'package:ihm_2020_3/src/model/abstracts/customs/custom_sprite_animation.dart';
import 'package:ihm_2020_3/src/model/abstracts/customs/custom_sprite_colision.dart';
import 'package:ihm_2020_3/src/model/abstracts/customs/custom_sprite_entity.dart';
import 'package:ihm_2020_3/src/model/abstracts/customs/custom_sprite_moviment.dart';
import 'package:ihm_2020_3/src/model/abstracts/customs/custom_sprite_position.dart';
import 'package:ihm_2020_3/src/model/abstracts/customs/custom_tiled_component.dart';
import 'package:ihm_2020_3/src/model/animations/alien_hunter_golden_color_blue.dart';
import 'package:ihm_2020_3/src/model/animations/alien_hunter_golden_color_green.dart';
import 'package:ihm_2020_3/src/model/animations/alien_hunter_golden_color_red.dart';
import 'package:ihm_2020_3/src/model/animations/alien_hunter_golden_color_yellow.dart';
import 'package:ihm_2020_3/src/model/animations/alien_hunter_golden_colors.dart';
import 'package:ihm_2020_3/src/model/entity/life/life_status.dart';

class PlayerGame with CustomSpritePosition, CustomSpriteMoviment, CustomSpriteColision, CustomSpriteEntity{

  static const PLAYER_BLUE = 0;
  static const PLAYER_GREEN = 1;
  static const PLAYER_RED = 2;
  static const PLAYER_YELLOW = 3;

  int _current = 0;

  int get currentAnimation => _current;

  changeToBlue() => this._current = PLAYER_BLUE;
  changeToGreen() => this._current = PLAYER_GREEN;
  changeToRed() => this._current = PLAYER_RED;
  changeToYellow() => this._current = PLAYER_YELLOW;

  final List<CustomSpriteAnimation> _playerAnimations = [];

  @override
  double get moveSpeed => 0.7; // Vel in X axis
  @override
  double get maxMoveSpeed => 2.0; // Max Vel in X axis
  @override
  double get stopSpeed => 0.5; // Stop speed in X axis 
  @override
  double get maxFallSpeed => this.gravityValue * 3.0; // Stop speed in X axis 

  

  bool startInvertion = false;




  int _life = 0;

  int get maxLifes => 3;

  void resetLifes() => this._life = maxLifes;

  set life(int life) {
    if (life >= 0 && life < this.maxLifes)
      this._life = life;
    else
      this.resetLifes();
  }

  @override
  int get life => this._life;

  bool get isDead => this.life <= 0;

  PlayerGame(CustomTiledComponent tileMap){
    this.tileMap = tileMap;
    this.isLookingAtLeft = true;
    
    final animationsBlue = CustomSpriteAnimation.fromAnimations(AlienHunterGoldenColorBlue().animations);
    final animationsGreen = CustomSpriteAnimation.fromAnimations(AlienHunterGoldenColorGreen().animations);
    final animationsRed = CustomSpriteAnimation.fromAnimations(AlienHunterGoldenColorRed().animations);
    final animationsYellow = CustomSpriteAnimation.fromAnimations(AlienHunterGoldenColorYellow().animations);

    _playerAnimations.addAll([
      animationsBlue,
      animationsGreen,
      animationsRed ,
      animationsYellow
    ]);

    this.setColisionBox(height: 35, width: 32);
  }


  @override
  List<int> colisionFactor() {
    switch (currentAnimation) {
      case PLAYER_BLUE:
        return [6, 3];
      case PLAYER_GREEN:
        return [6, 1];
      case PLAYER_RED:
        return [6, 4];
      case PLAYER_YELLOW:
        return [6, 2];
      default: 
        return [6];
    }
  }

  @override
  CustomSpriteAnimation get spriteAnimation => this._playerAnimations[this.currentAnimation];

  @override
  int get nextAnimation {
    if (isIdle && !(isJumping || isFalling || startInvertion))
      return AlienHunterGoldenColor.IDLE;
    else if (isJumping)
      return AlienHunterGoldenColor.JUMPING;
    else if (isFalling) 
      return (startInvertion)? AlienHunterGoldenColor.GRAVITY : AlienHunterGoldenColor.FALLING;
    else if (isWalkingLeft || isWalkingRight)
      return AlienHunterGoldenColor.WALKING;
    else
      return AlienHunterGoldenColor.IDLE;
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

    LifeEntity.instance.render(canvas, this);
  }

  @override
  void update(double dt) async {

    nextPosition();
    checkTileMapColision();
    checkNextMove();

    final int currentAnimation = this.nextAnimation;

    this.spriteAnimation.update(dt, currentRow: currentAnimation);

    startInvertion = nextAnimation==AlienHunterGoldenColor.GRAVITY;
  }


  @override
  void changeGravity() {
    if (!startInvertion)
    {
      super.changeGravity();
      startInvertion = true;
    }
  }




}