import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ihm_2020_3/src/controller/views/pages/rank_page_controller.dart';
import 'package:ihm_2020_3/src/view/components/menu_buttom_widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class RankPage extends StatefulWidget {
  static const ROUTE = "/rank";

  RankPage();

  @override
  RankPageState createState() => RankPageState();
}

class RankPageState extends StateMVC<RankPage> {
  RankPageState() : super(RankPageController());

  RankPageController get con => this.controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: WillPopScope(
          onWillPop: this.con.onWillPop,
          child: Stack(
            children: <Widget>[
              Transform.scale(
                scale: 1.0,
                child: this.con.imageBG,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20),
                    height: 100,
                    alignment: Alignment.topCenter,
                    child: this.con.imageRank,
                  ),
                  Container(
                      padding: EdgeInsets.all(20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        child: Container(
                          alignment: Alignment.center,
                          height: 150,
                          color: Colors.transparent,
                          child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              con.img ?? Center(),
                              Center(
                                child: Container(
                                  alignment: Alignment.center,
                                  color: Colors.transparent,
                                  margin: EdgeInsets.all(20),
                                  child: this.con.ranking,
                                ),
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
                          widget: this.con.imageNewGame,
                          onAction: this.con.navigatorToNewGame,
                          splashColor: Colors.grey[800]),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      MenuButtomWidget(
                          widget: this.con.imageSair,
                          onAction: this.con.navigatorPop,
                          splashColor: Colors.yellow[800]),
                    ],
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
