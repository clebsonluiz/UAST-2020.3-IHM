import 'dart:ui';

import 'package:flame/position.dart';
import 'package:flutter/material.dart';
import 'package:ihm_2020_3/src/controller/game/game_controller.dart';
import 'package:ihm_2020_3/src/model/map/map_levels.dart';

import 'level_controller.dart';

class Level1Controller extends LevelController {
  Level1Controller(GameController controller) : super(controller, MapLevel1());

  @override
  Future init() async {
    await Future.delayed(Duration(seconds: 3)).then((value) async {
      await super.init();
    });
    await this.game.currentQuest.build();
    return Future.value();
  }

  @override
  Position get playerPosition => Position(92, 32.0 * 5);

  List<Position> get doorsPositions {
    final _height = (0.2 * 32 * 8);
    return [
      Position(70, 32 * 6.0 - _height),
      Position(100, 32 * 27 - _height),
      Position(32 * 26.0, 32 * 8 - _height),
      Position(32 * 23.0, 32 * 17 - _height),
      Position(100, 32 * 16 - _height),
    ];
  }

  final _altPositions = [
    Position(32 * 11.0, 32 * 12.0),
    Position(32 * 16.0, 32 * 21.0),
    Position(32 * 22.0, 32 * 24.0),
    Position(32 * 17.0, 32 * 4.0),
  ];

  List<Position> get alternativasPositions => this._altPositions;

  // @override
  // void actionButtonFour() {
  //   this.game.player.doJump();
  // }

  // @override
  // void actionButtonTree() {
  //   this.game.player.changeGravity();
  // }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  @override
  void update(double dt) {
    super.update(dt);
  }
}
