import 'package:ihm_2020_3/src/model/abstracts/customs/custom_sprite_animation.dart';
import 'package:ihm_2020_3/src/model/animations/creater_animation.dart';
import 'package:ihm_2020_3/src/model/utils/game_model_constants.dart';

class AlienHunterGoldenColor {


  static AlienHunterGoldenColor _instance;


  factory AlienHunterGoldenColor(){
    return _instance??= AlienHunterGoldenColor.fromCreaterAnimation(CreaterAnimation(ConstEntityAssets.ALIEN_HUNTER_GOLD_MG));
  }  

  AlienHunterGoldenColor.fromCreaterAnimation(this._createrAnimation);

  Future<Map> _generate() async => {
        'Name': 'Alien Hunter Gold',
        'By': 'Yubari Sugiura',
        'Animations': [
          _idle,
          _walking,
        ],
      };

  Future<Map> get detalhes => _generate();

  static const int IDLE = 0;
  static const int WALKING = 1;
  static const int ATTAKING = 2;
  static const int JUMPING = 3;
  static const int FALLING = 4;
  static const int GRAVITY = 5;


  get animations => [
    idle(),
    walking(),
    attaking(),
    jumping(),
    falling(),
    gravity(),
  ];

  final CreaterAnimation _createrAnimation;

  get _idle => _createrAnimation.createSpriteSheet(
      tWidth: 38,
      tHeight: 39,
      cols: 6,
      rows: 2,
      iX: 20,
      iY: 40,
      jumpPX: 2,
      jumpPY: 1,
      ignoreLasts: 1);

  get _walking => _createrAnimation.createSpriteSheet(
      tWidth: 63,
      tHeight: 39,
      cols: 6,
      rows: 2,
      iX: 20,
      iY: 144,
      jumpPX: 7,
      jumpPY: 1,
      ignoreLasts: 1);

  get _attaking => _createrAnimation.createSpriteSheet(
      tWidth: 38,
      tHeight: 35,
      cols: 10,
      rows: 2,
      iX: 20,
      iY: 248,
      jumpPX: 2,
      jumpPY: 3);

  get _jumping =>_createrAnimation.createSpriteSheet(
      tWidth: 33,
      tHeight: 64,
      cols: 7,
      rows: 2,
      iX: 20,
      iY: 469,
      jumpPX: 7,
      jumpPY: 6);

  get _gravity => _createrAnimation.createSpriteSheet(
      tWidth: 33,
      tHeight: 64,
      cols: 7,
      rows: 3,
      iX: 20,
      iY: 469,
      jumpPX: 7,
      jumpPY: 6);

  CustomAnimation idle() =>
      _idle.createAnimation(0, from: 0, to: 11, stepTime: 0.05, loop: true);

  CustomAnimation walking() =>
      _walking.createAnimation(0, from: 0, to: 11, stepTime: 0.05, loop: true);

  CustomAnimation attaking() => _attaking.createAnimation(0,
      from: 0, to: 20, stepTime: 0.05, loop: false);

  CustomAnimation jumping() =>
      _jumping.createAnimation(0, from: 0, to: 7, stepTime: 0.05, loop: false);

  CustomAnimation falling() => _jumping
      .createAnimation(0, from: 0, to: 7, stepTime: 0.05, loop: false)
      .reversed();

  CustomAnimation gravity() => _gravity
      .createAnimation(0, from: 0, to: 21, stepTime: 0.05, loop: false)
      .reversed();
}

class AlienHunterGoldenColorBlue extends AlienHunterGoldenColor {
  
  static final AlienHunterGoldenColorBlue _instance =
      AlienHunterGoldenColorBlue.fromCreaterAnimation();

  factory AlienHunterGoldenColorBlue() => _instance;

  AlienHunterGoldenColorBlue.fromCreaterAnimation()
      : super.fromCreaterAnimation(
            CreaterAnimation(ConstEntityAssets.ALIEN_HUNTER_GOLD_BLUE_MG));
}

class AlienHunterGoldenColorDark extends AlienHunterGoldenColor {
  
  static final AlienHunterGoldenColorDark _instance =
      AlienHunterGoldenColorDark.fromCreaterAnimation();

  factory AlienHunterGoldenColorDark() => _instance;

  AlienHunterGoldenColorDark.fromCreaterAnimation()
      : super.fromCreaterAnimation(
            CreaterAnimation(ConstEntityAssets.ALIEN_HUNTER_GOLD_DARK_MG));
}

class AlienHunterGoldenColorGreen extends AlienHunterGoldenColor {
  
  static final AlienHunterGoldenColorGreen _instance =
      AlienHunterGoldenColorGreen.fromCreaterAnimation();

  factory AlienHunterGoldenColorGreen() => _instance;

  AlienHunterGoldenColorGreen.fromCreaterAnimation()
      : super.fromCreaterAnimation(
            CreaterAnimation(ConstEntityAssets.ALIEN_HUNTER_GOLD_GREEN_MG));
}

class AlienHunterGoldenColorRed extends AlienHunterGoldenColor {
  
  static final AlienHunterGoldenColorRed _instance =
      AlienHunterGoldenColorRed.fromCreaterAnimation();

  factory AlienHunterGoldenColorRed() => _instance;

  AlienHunterGoldenColorRed.fromCreaterAnimation()
      : super.fromCreaterAnimation(
            CreaterAnimation(ConstEntityAssets.ALIEN_HUNTER_GOLD_RED_MG));
}

class AlienHunterGoldenColorYellow extends AlienHunterGoldenColor {
  
  static final AlienHunterGoldenColorYellow _instance =
      AlienHunterGoldenColorYellow.fromCreaterAnimation();

  factory AlienHunterGoldenColorYellow() => _instance;

  AlienHunterGoldenColorYellow.fromCreaterAnimation()
      : super.fromCreaterAnimation(
            CreaterAnimation(ConstEntityAssets.ALIEN_HUNTER_GOLD_YELLOW_MG));
}
