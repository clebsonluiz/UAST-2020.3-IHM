import 'package:ihm_2020_3/src/model/abstracts/customs/custom_sprite_animation.dart';
import 'package:ihm_2020_3/src/model/animations/creater_animation.dart';

class AlienUFO {
  static Future<Map> _generate() async => {
        'Name': 'Alien UFO',
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

  static const String ALIEN_UFO_MG =
      'Neo Geo NGCD - Metal Slug 3 - UFO.png';

  static const CreaterAnimation _createrAnimation =
      CreaterAnimation(ALIEN_UFO_MG);

  static var _idle = _createrAnimation.createSpriteSheet(
    tWidth: 56,
    tHeight: 35,
    cols: 6,
    rows: 2,
    iX: 5,
    iY: 4,
    jumpPX: 0,
    jumpPY: 4,
  );

  static CustomAnimation idle() =>
      _idle.createAnimation(0, from: 0, to: 12, stepTime: 0.05, loop: true);

}
