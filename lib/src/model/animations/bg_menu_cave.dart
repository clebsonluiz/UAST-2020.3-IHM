import 'dart:math';

import 'package:flame/animation.dart';
import 'package:flame/sprite.dart';

class BgMenuCave {
  static const String BG_MENU_CAVE = 'bg_menu.png';

  static Future<Animation> animation = _generate();

  static Future<Animation> _generate() async {
    List<Sprite> spriteList;
    switch (Random().nextInt(3)) {
      case 0:
        spriteList = List.generate(
            32,
            (index) => Sprite(BG_MENU_CAVE,
                height: 640,
                width: 360,
                x: (32 + index.toDouble()),
                y: (64 + index.toDouble())));

        break;
      case 1:
        spriteList = List.generate(
            128,
            (index) => Sprite(BG_MENU_CAVE,
                height: 640, width: 360, x: (32 + index.toDouble()), y: 0));

        break;
      case 2:
        spriteList = List.generate(
            128,
            (index) => Sprite(BG_MENU_CAVE,
                height: 640,
                width: 360,
                x: (32 + index.toDouble()),
                y: (32 * 10).toDouble()));
        break;
      default:
        spriteList = List.generate(
            128,
            (index) => Sprite(BG_MENU_CAVE,
                height: 640,
                width: 360,
                x: (32 + index.toDouble()),
                y: (32 * 10).toDouble()));
    }
    
    return Animation.spriteList(spriteList, stepTime: 0.05);
  }
}
