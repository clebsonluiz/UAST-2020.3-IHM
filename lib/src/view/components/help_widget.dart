import 'dart:math';

import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:ihm_2020_3/src/model/utils/game_model_constants.dart';
import 'package:ihm_2020_3/src/view/components/menu_buttom_widget.dart';
import 'package:ihm_2020_3/src/view/pages/cad_expressao_page.dart';
import 'package:ihm_2020_3/src/view/pages/ranking_page.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class HelpWidget extends StatefulWidget {
  @override
  _HelpWidgetState createState() => _HelpWidgetState();
}

class _HelpWidgetState extends StateMVC<HelpWidget> {
  _HelpWidgetState() : super(HelpWidgetController());

  HelpWidgetController get con => super.controller;

  @override
  Widget build(BuildContext context) {
    return Card(
        // color: Colors.black87,
        child: Container(
      // padding: EdgeInsets.all(20),
      // margin: EdgeInsets.all(20),

      height: 400,
      width: MediaQuery.of(context).size.width * 0.95,
      color: Colors.black87,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            "AJUDA",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white60,
            ),
          ),
          Container(
            // margin: EdgeInsets.all(20),
            // alignment: Alignment.center,
            color: Colors.transparent,
            child: SizedBox(
              height: 250,
              width: 260,
              child: Center(
                child: this.con.current,
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _floatingBHelp(text: "~", onPressed: this.con.changeToNOT),
              _floatingBHelp(text: "∧", onPressed: this.con.changeToAND),
              _floatingBHelp(text: "v", onPressed: this.con.changeToOR),
              _floatingBHelp(text: "→", onPressed: this.con.changeToCON),
              _floatingBHelp(text: "↔", onPressed: this.con.changeToBICON),
            ],
          ),
          MenuButtomWidget(
              // textContent: 'AJUSTES',
              widget: this.con.imageVoltar,
              onAction: this.con.navigatorPop,
              splashColor: Colors.redAccent[800]),
        ],
      ),
    ));
  }

  Widget _floatingBHelp(
      {Color cor, Function onPressed, Color splashColor, String text}) {
    return FloatingActionButton(
      heroTag: "$cor + $text + $splashColor",
      splashColor: splashColor,
      elevation: 1,
      child: Text(
        text,
        style: TextStyle(
            color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 20),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(color: Colors.grey, width: 2),
      ),
      backgroundColor: cor ?? Colors.white70,
      mini: true,
      onPressed: onPressed,
    );
  }
}

class HelpWidgetController extends ControllerMVC {
  HelpWidgetController() {}

  Widget _current;

  Widget get current => this._current ??= this.imgNOT;

  Widget get imgNOT => _buildImg(
        image: AnotherConsts.AJUDA_NEGACAO,
      );

  Widget get imgAND => _buildImg(
        image: AnotherConsts.AJUDA_CONJUNCAO,
      );

  Widget get imgOR => _buildImg(
        image: AnotherConsts.AJUDA_DISJUNCAO,
      );

  Widget get imgCON => _buildImg(
        image: AnotherConsts.AJUDA_CONDICIONAL,
      );

  Widget get imgBICON => _buildImg(
        image: AnotherConsts.AJUDA_BICONDICIONAL,
      );

  Widget get imageVoltar =>
      _buildImg(image: AnotherConsts.MENU_ITEM_12, color: Colors.yellow);

  void changeToNOT() {
    setState(() {
      this._current = this.imgNOT;
    });
  }

  void changeToAND() {
    setState(() {
      this._current = this.imgAND;
    });
  }

  void changeToOR() {
    setState(() {
      this._current = this.imgOR;
    });
  }

  void changeToCON() {
    setState(() {
      this._current = this.imgCON;
    });
  }

  void changeToBICON() {
    setState(() {
      this._current = this.imgBICON;
    });
  }

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

  onActionRanking() async =>
      await Navigator.pushNamed(this.state.context, RankingPage.ROUTE);

  onActionExpressao() async =>
      await Navigator.pushNamed(this.state.context, CadExpressaoPage.ROUTE);

  navigatorPop() => Navigator.of(this.state.context).pop();
}
