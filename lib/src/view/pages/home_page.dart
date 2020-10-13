import 'dart:math';

import 'package:flame/flame.dart';
import 'package:flame/position.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ihm_2020_3/src/controller/views/pages/home_page_controller.dart';
import 'package:ihm_2020_3/src/model/animations/alien_hunter_golden_colors.dart';
import 'package:ihm_2020_3/src/model/utils/game_model_constants.dart';

import 'package:ihm_2020_3/src/view/components/menu_buttom_widget.dart';
import 'package:ihm_2020_3/src/view/pages/creditos_page.dart';
import 'package:ihm_2020_3/src/view/pages/base_game_page.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import 'cad_expressao_page.dart';

class MyHomePage extends StatefulWidget {
  static const ROUTE = "/home";

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends StateMVC<MyHomePage> {
  _MyHomePageState() : super(HomePageController());

  HomePageController get con => this.controller;

  final GlobalKey _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _globalKey,
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.grey,
        body: Stack(
          children: <Widget>[
            Transform.scale(
              scale: 1.5,
              child: this.con.imageBG,
            ),
            Positioned(
              child: Transform.rotate(
                angle: pi / 1.5,
                child: this.con.imgAnimated1,
              ),
            ),
            Positioned(
              child: Transform.rotate(
                angle: -pi / 1.5,
                child: this.con.imgAnimated2,
              ),
              right: 0,
            ),
            Positioned(
              child: Transform.rotate(
                angle: -pi / 4,
                child: this.con.imgAnimated3,
              ),
              bottom: 0,
              right: 0,
            ),
            Positioned(
              child: Transform.rotate(
                angle: pi / 3.5,
                child: this.con.imgAnimated4,
              ),
              bottom: 0,
            ),
            Positioned(
              child: Transform.rotate(
                angle: 0,
                child: this.con.imgAnimated5,
              ),
              bottom: 0,
              left: 150,
            ),
            Container(
                // color: Colors.black38,
                padding: EdgeInsets.only(bottom: 40, top: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        MenuButtomWidget(
                            // textContent: 'NOVO JOGO',
                            widget: this.con.imageNewGame,
                            onAction: this.con.actionNewGame,
                            splashColor: Colors.black54),
                        // MenuButtomWidget(
                        //     // textContent: 'CONTINUAR',
                        //     widget: _buildImageSized(
                        //         image: "menu_item_2.png",
                        //         color: Colors.lightBlueAccent),
                        //     onAction: () async {},
                        //     splashColor: Colors.blueGrey[800]),
                        MenuButtomWidget(
                            // textContent: 'AJUSTES',
                            widget: this.con.imageAjustes,
                            onAction: this.con.actionAjustes,
                            splashColor: Colors.yellow[800]),
                        MenuButtomWidget(
                            // textContent: 'EXTRAS',
                            widget: this.con.imageExtras,
                            onAction: this.con.actionExtras,
                            splashColor: Colors.teal[800]),
                        MenuButtomWidget(
                            // textContent: 'CRÉDITOS',
                            widget: this.con.imageCredits,
                            onAction: this.con.actionCredits,
                            splashColor: Colors.green[800]),
                        MenuButtomWidget(
                            // textContent: 'SAIR',
                            widget: this.con.imageSair,
                            onAction: this.con.actionSair,
                            splashColor: Colors.red[800]),
                      ],
                    ),
                  ],
                )),
          ],
        ));
  }
}
