import 'dart:math';

import 'package:flame/flame.dart';
import 'package:flame/position.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ihm_2020_3/src/model/abstracts/customs/custom_sprite_sheet.dart';
import 'package:ihm_2020_3/src/model/animations/alien_hunter_golden_colors.dart';
import 'package:ihm_2020_3/src/model/utils/game_model_constants.dart';
import 'package:ihm_2020_3/src/view/pages/base_game_page.dart';
import 'package:ihm_2020_3/src/view/pages/creditos_page.dart';
import 'package:ihm_2020_3/src/view/pages/ranking_page.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class HomePageController extends ControllerMVC {
  Widget _widget0;

  Widget _widget1;
  Widget _widget2;
  Widget _widget3;
  Widget _widget4;
  Widget _widget5;

  HomePageController() {
    final _title = CustomSpriteSheet(
      imageName: AnotherConsts.TITLE_GAME,
      textureHeight: 32 * 4,
      textureWidth: 1568,
      rows: 5,
      columns: 1,
      jumpPixelY: 64,
    ).createAnimation(0, from: 0, to: 5, loop: true, stepTime: 0.07, scale: 0.5);

    _widget0 = Flame.util.animationAsWidget(Position(300, 60), _title);

    AlienHunterGoldenColorDark().detalhes.then((value) {
      final first = (value['Animations'] as List)?.first;
      setState(() => _widget5 = _generateWidget(first));
    });

    AlienHunterGoldenColorBlue().detalhes.then((value) {
      final first = (value['Animations'] as List)?.first;
      setState(() => _widget1 = _generateWidget(first));
    });

    AlienHunterGoldenColorYellow().detalhes.then((value) {
      final first = (value['Animations'] as List)?.first;
      setState(() => _widget2 = _generateWidget(first));
    });

    AlienHunterGoldenColorRed().detalhes.then((value) {
      final first = (value['Animations'] as List)?.first;
      setState(() => _widget3 = _generateWidget(first));
    });

    AlienHunterGoldenColorGreen().detalhes.then((value) {
      final first = (value['Animations'] as List)?.first;
      setState(() => _widget4 = _generateWidget(first));
    });
  }

  Widget _generateWidget(dynamic element, {double step}) {
    return Flame.util.animationAsWidget(
        Position(element.textureWidth.toDouble() * 1.5,
            element.textureHeight.toDouble() * 1.5),
        element.createAnimation(0, loop: true, stepTime: step ?? 0.04));
  }

  Widget get imgTitle => _widget0;
  Widget get imgAnimated1 => _widget1;
  Widget get imgAnimated2 => _widget2;
  Widget get imgAnimated3 => _widget3;
  Widget get imgAnimated4 => _widget4;
  Widget get imgAnimated5 => _widget5;

  Future actionNewGame() async {
    Navigator.pushNamed(this.state.context, BaseGamePage.ROUTE);
  }

  // Future actionAjustes() async {}

  // Future actionExtras() async {
  //   // Navigator.pushNamed(this.state.context, CadExpressaoPage.ROUTE);
  //   //  Navigator.pushNamed(this.state.context, GameOverPage.ROUTE);
  //   //  Navigator.pushNamed(this.state.context, RankPage.ROUTE);
  //   //  Navigator.pushNamed(this.state.context, RankingPage.ROUTE);
  //    Navigator.pushNamed(this.state.context, ExtrasPage.ROUTE);
  // }

  Future actionRanking() async =>
      await Navigator.pushNamed(this.state.context, RankingPage.ROUTE);

  Future actionCredits() async {
    await Navigator.pushNamed(this.state.context, CreditosPage.ROUTE);
  }

  Future actionSair() async {
    await SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
  }

  Widget get imageNewGame =>
      _buildImg(image: AnotherConsts.MENU_ITEM_1, color: Colors.blueGrey);

  Widget get imageAjustes =>
      _buildImg(image: AnotherConsts.MENU_ITEM_6, color: Colors.yellow);
  // Widget get imageExtras =>
  //     _buildImg(image: AnotherConsts.MENU_ITEM_7, color: Colors.tealAccent);

  Widget get imageRanking =>
      _buildImg(image: AnotherConsts.MENU_ITEM_8, color: Colors.redAccent);

  Widget get imageCredits => _buildImg(
      image: AnotherConsts.MENU_ITEM_3,
      color: Colors.lightGreenAccent,
      maxHeight: 30);
  Widget get imageSair =>
      _buildImg(image: AnotherConsts.MENU_ITEM_4, color: Colors.redAccent);

  Widget get imageBG => Image.asset(
        'assets/images/' + AnotherConsts.BG_OBJETIVE_2,
        colorBlendMode: BlendMode.modulate,
        color: Colors.grey[500],
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );

  Widget _buildImg({String image, double maxHeight = 20, Color color}) {
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
}
