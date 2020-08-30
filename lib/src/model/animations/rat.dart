import 'package:ihm_2020_3/src/model/abstracts/customs/custom_sprite_animation.dart';
import 'package:ihm_2020_3/src/model/animations/creater_animation.dart';

class Rat{
    static Future<Map> _generate() async => {
        'Name': 'Rat',
        'By': 'Division',
        'Animations': [
          _walking,
        ],
      };

  static final Future<Map> detalhes = _generate();

  static const int WALKING = 0;

  static final animations = [
    walking(),
  ];

  static const String RAT_MG =
      'Neo Geo NGCD - Metal Slug 2 Metal Slug X - Rat.png';

  static const CreaterAnimation _createrAnimation =
      CreaterAnimation(RAT_MG);

  static var _walking = _createrAnimation.createSpriteSheet(
    tWidth: 25,
    tHeight: 9,
    cols: 6,
    rows: 1,
    iX: 10,
    iY: 33,
    jumpPX: 4,
    jumpPY: 0,
  );


  static CustomAnimation walking() =>
      _walking.createAnimation(0, from: 0, to: 6, stepTime: 0.05, loop: true);
}