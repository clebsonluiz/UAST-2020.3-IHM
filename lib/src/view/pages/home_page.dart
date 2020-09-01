
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
                                widget: _buildImageSized(image: "menu_item_1.png"),
                                onAction: () async {},
                                splashColor: Colors.blue),
                            MenuButtomWidget(
                                // textContent: 'CONTINUAR',
                                widget: _buildImageSized(image: "menu_item_2.png"),
                                onAction: () async {},
                                splashColor: Colors.blueGrey),
                            MenuButtomWidget(
                                // textContent: 'CRÉDITOS',
                                widget: _buildImageSized(image: "menu_item_3.png", maxHeight: 35),
                                onAction: () async {
                                  await Navigator.pushNamed(context, "/credits");
                                },
                                splashColor: Colors.indigo),
                            MenuButtomWidget(
                                // textContent: 'SAIR',
                                widget: _buildImageSized(image: "menu_item_4.png"),
                                onAction: () async => await SystemChannels
                                    .platform
                                    .invokeMethod<void>('SystemNavigator.pop'),
                                splashColor: Colors.red),
                          ],
                        ),
                      ],
                    )),
              ],
            ));
  }

  Widget _buildImageSized({String image, double maxHeight = 25}) {
    return LimitedBox(
        maxHeight: maxHeight,
        child: Image.asset(
          'assets/images/' + image.toString(),
          color: null,
        ));
  }
  
}

