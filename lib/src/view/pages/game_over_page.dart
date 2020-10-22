import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ihm_2020_3/src/controller/views/pages/game_over_page_controller.dart';
import 'package:ihm_2020_3/src/view/components/menu_buttom_widget.dart';

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

