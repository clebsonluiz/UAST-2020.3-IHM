import 'package:ihm_2020_3/src/model/abstracts/customs/custom_sprite_animation.dart';
import 'package:ihm_2020_3/src/model/animations/creater_animation.dart';

class AlienMiniUFO {

  static Future<Map> _generate() async => {
    'Name': 'Alien Mini-UFO',
    'By': 'Magma Dragoon',
    'Animations': [
      _idle,
      // _walking,
    ],
  } ;

  static final Future<Map> detalhes = _generate();

  static const int IDLE = 0;
  static const int WALKING = 1;

  static final animations = [
    idle(),
    walking(),
  ];

  static const String ALIEN_MINI_UFO_MG =
      'Neo Geo NGCD - Metal Slug 2 Metal Slug X - Mini-UFO.png';

  static const CreaterAnimation _createrAnimation =
      CreaterAnimation(ALIEN_MINI_UFO_MG);

  static var _idle = _createrAnimation.createSpriteSheet(
      tWidth: 46,
      tHeight: 40,
      cols: 8,
      rows: 4,
      iX: 5,
      iY: 7,
      jumpPX: 0,
      jumpPY: 1,
      ignoreLasts: 16);

  static var _walking = _createrAnimation.createSpriteSheet(
      tWidth: 46,
      tHeight: 40,
      cols: 8,
      rows: 4,
      iX: 5,
      iY: 7,
      jumpPX: 0,
      jumpPY: 1,
      ignoreFirsts: 16);

  static CustomAnimation idle() =>
      _idle.createAnimation(0, from: 0, to: 16, stepTime: 0.05, loop: true);

  static CustomAnimation walking() =>
      _walking.createAnimation(0, from: 0, to: 16, stepTime: 0.05, loop: true);
}
