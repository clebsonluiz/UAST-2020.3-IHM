import 'package:ihm_2020_3/src/model/abstracts/customs/custom_sprite_animation.dart';
import 'package:ihm_2020_3/src/model/animations/creater_animation.dart';

class FleshEatingSlug {
  static Future<Map> _generate() async => {
        'Name': 'Flesh Eating Slug',
        'By': 'Azm Vespes',
        'Animations': [
          _idle,
          // _walking,
        ],
      };

  static final Future<Map> detalhes = _generate();

  static const int IDLE = 0;
  static const int WALKING = 1;
  static const int HURT = 2;
  static const int ATTACK = 3;

  static final animations = [
    idle(),
    walking(),
    hurt(),
    attack(),
  ];

  static const String FLESH_EATING_SLUG_MG =
      'Game Boy GBC - Harry Potter & the Chamber of Secrets - Flesh Eating Slug (Edited).png';

  static const CreaterAnimation _createrAnimation =
      CreaterAnimation(FLESH_EATING_SLUG_MG);

  static var _idle = _createrAnimation.createSpriteSheet(
      tWidth: 27,
      tHeight: 27,
      cols: 6,
      rows: 1,
      iX: 58,
      iY: 5,
      jumpPX: 0,
      jumpPY: 0,
      ignoreLasts: 0);

  static var _walking = _createrAnimation.createSpriteSheet(
      tWidth: 27,
      tHeight: 27,
      cols: 6,
      rows: 1,
      iX: 58,
      iY: 5,
      jumpPX: 0,
      jumpPY: 0,
      ignoreLasts: 0);

  static var _hurt = _createrAnimation.createSpriteSheet(
      tWidth: 27,
      tHeight: 27,
      cols: 4,
      rows: 1,
      iX: 58,
      iY: 38,
      jumpPX: 0,
      jumpPY: 0,
      ignoreLasts: 0);

  static var _attack = _createrAnimation
      .createSpriteSheetFromPositions(tWidth: 30, tHeight: 27, positions: [
    {'x': 58, 'y': 71},
    {'x': 93, 'y': 71},
    {'x': 128, 'y': 71},
    {'x': 198, 'y': 71},
  ]);

  static CustomAnimation idle() =>
      _idle.createAnimation(0, from: 0, to: 6, stepTime: 0.05, loop: true);

  static CustomAnimation walking() =>
      _walking.createAnimation(0, from: 0, to: 6, stepTime: 0.05, loop: true);

  static CustomAnimation hurt() =>
      _hurt.createAnimation(0, from: 0, to: 4, stepTime: 0.05, loop: true);

  static CustomAnimation attack() =>
      _attack.createAnimation(0, from: 0, to: 4, stepTime: 0.05, loop: true);
}
