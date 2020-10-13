import 'dart:math';

import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:ihm_2020_3/src/model/utils/game_model_constants.dart';
import 'package:ihm_2020_3/src/view/components/menu_buttom_widget.dart';
import 'package:ihm_2020_3/src/view/pages/cad_expressao_page.dart';
import 'package:ihm_2020_3/src/view/pages/ranking_page.dart';
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
                      widget: this.con.imageSair,
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

class ExtrasPageController extends ControllerMVC {
  ExtrasPageController() {
    Sprite.loadSprite(
      AnotherConsts.BG_TIMER,
      x: 0,
      y: (9 * 32.0).toDouble(),
      width: (17 * 32).toDouble(),
      height: (8 * 32).toDouble(),
    ).then((value) {
      setState(() {
        _widget1 = Flame.util.spriteAsWidget(value.size.toSize(), value);
      });
    });
  }

  Widget _widget1;
  Widget get img => _widget1;

  Widget get imageRanking =>
      _buildImg(image: AnotherConsts.MENU_ITEM_8, color: Colors.redAccent);

  Widget get imageSair =>
      _buildImg(image: AnotherConsts.MENU_ITEM_4, color: Colors.yellow);

  Widget get imageExtras =>
      _buildImg(image: AnotherConsts.MENU_ITEM_7, color: Colors.tealAccent);
  
  Widget get imageExpressoes =>
      _buildImg(image: AnotherConsts.MENU_ITEM_11, color: Colors.deepPurpleAccent, maxHeight: 30 );

  Widget get imageCover =>
      Image.asset('assets/images/' + AnotherConsts.BG_OBJETIVE_2,
          color: Colors.grey[500],
          fit: BoxFit.fill,
          colorBlendMode: BlendMode.modulate,
          width: double.infinity,
          height: double.infinity);

  Widget get imageBG => Image.asset(
        'assets/images/' + AnotherConsts.BG_OBJETIVE_2,
        colorBlendMode: BlendMode.modulate,
        color: Colors.grey[500],
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );

  Widget _buildImg({String image, double maxHeight = 25, Color color}) {
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

  onActionRanking() async => await Navigator.pushNamed(this.state.context, RankingPage.ROUTE);

  onActionExpressao() async => await Navigator.pushNamed(this.state.context, CadExpressaoPage.ROUTE);

  navigatorPop() => Navigator.of(this.state.context).pop();

}
