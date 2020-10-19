import 'dart:ui';

import 'package:flame/game.dart';
import 'package:ihm_2020_3/src/controller/level/level_1_controller.dart';
import 'package:ihm_2020_3/src/controller/level/level_2_controller.dart';
import 'package:ihm_2020_3/src/controller/level/level_3_controller.dart';
import 'package:ihm_2020_3/src/controller/level/level_4_controller.dart';
import 'package:ihm_2020_3/src/controller/level/level_controller.dart';
import 'package:ihm_2020_3/src/model/database/utils/rank_utils..dart';
import 'package:ihm_2020_3/src/model/entity/component/key_object_colors.dart';
import 'package:ihm_2020_3/src/model/entity/player/player_game.dart';
import 'package:ihm_2020_3/src/model/map/map_objectives.dart';
import 'package:ihm_2020_3/src/model/objetivo/objetivo.dart';
import 'package:ihm_2020_3/src/model/objetivo/quest_expressao.dart';
import 'package:ihm_2020_3/src/view/components/dpad_joystick_widget.dart';
import 'package:ihm_2020_3/src/controller/views/pages/base_game_page_controller.dart';
import 'mixin_game_controller.dart';

class GameController extends Game implements MixinGameController {

  
  final BaseGamePageController gamePageController;



  final MapObjectiveExpression objective = MapObjectiveExpression();

  final Duration _initialTime = Duration(days: 1, minutes: 0, seconds: 0);

  double _elapsed = 0.0;

  Duration get currentTime {
    final duration = _initialTime +
        Duration(minutes: 0, seconds: 0, milliseconds: _elapsed.toInt() * 1000);

    return duration;
  }

  Objetivo get currentObjetivo => Objetivo();

  QuestExpressao get currentQuest => currentObjetivo.current;

  bool _loaded = false;

  bool loaded() => this._loaded;

  LevelController _currentLevel;
  PlayerGame _playerGame;

  PlayerGame get player => this._playerGame;

  final List<LevelController> _gameLevels = [];

  Size _size;

  Size get size => this._size;


  //TODO 
  Future<void> goToNextlevel() async {
    try{
      final current = this._gameLevels.removeAt(0);
      this._currentLevel = this._gameLevels.first;
      await this._currentLevel.init();
      await this.currentObjetivo.proximoObjetivo();
      await this.currentQuest.build();
    }catch(e){
      if(this._gameLevels.length <= 0){
        RankUtils().vidasRestantes = this.player.life;
        RankUtils().tempoDecorrido = this.currentTime;
        this.gamePageController.navigationRank();
      }
    }
    return Future.value();
  }

  GameController(this.gamePageController) {
    final future = _load();

    future.then((value) {
      this._loaded = true;
    });
  }

  Future _load() async {
    await this.currentObjetivo.build();
    this._playerGame = PlayerGame();
    this._gameLevels.addAll([
      Level1Controller(this),
      Level2Controller(this),
      Level3Controller(this),
      Level4Controller(this),
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
    if (!loaded()) return;
    this._currentLevel?.render(canvas);
  }

  @override
  void update(double dt) async {
    if (!loaded()) return;
    this._currentLevel?.update(dt);
    this._elapsed += dt;
    if(this.player.isDead){
      this.pauseGame();
      await this.gamePageController.navigationGameOver();
      this._loaded = false;
    }
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

  bool asGottenRedKey() {
    return this.player.currentKeys.contains(KeyRed());
  }
}
