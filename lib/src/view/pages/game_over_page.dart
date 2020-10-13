import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ihm_2020_3/src/model/utils/game_model_constants.dart';
import 'package:ihm_2020_3/src/view/components/menu_buttom_widget.dart';
import 'package:ihm_2020_3/src/view/pages/base_game_page.dart';

import 'package:mvc_pattern/mvc_pattern.dart';

class GameOverPage extends StatefulWidget {
  static const ROUTE = "/game_over";

  GameOverPage();

  @override
  GameOverPageState createState() => GameOverPageState();
}

class GameOverPageState extends StateMVC<GameOverPage> {
  GameOverPageState() : super(GameOverPageController());

  GameOverPageController get con => this.controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: WillPopScope(
        onWillPop: this.con.onWillPop,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              height: 200,
              alignment: Alignment.topCenter,
              child: this.con.imageGameOver,
            ),
            Card(
                color: Colors.transparent,
                child: Container(
                  alignment: Alignment.center,
                  height: 300,
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      MenuButtomWidget(
                          widget: this.con.imageContinuar,
                          onAction: this.con.navigatorToNewGame,
                          splashColor: Colors.lightGreenAccent[800]),
                      MenuButtomWidget(
                          widget: this.con.imageSair,
                          onAction: this.con.navigatorPop,
                          splashColor: Colors.yellow[800]),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

}

class GameOverPageController extends ControllerMVC {
  Widget get imageGameOver =>
      _buildImg(image: AnotherConsts.MENU_ITEM_10, color: Colors.redAccent);

  Widget get imageContinuar => _buildImg(
      image: AnotherConsts.MENU_ITEM_2, color: Colors.lightGreenAccent);
  Widget get imageSair =>
      _buildImg(image: AnotherConsts.MENU_ITEM_4, color: Colors.yellow);

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

  static const _duration = Duration(milliseconds: 300);
  DateTime _backButtonPressTime;
  Future<bool> onWillPop() async {
    DateTime currentTime = DateTime.now();

    bool backButtonHasNotBeenPressed = _backButtonPressTime == null ||
        currentTime.difference(_backButtonPressTime) > _duration;

    if (backButtonHasNotBeenPressed) {
      _backButtonPressTime = currentTime;
      return false;
    }
    return true;
  }

  navigatorToNewGame() {
    Navigator.of(this.state.context).pushReplacementNamed(BaseGamePage.ROUTE);
  }

  navigatorPop() => Navigator.of(this.state.context).pop();

}
