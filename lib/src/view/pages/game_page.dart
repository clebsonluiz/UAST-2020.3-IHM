import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ihm_2020_3/src/controller/game/game_controller.dart';
import 'package:ihm_2020_3/src/controller/game/mixin_game_controller.dart';
import 'package:ihm_2020_3/src/view/components/dpad_buttom_widget.dart';
import 'package:ihm_2020_3/src/view/components/dpad_joystick_widget.dart';
import 'package:ihm_2020_3/src/view/components/dpad_widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class GamePage extends StatefulWidget {
  static const ROUTE = "/main-game-route";

  const GamePage({Key key}) : super(key: key);

  @override
  _GamePageState createState() {
    return _GamePageState();
  }
}

class _GamePageState extends StateMVC<GamePage> {
  _GamePageState() : super(_GamePageController());

  _GamePageController get con => this.controller;

  final GlobalKey _globalKey = GlobalKey();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  Widget _screenGame() {
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
        child: Container(
          color: Colors.black,
          child: Padding(
            padding: EdgeInsets.only(top: 20, bottom: 5, left: 5, right: 5),
            child: ClipRRect(
              key: _globalKey,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: con.game != null ? con.game.widget : Center(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _dpadGame() {
    return Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            bottom: 0,
            top: 5,
          ),
          child: SizedBox(
            height: 240,
            child: Container(
              // color: Colors.white,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black,
                    Colors.grey,
                    // Colors.black,
                    // Colors.transparent,
                    // Colors.black,
                    // Colors.grey,
                    // Colors.white,
                    // Colors.white,
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  DpadWidget(
                    topButtom: SizedBox(
                        height: 40,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            DpadButtonWidget(
                              onAction: con.game.actionObjective,
                              iconData: Icons.inbox,
                              onReleasedColor: Colors.deepOrange,
                              onSelectedColor: Colors.white,
                              iconReleasedColor: Colors.white,
                              iconSelectedColor: Colors.deepOrange,
                            ),
                            // DpadButtonWidget(
                            //   iconData: Icons.touch_app,
                            //   onAction: () {},
                            // ),
                          ],
                        )),
                    botoesDirecionais: <Widget>[
                      DpadJoystickWidget(onChange: con.game.actionMovement)
                    ],
                    botoesAcao: <Widget>[
                      DpadButtonWidget(
                        iconData: Icons.looks_one,
                        onAction: con.game.actionButtonOne,
                      ),
                      DpadButtonWidget(
                        iconData: Icons.looks_two,
                        onAction: con.game.actionButtonTwo,
                      ),
                      DpadButtonWidget(
                        iconData: Icons.looks_3,
                        onAction: con.game.actionButtonTree,
                      ),
                      DpadButtonWidget(
                        iconData: Icons.looks_4,
                        onAction: con.game.actionButtonFour,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: WillPopScope(
          onWillPop: con.onWillPop,
          child: Stack(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _screenGame(),
                  _dpadGame(),
                ],
              ),
              // con.isActive
              //     ? Center()
              //     : Container(
              //         color: Colors.black87,
              //       )
            ],
          )),
    );
  }
}

class _GamePageController extends ControllerMVC {
  bool _pausedGame = false;

  bool get isActive => !_pausedGame;

  final MixinGameController _mainGame = GameController();

  GameController get game => this._mainGame;

  @override
  _GamePageState get state => super.state;

  DateTime _backButtonPressTime;

  static const _duration = Duration(seconds: 1);

  Future<bool> onWillPop() async {
    _pausedGame = true;
    this.game.pauseGame();

    DateTime currentTime = DateTime.now();

    bool backButtonHasNotBeenPressed = _backButtonPressTime == null ||
        currentTime.difference(_backButtonPressTime) > _duration;

    if (backButtonHasNotBeenPressed) {
      _backButtonPressTime = currentTime;
      await _showDialog(Center());

      _pausedGame = false;
      this.game.resumeGame();
    }

    return _pausedGame && true;
  }

  Future<void> _showDialog(Widget child, {bool dimissible = false}) async {
    return showDialog<void>(
      context: this.stateMVC.context,
      barrierDismissible: dimissible, // user must tap button!
      builder: (BuildContext context) => child,
    );
  }

  Future<void> showMyDialog(String msg, {String title}) async {
    return _showDialog(
      AlertDialog(
        title: Text(title ?? 'Oops!',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.black54)),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(msg,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black54)),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('OK'),
            onPressed: navigatorPop,
          ),
        ],
      ),
    );
  }

  navigatorPop() => Navigator.of(this.state.context).pop();
}
