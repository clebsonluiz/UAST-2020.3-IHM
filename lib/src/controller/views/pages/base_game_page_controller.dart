import 'dart:math';

import 'package:flame/flame.dart';
import 'package:flame/position.dart';
import 'package:flutter/material.dart';
import 'package:ihm_2020_3/src/controller/game/game_controller.dart';
import 'package:ihm_2020_3/src/controller/game/mixin_game_controller.dart';
import 'package:ihm_2020_3/src/model/animations/alien_hunter_golden_colors.dart';
import 'package:ihm_2020_3/src/model/entity/component/key_object_colors.dart';
import 'package:ihm_2020_3/src/model/utils/game_model_constants.dart';
import 'package:ihm_2020_3/src/view/pages/base_game_page.dart';
import 'package:ihm_2020_3/src/view/pages/game_over_page.dart';
import 'package:ihm_2020_3/src/view/pages/rank_page.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class BaseGamePageController extends ControllerMVC {
  Widget _alienWidget;
  Widget _alienWidgetYellow;
  Widget _alienWidgetBlue;
  Widget _alienWidgetDark;
  Widget _alienWidgetGreen;
  Widget _alienWidgetRed;

  BaseGamePageController() {
    this._mainGame = GameController(this);

    _alienWidgetDark = Flame.util.animationAsWidget(
        Position(30, 30), AlienHunterGoldenColorDark().idle());
    _alienWidgetBlue = Flame.util.animationAsWidget(
        Position(30, 30), AlienHunterGoldenColorBlue().idle());
    _alienWidgetGreen = Flame.util.animationAsWidget(
        Position(30, 30), AlienHunterGoldenColorGreen().idle());
    _alienWidgetYellow = Flame.util.animationAsWidget(
        Position(30, 30), AlienHunterGoldenColorYellow().idle());
    _alienWidgetRed = Flame.util.animationAsWidget(
        Position(30, 30), AlienHunterGoldenColorRed().idle());
  }

  bool _visible = true;

  bool _selectionMode = false;

  bool _asKeyRed = false;
  bool _asKeyBlue = false;
  bool _asKeyGreen = false;
  bool _asKeyYellow = false;

  Widget get alienWidget => this._alienWidget ??= this._alienWidgetDark;

  bool get visible => _visible;

  bool get selectionMode => _selectionMode;

  bool get asKeyRed => _asKeyRed;
  bool get asKeyBlue => _asKeyBlue;
  bool get asKeyGreen => _asKeyGreen;
  bool get asKeyYellow => _asKeyYellow;

  void onSelectionMode() {
    setState(() {
      this._selectionMode = !this._selectionMode;
      if (selectionMode) {
        this._asKeyRed = this.game.player.currentKeys.contains(KeyRed());
        this._asKeyBlue = this.game.player.currentKeys.contains(KeyBlue());
        this._asKeyGreen = this.game.player.currentKeys.contains(KeyGreen());
        this._asKeyYellow = this.game.player.currentKeys.contains(KeyYellow());
      }
    });
  }

  void onResetKey(){
    setState(() => this._alienWidget = this._alienWidgetDark);
  }

  void onAsKeyRed() {
    this.game.player.changeToRed();
    setState(() => this._alienWidget = this._alienWidgetRed);
    onSelectionMode();
  }

  void onAsKeyBlue() {
    this.game.player.changeToBlue();
    setState(() => this._alienWidget = this._alienWidgetBlue);
    onSelectionMode();
  }

  void onAsKeyGreen() {
    this.game.player.changeToGreen();
    setState(() => this._alienWidget = this._alienWidgetGreen);
    onSelectionMode();
  }

  void onAsKeyYellow() {
    this.game.player.changeToYellow();
    setState(() => this._alienWidget = this._alienWidgetYellow);
    onSelectionMode();
  }

  void onAsKeyDark() {
    this.game.player.changeToDark();
    setState(() => this._alienWidget = this._alienWidgetDark);
    onSelectionMode();
  }

  void actionObjective() {
    setState(() {
      this._visible = !this._visible;
    });
    this.game.actionObjective();
  }

  Future<void> onActionHelp() async {
    _pausedGame = true;
    this.game.pauseGame();

    await _showDialog(this.state.alertHelp());

    _pausedGame = false;
    this.game.resumeGame();
  }

  bool _pausedGame = false;

  bool get isActive => !_pausedGame;

  MixinGameController _mainGame;

  GameController get game => this._mainGame;

  @override
  BaseGamePageState get state => super.state;

  DateTime _backButtonPressTime;

  static const _duration = Duration(milliseconds: 300);

  Future<bool> onWillPop() async {
    _pausedGame = true;
    this.game.pauseGame();

    DateTime currentTime = DateTime.now();

    bool backButtonHasNotBeenPressed = _backButtonPressTime == null ||
        currentTime.difference(_backButtonPressTime) > _duration;

    if (backButtonHasNotBeenPressed) {
      _backButtonPressTime = currentTime;
      await _showDialog(this.state.alert());

      _pausedGame = false;
      this.game.resumeGame();
    }

    return _pausedGame && true;
  }

  Future<void> _showDialog(Widget child, {bool dimissible = false}) async {
    return showDialog<void>(
      context: this.stateMVC.context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) => child,
    );
  }

  Widget get imageContinuar => _buildImg(
      image: AnotherConsts.MENU_ITEM_2, color: Colors.lightGreenAccent);
  Widget get imageSair =>
      _buildImg(image: AnotherConsts.MENU_ITEM_4, color: Colors.redAccent);

  Widget _buildImg({String image, double maxHeight = 25, Color color}) {
    return LimitedBox(
        key: Key("${Random(10).nextDouble()}" + image),
        maxHeight: maxHeight,
        child: Stack(
          children: <Widget>[
            Image.asset(
              'assets/images/' + image.toString(),
              color: color,
              colorBlendMode: BlendMode.modulate,
            )
          ],
        ));
  }

  Future navigationGameOver() async =>
      Navigator.pushReplacementNamed(this.state.context, GameOverPage.ROUTE);
  Future navigationRank() async =>
      Navigator.pushReplacementNamed(this.state.context, RankPage.ROUTE);

  navigatorPop() => Navigator.of(this.state.context).pop();
  navigatorExit() {
    navigatorPop();
    navigatorPop();
  }
}
