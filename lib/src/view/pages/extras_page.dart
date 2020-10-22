import 'package:flutter/material.dart';
import 'package:ihm_2020_3/src/controller/views/pages/extras_page_controller.dart';
import 'package:ihm_2020_3/src/view/components/menu_buttom_widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class ExtrasPage extends StatefulWidget {
  static const ROUTE = "/extras";

  @override
  _ExtrasPageState createState() => _ExtrasPageState();
}

class _ExtrasPageState extends StateMVC<ExtrasPage> {
  _ExtrasPageState() : super(ExtrasPageController());

  ExtrasPageController get con => super.controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Stack(
        children: <Widget>[
          Transform.scale(
            scale: 1.0,
            child: this.con.imageBG,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20),
                height: 100,
                alignment: Alignment.topCenter,
                child: this.con.imageExtras,
              ),
              Container(
                  padding: EdgeInsets.all(20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    // color: Colors.transparent,
                    child: Container(
                      alignment: Alignment.center,
                      height: 300,
                      color: Colors.transparent,
                      child: Stack(
                        alignment: Alignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          con.imageCover,
                          Container(
                            
                          ),
                          Column(
                            
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              MenuButtomWidget(
                                  widget: this.con.imageExpressoes,
                                  onAction: this.con.onActionExpressao,
                                  splashColor: Colors.purple[800]),
                              MenuButtomWidget(
                                  widget: this.con.imageRanking,
                                  onAction: this.con.onActionRanking,
                                  splashColor: Colors.redAccent[800]),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )),
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
      ),
    );
  }
}
