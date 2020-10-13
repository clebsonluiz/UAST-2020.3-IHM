import 'dart:ui';

import 'package:flame/position.dart';
import 'package:flutter/material.dart';
import 'package:ihm_2020_3/src/controller/game/game_controller.dart';
import 'package:ihm_2020_3/src/model/abstracts/customs/custom_tiled_component.dart';
import 'package:ihm_2020_3/src/model/entity/component/door_object.dart';
import 'package:ihm_2020_3/src/model/entity/component/door_object_colors.dart';
import 'package:ihm_2020_3/src/model/entity/component/key_object.dart';
import 'package:ihm_2020_3/src/model/entity/symbol/symbol_object.dart';
import 'package:ihm_2020_3/src/model/entity/symbol/symbol_object_box_color.dart';
import 'package:ihm_2020_3/src/model/entity/symbol/symbol_object_box_timer.dart';
import 'package:ihm_2020_3/src/model/objetivo/quest_expressao.dart';

import 'mixin_game_actions.dart';
import 'mixin_game_methods.dart';
import 'package:ihm_2020_3/src/view/components/dpad_joystick_widget.dart';

abstract class LevelController implements MixinGameActions, MixinGameMethods {
  final CustomTiledComponent _tileMap;

  final GameController _controller;

  final _doors = <DoorObject>[];
  final _keys = <KeyObject>[];

  bool _interrupt = false;

  CustomTiledComponent get tileMap => this._tileMap;

  GameController get game => this._controller;

  DoorObject get greenDoor => DoorObjectGreen();
  DoorObject get yellowDoor => DoorObjectYellow();
  DoorObject get blueDoor => DoorObjectBlue();
  DoorObject get redDoor => DoorObjectRed();
  DoorObject get whiteDoor => DoorObjectWhite();

  SymbolObjectBoxTimer get timer => SymbolObjectBoxTimerWhite();

  LevelController(this._controller, this._tileMap)
      : assert(_controller != null && _tileMap != null) {
    _doors
      ..clear()
      ..addAll([
        whiteDoor,
        blueDoor,
        greenDoor,
        yellowDoor,
        redDoor,
      ]);
  }

  @mustCallSuper
  Future init() async {
    this.tileMap.setTween(1);
    this.game.player.changeToDark();
    this.game.player.currentKeys.clear();
    this.game.player.setCurrentStatus(this.tileMap, this.playerPosition);
    final _doorPos = this.doorsPositions;

    for (var i = 0; i < _doors.length; i++) {
      var _pos = _doorPos[i];
      var _door = _doors[i];
      _door.setPosition(x: _pos.x, y: _pos.y);
    }

    return Future.value();
  }

  Position get playerPosition;
  List<Position> get doorsPositions;
  List<Position> get alternativasPositions;

  @override
  void resize() => this.tileMap.resize(this.game.size);

  @override
  void actionButtonFour() {
    this.game.player.doJump();
  }

  @override
  void actionButtonOne() {
    this.game.gamePageController.onSelectionMode();
  }

  @override
  void actionButtonTree() {
    this.game.player.changeGravity();
  }

  @override
  void actionButtonTwo() {
    this._interrupt = true;

    if (_onIntersectQuest()) return;
    if (_onIntersectDoor()) return;

    this._interrupt = false;
  }

  bool _onIntersectQuest() {
    SymbolObjectBoxColor _current;

    final collisionWithQuest = !this.game.currentQuest.alternativas.every((e) {
      _current = e;
      return !this.game.player.isIntersectingAnotherBox(e.toRect());
    });

    if (collisionWithQuest) {
      final resposta = this.game.currentQuest.responder(_current);
      if (!resposta) this.game.player.doDamage();

      final _key = _current.dropKey
        ..setPosition(
          x: _current.posX,
          y: _current.posY,
        );

      _keys.add(_key);
    }

    this._interrupt = false;
    return collisionWithQuest;
  }

  bool _onIntersectKey() {
    KeyObject _current;

    final collisionWithKey = !this._keys.every((e) {
      _current = e;
      return !this.game.player.isIntersectingAnotherBox(e.toRect());
    });

    if (collisionWithKey) {
      this._keys.remove(_current);
      this.game.player.currentKeys.add(_current);
    }

    return collisionWithKey;
  }

  //TODO
  bool _onIntersectDoor() {
    final collisionWithDoor = !this._doors.every((e) {
      final same = e.colorCode == this.game.player.currentKeyCode;
      return !(this.game.player.isIntersectingAnotherBox(e.toRect()) && same);
    });

    if (collisionWithDoor) {
      print("Colidiu com porta certa");
    }

    this._interrupt = false;
    return collisionWithDoor;
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
    this.game.objective.changeVisible();
  }

  @override
  void render(Canvas canvas) {
    if (this._interrupt) return;
    this.tileMap.render(canvas);
    this._keys.forEach((key) => key.renderOnTiled(canvas, tileMap));
    this._doors.forEach((door) => door.renderOnTiled(canvas, tileMap));
    this
        .game
        .currentQuest
        .alternativas
        .forEach((alt) => alt.renderOnTiled(canvas, tileMap));
    this.game.player.render(canvas);
    this.timer.renderOnPositioned(canvas);
    this.game.objective.render(
          canvas,
          scale: 0.55,
        );
  }

  @override
  void update(double dt) {
    if (this._interrupt) return;
    this.resize();
    this.game.player.update(dt);
    this.tileMap.updatePosition(
        this.game.size.width / 2 - this.game.player.posX,
        this.game.size.height / 2 - this.game.player.posY);
    this._doors.forEach((door) => door.update(dt));
    this._keys.forEach((key) => key.update(dt));

    _onIntersectKey();
    this.game.currentQuest?.alternativas?.forEach((alt) {
      var lTemp = this.game.currentQuest?.alternativas;
      var pos = alternativasPositions[lTemp.indexOf(alt)];
      alt.posX = alt.posX <= 0 ? pos.x : alt.posX;
      alt.posY = alt.posY <= 0 ? pos.y : alt.posY;
      alt.update(dt);
    });
    if (timer.loaded()) {
      this.timer?.text = this.game.currentTime.toString().substring(3, 8);
      this.timer?.setPosition(
          x: this.game.size.width - this.timer.component?.width - 5, y: 5);
      // this.timer?.update(dt);
    }
    this
        .game
        .objective
        .setPosition(x: this.game.size.width, y: this.game.size.height);
    this.game.objective.update(dt);
  }
}
