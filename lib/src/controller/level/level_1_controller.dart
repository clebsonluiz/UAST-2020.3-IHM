import 'dart:ui';

import 'package:flame/position.dart';
import 'package:ihm_2020_3/src/controller/game/game_controller.dart';
import 'package:ihm_2020_3/src/model/map/map_tester.dart';

import 'level_controller.dart';

class Level1 extends LevelController {
  Level1(GameController controller) : super(controller, MapTester());

  @override
  Future init() async {
    this.tileMap.setTween(1);
    this.game.player.setCurrentStatus(this.tileMap, Position(70.0, 80));
  }

  @override
  void actionButtonFour() {
    this.game.player.doJump();
  }

  @override
  void actionButtonTwo() {
    this.game.player.changeGravity();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  @override
  void update(double dt) {
    super.update(dt);
  }
}
