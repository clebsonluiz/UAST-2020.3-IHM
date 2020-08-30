import 'package:ihm_2020_3/src/model/abstracts/customs/custom_sprite_animation.dart';
import 'package:ihm_2020_3/src/model/animations/creater_animation.dart';

class AlienHunterWalker {
  
  static Future<Map> _generate() async => {
        'Name': 'Alien Hunter Walker',
        'By': 'Random Rebel Soldier',
        'Animations': [
          _idle,
          _walking,
        ],
      };

  static final Future<Map> detalhes = _generate();

  static const int IDLE = 0;
  static const int WALKING = 1;
  static const int ATTAKING = 2;
  static const int JUMPING = 3;
  static const int FALLING = 4;

  static final animations = [
    idle(),
    walking(),
    attaking(),
    jumping(),
    falling(),
  ];

  static const CreaterAnimation _createrAnimation =
      CreaterAnimation(ALIEN_HUNTER_WALKER_MG);

  static const String ALIEN_HUNTER_WALKER_MG =
      'Arcade - Metal Slug 6 - Hunter Walker (Edited).png';

  static var _idle = _createrAnimation.createSpriteSheet(
      tWidth: 38,
      tHeight: 39,
      cols: 11,
      rows: 1,
      iX: 13,
      iY: 24,
      jumpPX: 11,
      jumpPY: 0);

  static var _walking = _createrAnimation.createSpriteSheet(
      tWidth: 63,
      tHeight: 39,
      cols: 11,
      rows: 1,
      iX: 10,
      iY: 240,
      jumpPX: 2,
      jumpPY: 0);

  static var _attaking = _createrAnimation.createSpriteSheet(
      tWidth: 38,
      tHeight: 35,
      cols: 10,
      rows: 2,
      iX: 20,
      iY: 248,
      jumpPX: 2,
      jumpPY: 3);

  static var _jumping = _createrAnimation.createSpriteSheet(
      tWidth: 37,
      tHeight: 62,
      cols: 9,
      rows: 2,
      iX: 10,
      iY: 94,
      jumpPX: 12,
      jumpPY: 0);

  static CustomAnimation idle() =>
      _idle.createAnimation(0, from: 0, to: 11, stepTime: 0.05, loop: true);

  static CustomAnimation walking() =>
      _walking.createAnimation(0, from: 0, to: 11, stepTime: 0.05, loop: true);

  static CustomAnimation attaking() => _attaking.createAnimation(0,
      from: 0, to: 20, stepTime: 0.05, loop: false);

  static CustomAnimation jumping() =>
      _jumping.createAnimation(0, from: 0, to: 9, stepTime: 0.05, loop: false);

  static CustomAnimation falling() =>
      _jumping.createAnimation(0, from: 9, to: 18, stepTime: 0.05, loop: false);
}
