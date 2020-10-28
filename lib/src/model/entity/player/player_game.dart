import 'dart:ui';

import 'package:flame/position.dart';
import 'package:ihm_2020_3/src/model/abstracts/customs/custom_sprite_animation.dart';
import 'package:ihm_2020_3/src/model/abstracts/customs/custom_sprite_colision.dart';
import 'package:ihm_2020_3/src/model/abstracts/customs/custom_sprite_entity.dart';
import 'package:ihm_2020_3/src/model/abstracts/customs/custom_sprite_moviment.dart';
import 'package:ihm_2020_3/src/model/abstracts/customs/custom_sprite_position.dart';
import 'package:ihm_2020_3/src/model/abstracts/customs/custom_tiled_component.dart';
import 'package:ihm_2020_3/src/model/animations/alien_hunter_golden_colors.dart';
import 'package:ihm_2020_3/src/model/entity/component/alert_info_object.dart';
import 'package:ihm_2020_3/src/model/entity/component/key_object.dart';
import 'package:ihm_2020_3/src/model/entity/component/life_object.dart';
import 'package:ihm_2020_3/src/model/utils/game_model_constants.dart';

class PlayerGame with CustomSpritePosition, CustomSpriteMoviment, CustomSpriteColision, CustomSpriteEntity{

  static const PLAYER_DARK = 0;
  static const PLAYER_BLUE = 1;
  static const PLAYER_GREEN = 2;
  static const PLAYER_RED = 3;
  static const PLAYER_YELLOW = 4;

  int get currentKeyCode {
    if(currentAnimation == PLAYER_GREEN) return ConstColorsCode.COLOR_GREEN;
    if(currentAnimation == PLAYER_YELLOW) return ConstColorsCode.COLOR_YELLOW;
    if(currentAnimation == PLAYER_BLUE) return ConstColorsCode.COLOR_BLUE;
    if(currentAnimation == PLAYER_RED) return ConstColorsCode.COLOR_RED;
    return 0;
  }

  int _current = 0;

  int get currentAnimation => _current;

  changeToDark() => this._current = PLAYER_DARK;
  changeToBlue() => this._current = PLAYER_BLUE;
  changeToGreen() => this._current = PLAYER_GREEN;
  changeToRed() => this._current = PLAYER_RED;
  changeToYellow() => this._current = PLAYER_YELLOW;

  final List<CustomSpriteAnimation> _playerAnimations = [];

  final List<KeyObject> _keys = [];

  List<KeyObject> get currentKeys => this._keys;

  @override
  double get moveSpeed => 0.7; // Vel in X axis
  @override
  double get maxMoveSpeed => 2.0; // Max Vel in X axis
  @override
  double get stopSpeed => 0.5; // Stop speed in X axis 
  @override
  double get maxFallSpeed => this.gravityValue * 3.0; // Stop speed in X axis 

  

  void setCurrentStatus(CustomTiledComponent tileMap, Position bornPosition){
    this.setPosition(x: bornPosition.x, y: bornPosition.y);
    this.tileMap = tileMap;
  }

  bool startInvertion = false;

  DamageTextObject _damageTextObject;
  RightAnswerTextObject _rightAnswerTextObject;

  LifeObject _lifeObject;


  int _life = 0;

  int get maxLifes => 3;

  void resetLifes() => this._life = maxLifes;

  set life(int life) {
    if (life >= 0 && life <= this.maxLifes)
      this._life = life;
    else
      this.resetLifes();
  }

  void doDamage() {
    life = life -= 1;
    this._damageTextObject.show();
  }

  void doRightAnswer() {
    this._rightAnswerTextObject.show();
  }

  @override
  int get life => this._life;

  bool get isDead => this.life <= 0;

  PlayerGame(){
    _lifeObject = LifeObject(this);
    _damageTextObject = DamageTextObject(this);
    _rightAnswerTextObject = RightAnswerTextObject(this);

    this.isLookingAtLeft = true;

    final animationsDark = CustomSpriteAnimation.fromAnimations(AlienHunterGoldenColorDark().animations);
    final animationsBlue = CustomSpriteAnimation.fromAnimations(AlienHunterGoldenColorBlue().animations);
    final animationsGreen = CustomSpriteAnimation.fromAnimations(AlienHunterGoldenColorGreen().animations);
    final animationsRed = CustomSpriteAnimation.fromAnimations(AlienHunterGoldenColorRed().animations);
    final animationsYellow = CustomSpriteAnimation.fromAnimations(AlienHunterGoldenColorYellow().animations);

    _playerAnimations.addAll([
      animationsDark,
      animationsBlue,
      animationsGreen,
      animationsRed,
      animationsYellow
    ]);

    this.setColisionBox(height: 35, width: 32);
    this.resetLifes();
  }


  @override
  List<int> colisionFactor() {
    switch (currentAnimation) {
      case PLAYER_DARK:
        return [6];
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

    this._lifeObject.render(canvas);
    this._keys.forEach((key) => key.renderOn(canvas, this));
    this._damageTextObject.render(canvas);
    this._rightAnswerTextObject.render(canvas);
  }

  @override
  void update(double dt) async {

    nextPosition();
    checkTileMapColision();
    checkNextMove();

    final int currentAnimation = this.nextAnimation;

    this.spriteAnimation.update(dt, currentRow: currentAnimation);

    startInvertion = nextAnimation==AlienHunterGoldenColor.GRAVITY;
    this._lifeObject.update(dt);
    this._keys.forEach((key) => key.update(dt));
    this._damageTextObject.update(dt);
    this._rightAnswerTextObject.update(dt);
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