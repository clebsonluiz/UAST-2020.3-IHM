import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ihm_2020_3/src/model/utils/game_model_constants.dart';
import 'package:ihm_2020_3/src/view/pages/ranking_page.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class HelpWidgetController extends ControllerMVC {
  HelpWidgetController();

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

  navigatorPop() => Navigator.of(this.state.context).pop();
}