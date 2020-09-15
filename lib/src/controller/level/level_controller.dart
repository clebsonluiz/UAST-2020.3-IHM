import 'dart:ui';

import 'package:ihm_2020_3/src/controller/game/game_controller.dart';
import 'package:ihm_2020_3/src/model/abstracts/customs/custom_tiled_component.dart';

import 'mixin_game_actions.dart';
import 'mixin_game_methods.dart';
import 'package:ihm_2020_3/src/view/components/dpad_joystick_widget.dart';

abstract class LevelController implements MixinGameActions, MixinGameMethods {

  final CustomTiledComponent _tileMap;

  final GameController _controller;

  CustomTiledComponent get tileMap => this._tileMap;

  GameController get game => this._controller;


  LevelController(this._controller, this._tileMap) : assert (_controller != null && _tileMap != null) ;
  
  @override
  void resize() => this.tileMap.updateScreenSize(this.game.size);

  @override
  void actionButtonFour() {
    // TODO: implement actionButtonFour
  }

  @override
  void actionButtonOne() {
    // TODO: implement actionButtonOne
  }

  @override
  void actionButtonTree() {
    // TODO: implement actionButtonTree
  }

  @override
  void actionButtonTwo() {
    // TODO: implement actionButtonTwo
  }

  @override
  void actionMovement(Offset offset, JoystickDirection direction) {
    switch (direction) {
      case JoystickDirection.LEFT:
        game.player.walkTo(esquerda: true);
        break;
      case JoystickDirection.RIGHT:
        game.player.walkTo(direita: true);
        break;
      default:
        game.player.doIdle();
    }
  }

  @override
  void actionObjective() {
    // TODO: implement actionObjective
  }

  @override
  void render(Canvas canvas) {
    
    this.tileMap.render(canvas);
    this.game.player.render(canvas);
  }

  @override
  void update(double dt) {
    this.resize();
    this.game.player.update(dt);
    this.tileMap.updatePosition(
      this.game.size.width / 2 - this.game.player.posX,
			this.game.size.height / 2 - this.game.player.posY
    );
  }
}
