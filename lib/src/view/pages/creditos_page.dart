
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ihm_2020_3/src/controller/views/pages/creditos_page_controller.dart';

import 'package:ihm_2020_3/src/view/components/credito_widget.dart';
import 'package:ihm_2020_3/src/view/components/menu_buttom_widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class CreditosPage extends StatefulWidget {
  static const ROUTE = "/credits";

  CreditosPage();

  @override
  CreditosPageState createState() => CreditosPageState();
}

class CreditosPageState extends StateMVC<CreditosPage> {
  CreditosPageState() : super(CreditosPageController());

  CreditosPageController get con => this.controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            Transform.scale(
              scale: 1.5,
              child: this.con.imageBG,
            ),
            ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 80,
                        width: 300,
                        child: this.con.imageCredits,
                      ),
                      _buildTextSized(
                          text: 'Sobre a Aplicação',
                          maxLines: 2,
                          textAlin: TextAlign.center,
                          color: Color(0xFFFFFFFF),
                          fontSize: 20,
                          hSizedBox: 7),
                      SizedBox(
                        height: 15,
                      ),
                      _buildTextSized(
                        text: con.desc,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 160,
                            width: 160,
                            child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  // side:
                                  //     BorderSide(color: Colors.black87, width: 5),
                                ),
                                // margin: EdgeInsets.symmetric(
                                //     vertical: 5, horizontal: 10),
                                elevation: 0,
                                color: Colors.white,
                                child: con.image1),
                          ),
                          SizedBox(
                            height: 160,
                            width: 160,
                            child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  // side:
                                  //     BorderSide(color: Colors.black87, width: 5),
                                ),
                                // margin: EdgeInsets.symmetric(
                                //     vertical: 5, horizontal: 10),
                                elevation: 0,
                                color: Colors.white,
                                child: con.image2),
                          )
                        ],
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  ),
                ),
                
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side: BorderSide(color: Colors.black87, width: 5),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  elevation: 0,
                  color: Colors.white,
                  child: ExpansionTile(
                    onExpansionChanged: con.onExpansionChanged,
                    // backgroundColor: Colors.grey,
                    initiallyExpanded: false,
                    title: Text(
                      'Sprites e Animações',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Créditos das imagens tiradas da internet',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                    children: List.generate(
                        con.list.length,
                        (i) => Padding(
                              padding: EdgeInsets.all(10),
                              child: CreditoWidget(element: con.list[i]),
                            )),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    MenuButtomWidget(
                        widget: this.con.imageVoltar,
                        onAction: this.con.navigatorPop,
                        splashColor: Colors.yellow[800]),
                  ],
                ),
              ],
            ),
          ],
        ));
  }

  Widget _buildTextSized(
      {String text = '',
      double hSizedBox = 5,
      maxLines = 40,
      textAlin = TextAlign.justify,
      color = Colors.white,
      double fontSize = 14.0,
      fontWeight = FontWeight.bold}) {
    return Column(children: <Widget>[
      Text(
        text,
        maxLines: maxLines,
        textAlign: textAlin,
        style: new TextStyle(
            color: color,
            fontSize: fontSize,
            fontWeight: fontWeight,
            fontFamily: "Arial"),
      ),
      SizedBox(
        height: hSizedBox,
      ),
    ]);
  }
}
