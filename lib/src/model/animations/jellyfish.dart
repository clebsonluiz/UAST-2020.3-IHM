import 'package:ihm_2020_3/src/model/abstracts/customs/custom_sprite_animation.dart';
import 'package:ihm_2020_3/src/model/animations/creater_animation.dart';

class Jellyfish {
  static Future<Map> _generate() async => {
        'Name': 'Jellyfish',
        'By': 'Magma Dragoon',
        'Animations': [
          _idle,
        ],
      };

  static final Future<Map> detalhes = _generate();

  static const int IDLE = 0;

  static final animations = [
    idle(),
  ];

  static const String JELLYFISH_MG =
      'Metal Slug 5 - Jellyfish by Magma Dragoon.png';

  static const CreaterAnimation _createrAnimation =
      CreaterAnimation(JELLYFISH_MG);

  static var _idle = _createrAnimation.createSpriteSheet(
      tWidth: 30,
      tHeight: 30,
      cols: 15,
      rows: 3,
      iX: 10,
      iY: 445,
      jumpPX: 2,
      jumpPY: 5,
      ignoreLasts: 4);

  static CustomAnimation idle() =>
      _idle.createAnimation(0, from: 0, to: 41, stepTime: 0.05, loop: true);
}
