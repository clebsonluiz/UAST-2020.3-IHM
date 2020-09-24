import 'dart:ui';

import 'package:flame/anchor.dart';
import 'package:flame/position.dart';
import 'package:flame/text_config.dart';
import 'package:flutter/material.dart';
import 'package:ihm_2020_3/src/controller/game/game_controller.dart';
import 'package:ihm_2020_3/src/model/entity/symbol/symbol_object.dart';
import 'package:ihm_2020_3/src/model/entity/symbol/symbol_object_box_cave.dart';
import 'package:ihm_2020_3/src/model/entity/symbol/symbol_object_box_color.dart';
import 'package:ihm_2020_3/src/model/map/map_tester.dart';

import 'level_controller.dart';

class Level1 extends LevelController {
  
  TextConfig config = TextConfig(fontSize: 25.0, fontFamily: 'Awesome Font', color: Colors.red);
  TextConfig emoji = TextConfig(fontSize: 25.0, fontFamily: 'Awesome Font', color: Colors.red);
  
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
    config.render(canvas, "→", p, );
    
    final e = "🤔";

    // print(String.fromCharCode(e.runes.single));
    // print(e.length);
    symbol.setPosition(x: p.x, y: p.y);
    
    symbol.renderOnTiled(canvas, this.tileMap);
    // canvas.save();
    // double scale = 1.0;
    // canvas.translate(p.x - (p.x * scale), 0);
    // canvas.scale(scale, 1.0);
    // emoji.render(canvas, e, p, anchor: Anchor.center);
    // canvas.restore();
  }

  @override
  void update(double dt) {
    super.update(dt);
    symbol.update(dt);
  }
}
