
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:ihm_2020_3/src/view/components/menu_buttom_widget.dart';
import 'package:ihm_2020_3/src/view/pages/creditos_page.dart';


class MyHomePage extends StatefulWidget {
  
  @override
  _MyHomePageState createState() => _MyHomePageState();
  
}

class _MyHomePageState extends State<MyHomePage> {

  final GlobalKey _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
            key: _globalKey,
            extendBodyBehindAppBar: true,
            body: Stack(
              children: <Widget>[
                Center(), //Colocar Uma imagem aqui
                Container(
                    color: Colors.black54,
                    padding: EdgeInsets.only(bottom: 40, top: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            
                            MenuButtomWidget(
                                // textContent: 'NOVO JOGO',
                                widget: _buildImageSized(image: "menu_item_1.png", color: Colors.blueGrey),
                                onAction: () async {},
                                splashColor: Colors.black54),
                            MenuButtomWidget(
                                // textContent: 'CONTINUAR',
                                widget: _buildImageSized(image: "menu_item_2.png", color: Colors.lightBlueAccent),
                                onAction: () async {},
                                splashColor: Colors.blueGrey[800]),
                            MenuButtomWidget(
                                // textContent: 'CRÉDITOS',
                                widget: _buildImageSized(image: "menu_item_3.png", maxHeight: 35, color: Colors.lightGreenAccent),
                                onAction: () async {
                                  await Navigator.pushNamed(context, "/credits");
                                },
                                splashColor: Colors.green[800]),
                            MenuButtomWidget(
                                // textContent: 'SAIR',
                                widget: _buildImageSized(image: "menu_item_4.png", color: Colors.redAccent),
                                onAction: () async => await SystemChannels
                                    .platform
                                    .invokeMethod<void>('SystemNavigator.pop'),
                                splashColor: Colors.red[800]),
                          ],
                        ),
                      ],
                    )),
              ],
            ));
  }

  Widget _buildImageSized({String image, double maxHeight = 25, Color color}) {
    return LimitedBox(
      key: Key(_globalKey.toString() + image),
        maxHeight: maxHeight,
        child: Image.asset(
          'assets/images/' + image.toString(),
          color: color,
          colorBlendMode: BlendMode.modulate,
        ));
  }
  
}

