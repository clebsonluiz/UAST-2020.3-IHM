import 'package:ihm_2020_3/src/model/abstracts/customs/custom_sprite_animation.dart';
import 'package:ihm_2020_3/src/model/animations/creater_animation.dart';

class AlienBigEyes {
  static Future<Map> _generate() async => {
        'Name': 'Alien Big Eyes',
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

  static const String ALIEN_BIG_EYES_MG =
      'Neo Geo NGCD - Metal Slug 3 - Big Eyes.png';

  static const CreaterAnimation _createrAnimation =
      CreaterAnimation(ALIEN_BIG_EYES_MG);

  static var _idle = _createrAnimation.createSpriteSheet(
    tWidth: 35,
    tHeight: 35,
    cols: 8,
    rows: 2,
    iX: 3,
    iY: 70,
    jumpPX: 0,
    jumpPY: 0,
  );



  static CustomAnimation idle() =>
      _idle.createAnimation(0, from: 0, to: 16, stepTime: 0.05, loop: true);

}
