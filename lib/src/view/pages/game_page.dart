import 'dart:async';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:ihm_2020_3/src/controller/game/game_controller.dart';
import 'package:ihm_2020_3/src/controller/game/mixin_game_controller.dart';
import 'package:ihm_2020_3/src/view/components/dpad_buttom_widget.dart';
import 'package:ihm_2020_3/src/view/components/dpad_joystick_widget.dart';
import 'package:ihm_2020_3/src/view/components/dpad_widget.dart';

class GamePage extends StatefulWidget {
  
  static const ROUTE = "/main-game-route";

  final MixinGameController mainGame;

  const GamePage({Key key, @required this.mainGame}) : super(key: key);

  @override
  _GamePageState createState() {
    return _GamePageState();
  }
}

class _GamePageState extends State<GamePage> {
  final GlobalKey _globalKey = GlobalKey();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  DateTime backButtonPressTime;

  static const snackBarDuration = Duration(seconds: 2);

  final snackBar = SnackBar(
    content: Text('Pressione Novamente Para Sair'),
    duration: snackBarDuration,
  );

  Future<bool> onWillPop() async {
    DateTime currentTime = DateTime.now();

    bool backButtonHasNotBeenPressedOrSnackBarHasBeenClosed =
        backButtonPressTime == null ||
            currentTime.difference(backButtonPressTime) > snackBarDuration;

    if (backButtonHasNotBeenPressedOrSnackBarHasBeenClosed) {
      backButtonPressTime = currentTime;
      scaffoldKey.currentState.showSnackBar(snackBar);
      return false;
    }

    return true;
  }

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
              child:
                  widget.mainGame != null ? widget.mainGame.widget : Center(),
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
                              onAction: widget.mainGame.actionObjective,
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
                      DpadJoystickWidget(
                          onChange: widget.mainGame.actionMovement)
                    ],
                    botoesAcao: <Widget>[
                      DpadButtonWidget(
                        iconData: Icons.looks_one,
                        onAction: widget.mainGame.actionButtonOne,
                      ),
                      DpadButtonWidget(
                        iconData: Icons.looks_two,
                        onAction: widget.mainGame.actionButtonTwo,
                      ),
                      DpadButtonWidget(
                        iconData: Icons.looks_3,
                        onAction: widget.mainGame.actionButtonTree,
                      ),
                      DpadButtonWidget(
                        iconData: Icons.looks_4,
                        onAction: widget.mainGame.actionButtonFour,
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
        onWillPop: onWillPop,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _screenGame(),
            _dpadGame(),
          ],
        ),
      ),
    );
  }
}
