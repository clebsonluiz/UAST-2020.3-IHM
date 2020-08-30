import 'package:ihm_2020_3/src/model/abstracts/customs/custom_sprite_animation.dart';
import 'package:ihm_2020_3/src/model/animations/creater_animation.dart';

class AlienSmasher{

  static Future<Map> _generate() async => {
    'Name': 'Alien Smasher',
    'By': 'Random Rebel Soldier',
    'Animations': [
      _idle,
      _walking,
    ],
  } ;

  static final Future<Map> detalhes = _generate();

  static const int IDLE = 0;
  static const int WALKING = 1;

  static final animations = [
    idle(),
    walking(),
  ];

  static const String ALIEN_SMASHER_MG =
      'Arcade - Metal Slug 6 - Smasher (Edited).png';

  static const CreaterAnimation _createrAnimation =
      CreaterAnimation(ALIEN_SMASHER_MG);

  static var _idle = _createrAnimation.createSpriteSheet(
      tWidth: 64,
      tHeight: 48,
      cols: 6,
      rows: 2,
      iX: 2,
      iY: 2,
      jumpPX: 2,
      jumpPY: 2,
      ignoreLasts: 0);

  static var _walking = _createrAnimation.createSpriteSheet(
      tWidth: 64,
      tHeight: 48,
      cols: 6,
      rows: 2,
      iX: 2,
      iY: 102,
      jumpPX: 2,
      jumpPY: 2,
      ignoreFirsts: 0);

  static CustomAnimation idle() =>
      _idle.createAnimation(0, from: 0, to: 12, stepTime: 0.05, loop: true);

  static CustomAnimation walking() =>
      _walking.createAnimation(0, from: 0, to: 12, stepTime: 0.05, loop: true);
}
