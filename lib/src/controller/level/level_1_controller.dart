import 'dart:ui';

import 'package:flame/position.dart';
import 'package:flutter/material.dart';
import 'package:ihm_2020_3/src/controller/game/game_controller.dart';
import 'package:ihm_2020_3/src/model/entity/symbol/symbol_object.dart';
import 'package:ihm_2020_3/src/model/entity/symbol/symbol_object_box_color.dart';
import 'package:ihm_2020_3/src/model/map/map_tester.dart';

import 'level_controller.dart';

class Level1 extends LevelController {
  
  
  final SymbolObject symbol = SymbolObjectBoxColorGreen();
  
  Level1(GameController controller) : super(controller, MapTester());

  @override
  Future init() async {
    this.tileMap.setTween(1);
    this.game.player.setCurrentStatus(this.tileMap, Position(70.0, 80));
    
    await Future.delayed(Duration(seconds: 3)).then((value){
      this.greenDoor.setPosition(x: 100, y: 672 - this.greenDoor.component.height);
    });
    Future.value();
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
    
    final p = Position(100, 100);
    
    final e = "🤔";

    symbol.setPosition(x: p.x, y: p.y);
    
    symbol.renderOnTiled(canvas, this.tileMap);

  }

  @override
  void update(double dt) {
    super.update(dt);
    symbol.update(dt);
  }
}
