import 'dart:ui';

import 'package:flame/game.dart';
import 'package:ihm_2020_3/src/controller/level/level_1_controller.dart';
import 'package:ihm_2020_3/src/controller/level/level_controller.dart';
import 'package:ihm_2020_3/src/model/entity/player/player_game.dart';
import 'package:ihm_2020_3/src/view/components/dpad_joystick_widget.dart';
import 'mixin_game_controller.dart';

class GameController extends Game implements MixinGameController {

  final Duration _initialTime = Duration(days: 1, minutes: 0, seconds: 0);

  double _elapsed = 0.0;


  Duration get currentTime  {
    final duration = _initialTime + Duration(minutes: 0, seconds: 0, milliseconds: _elapsed.toInt() * 1000);

    return duration;
  }


  bool _loaded;

  bool loaded() => this._loaded;

  LevelController _currentLevel;
  PlayerGame _playerGame;

  PlayerGame get player => this._playerGame;

  final List<LevelController> _gameLevels = [];


  Size _size;

  Size get size => this._size;

  // LevelController goToNextlevel(){
  //   final current = this._currentLevel;
  //   final index = this._gameLevels.indexOf(current);
  //   final nIndex = this._gameLevels.elementAt(index + 1);
  // }

  GameController() {
    final future = _load();

    future.then((value) {
      this._loaded = true;
    });
  }

  Future _load() async {
    this._playerGame = PlayerGame();
    this._gameLevels.addAll([
      Level1(this),

    ]);
    this._currentLevel = this._gameLevels.first;
    await this._currentLevel.init();
    return Future.value(true);
  }

  void pauseGame() => this.pauseEngine();
  void resumeGame() => this.resumeEngine();

  @override
  void resize(Size size) {
    this._size = size;
    this._gameLevels?.forEach((level) => level.resize());
  }

  @override
  void render(Canvas canvas) {
    this._currentLevel?.render(canvas);
  }

  @override
  void update(double dt) {
    this._currentLevel?.update(dt);
    this._elapsed += dt;
  }

  @override
  void actionButtonOne() => this._currentLevel?.actionButtonOne();

  @override
  void actionButtonTwo() => this._currentLevel?.actionButtonTwo();

  @override
  void actionButtonTree() => this._currentLevel?.actionButtonTree();

  @override
  void actionButtonFour() => this._currentLevel?.actionButtonFour();

  @override
  void actionObjective() => this._currentLevel?.actionObjective();

  @override
  void actionMovement(Offset offset, JoystickDirection direction) {
    this._currentLevel?.actionMovement(offset, direction);
  }
}
