import 'dart:math';

import 'package:flame/flame.dart';
import 'package:flame/position.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ihm_2020_3/src/model/animations/alien_hunter_golden_colors.dart';
import 'package:ihm_2020_3/src/model/utils/game_model_constants.dart';

import 'package:ihm_2020_3/src/view/components/menu_buttom_widget.dart';
import 'package:ihm_2020_3/src/view/pages/creditos_page.dart';
import 'package:ihm_2020_3/src/view/pages/game_page.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import 'cad_expressao/cad_expressao_page.dart';

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

class HomePageController extends ControllerMVC {
  Widget _widget1;
  Widget _widget2;
  Widget _widget3;
  Widget _widget4;
  Widget _widget5;

  HomePageController() {
    AlienHunterGoldenColorDark().detalhes.then((value) {
      final first = (value['Animations'] as List)?.first;
      setState(() => _widget5 = _generateWidget(first));
    });

    AlienHunterGoldenColorBlue().detalhes.then((value) {
      final first = (value['Animations'] as List)?.first;
      setState(() => _widget1 = _generateWidget(first));
    });

    AlienHunterGoldenColorYellow().detalhes.then((value) {
      final first = (value['Animations'] as List)?.first;
      setState(() => _widget2 = _generateWidget(first));
    });

    AlienHunterGoldenColorRed().detalhes.then((value) {
      final first = (value['Animations'] as List)?.first;
      setState(() => _widget3 = _generateWidget(first));
    });

    AlienHunterGoldenColorGreen().detalhes.then((value) {
      final first = (value['Animations'] as List)?.first;
      setState(() => _widget4 = _generateWidget(first));
    });
  }

  Widget _generateWidget(dynamic element, {double step}) {
    return Flame.util.animationAsWidget(
        Position(element.textureWidth.toDouble() * 1.5,
            element.textureHeight.toDouble() * 1.5),
        element.createAnimation(0, loop: true, stepTime: step ?? 0.04));
  }

  Widget get imgAnimated1 => _widget1;
  Widget get imgAnimated2 => _widget2;
  Widget get imgAnimated3 => _widget3;
  Widget get imgAnimated4 => _widget4;
  Widget get imgAnimated5 => _widget5;

  Future actionNewGame() async {
    Navigator.pushNamed(this.state.context, GamePage.ROUTE);
  }

  Future actionAjustes() async {}

  Future actionExtras() async {
    Navigator.pushNamed(this.state.context, CadExpressaoPage.ROUTE);
  }

  Future actionCredits() async {
    await Navigator.pushNamed(this.state.context, CreditosPage.ROUTE);
  }

  Future actionSair() async {
    await SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
  }

  Widget get imageNewGame =>
      _buildImg(image: AnotherConsts.MENU_ITEM_1, color: Colors.blueGrey);

  Widget get imageAjustes =>
      _buildImg(image: AnotherConsts.MENU_ITEM_6, color: Colors.yellow);
  Widget get imageExtras =>
      _buildImg(image: AnotherConsts.MENU_ITEM_7, color: Colors.tealAccent);
  Widget get imageCredits => _buildImg(
      image: AnotherConsts.MENU_ITEM_3,
      color: Colors.lightGreenAccent,
      maxHeight: 30);
  Widget get imageSair =>
      _buildImg(image: AnotherConsts.MENU_ITEM_4, color: Colors.redAccent);

  Widget get imageBG => Image.asset(
        'assets/images/' + AnotherConsts.BG_OBJETIVE_2,
        colorBlendMode: BlendMode.modulate,
        color: Colors.grey[500],
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );

  Widget _buildImg({String image, double maxHeight = 20, Color color}) {
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
}
