import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ihm_2020_3/src/controller/views/pages/ranking_page_controller.dart';
import 'package:ihm_2020_3/src/view/components/menu_buttom_widget.dart';

import 'package:mvc_pattern/mvc_pattern.dart';

class RankingPage extends StatefulWidget {
  static const ROUTE = "/ranking";

  RankingPage();

  @override
  RankingPageState createState() => RankingPageState();
}

class RankingPageState extends StateMVC<RankingPage> {
  RankingPageState() : super(RankingPageController());

  RankingPageController get con => this.controller;

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
                child: this.con.imageRanking,
              ),
              Container(
                  padding: EdgeInsets.all(20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    // color: Colors.transparent,
                    child: Container(
                      alignment: Alignment.center,
                      height: 350,
                      color: Colors.transparent,
                      child: Stack(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          con.imageCover,
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 22),
                            child: ListView.builder(
                              itemBuilder: this.con.buildRanking,
                              itemCount: this.con.ranks.length,
                            ),
                          )
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
