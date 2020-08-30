import 'package:ihm_2020_3/src/model/abstracts/customs/custom_sprite_animation.dart';
import 'package:ihm_2020_3/src/model/animations/creater_animation.dart';

class AlienFlyingCommander {

  static Future<Map> _generate() async => {
        'Name': 'Alien Flying Commander',
        'By': 'Division',
        'Animations': [
          _idle,
          // _walking,
        ],
      };

  static final Future<Map> detalhes = _generate();

  static const int IDLE = 0;
  static const int WALKING = 1;

  static final animations = [
    idle(),
    walking(),
  ];

  static const String ALIEN_FLYING_COMMANDER_MG =
      'Arcade - Metal Slug 6 - Flying Commander (Edited).png';

  static const CreaterAnimation _createrAnimation =
      CreaterAnimation(ALIEN_FLYING_COMMANDER_MG);

  static const positions = [
    {'x': 4, 'y': 215},
    {'x': 43, 'y': 215},
    {'x': 83, 'y': 215},
    {'x': 125, 'y': 215},
    {'x': 168, 'y': 215},
    {'x': 212, 'y': 215},
    {'x': 258, 'y': 215},
    {'x': 305, 'y': 215},
    {'x': 353, 'y': 215},
    {'x': 400, 'y': 215},
    {'x': 444, 'y': 215},
    {'x': 487, 'y': 215},
    {'x': 6, 'y': 260},
    {'x': 45, 'y': 260},
    {'x': 84, 'y': 260},
    {'x': 123, 'y': 260},
  ];

  static var _idle = _createrAnimation.createSpriteSheetFromPositions(
      tWidth: 41, tHeight: 30, positions: positions);

  static var _walking = _createrAnimation.createSpriteSheetFromPositions(
      tWidth: 41, tHeight: 30, positions: positions);

  static CustomAnimation idle() =>
      _idle.createAnimation(0, from: 0, to: 16, stepTime: 0.05, loop: true);

  static CustomAnimation walking() =>
      _walking.createAnimation(0, from: 0, to: 16, stepTime: 0.05, loop: true);
}
