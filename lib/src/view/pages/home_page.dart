import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ihm_2020_3/src/model/utils/game_model_constants.dart';

import 'package:ihm_2020_3/src/view/components/menu_buttom_widget.dart';
import 'package:ihm_2020_3/src/view/pages/creditos_page.dart';
import 'package:ihm_2020_3/src/view/pages/game_page.dart';

import 'cad_expressao/cad_expressao_page.dart';

class MyHomePage extends StatefulWidget {
  static const ROUTE = "/home";

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _globalKey,
        extendBodyBehindAppBar: true,
        body: Stack(
          children: <Widget>[
            Image.asset(
              'assets/images/' + AnotherConsts.BG_OBJETIVE_2,
              colorBlendMode: BlendMode.modulate,
              color: Colors.grey,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            
            // Positioned(
            //   child: Container(
            //     child: Flame.util.animationAsWidget(size, animation),
            //     color: Colors.pink,
            //     width: 50,
            //     height: 50,

            //   ),
            //   bottom: 0,
            //   right: 0,
            // ),
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
                            widget: _buildImageSized(
                                image: "menu_item_1.png",
                                color: Colors.blueGrey),
                            onAction: () async {
                              Navigator.pushNamed(context, GamePage.ROUTE);
                            },
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
                            widget: _buildImageSized(
                                image: AnotherConsts.MENU_ITEM_6,
                                color: Colors.yellow),
                            onAction: () async {},
                            splashColor: Colors.yellow[800]),
                        MenuButtomWidget(
                            // textContent: 'EXTRAS',
                            widget: _buildImageSized(
                                image: AnotherConsts.MENU_ITEM_7,
                                color: Colors.tealAccent),
                            onAction: () async {
                              Navigator.pushNamed(context, CadExpressaoPage.ROUTE);
                            },
                            splashColor: Colors.teal[800]),
                        MenuButtomWidget(
                            // textContent: 'CRÉDITOS',
                            widget: _buildImageSized(
                                image: "menu_item_3.png",
                                maxHeight: 30,
                                color: Colors.lightGreenAccent),
                            onAction: () async {
                              await Navigator.pushNamed(
                                  context, CreditosPage.ROUTE);
                            },
                            splashColor: Colors.green[800]),
                        MenuButtomWidget(
                            // textContent: 'SAIR',
                            widget: _buildImageSized(
                                image: "menu_item_4.png",
                                color: Colors.redAccent),
                            onAction: () async => await SystemChannels.platform
                                .invokeMethod<void>('SystemNavigator.pop'),
                            splashColor: Colors.red[800]),
                      ],
                    ),
                  ],
                )),
          ],
        ));
  }

  Widget _buildImageSized({String image, double maxHeight = 20, Color color}) {
    return LimitedBox(
        key: Key(_globalKey.toString() + image),
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
