import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ihm_2020_3/src/model/utils/game_model_constants.dart';
import 'package:ihm_2020_3/src/view/pages/creditos_page.dart';
import 'package:ihm_2020_3/src/view/pages/base_game_page.dart';
import 'package:ihm_2020_3/src/view/pages/game_over_page.dart';
import 'package:ihm_2020_3/src/view/pages/home_page.dart';
import 'package:ihm_2020_3/src/view/pages/rank_page.dart';
import 'package:ihm_2020_3/src/view/pages/ranking_page.dart';
import 'package:ihm_2020_3/src/view/pages/splash_screen.dart';

final rotas = <String, WidgetBuilder>{
  SplashScreenGame.ROUTE: (_) => SplashScreenGame(),
  MyHomePage.ROUTE: (_) => MyHomePage(),
  BaseGamePage.ROUTE: (_) => BaseGamePage(),
  CreditosPage.ROUTE: (_) => CreditosPage(),
  RankPage.ROUTE: (_) => RankPage(),
  RankingPage.ROUTE: (_) => RankingPage(),
  GameOverPage.ROUTE: (_) => GameOverPage(),
};

void main() async {
  runApp(MyApp());

  final assets = <String>[]
    ..addAll(ConstEntityAssets.ALL)
    ..addAll(AnotherConsts.ALL);

  Flame.images.loadAll(assets);

  await SystemChrome.setEnabledSystemUIOverlays([]);
  await Flame.util.setPortraitUpOnly();

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'ALIEN COLORS: A UAST IHM 2020.3 Game',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: SplashScreenGame.ROUTE,
        routes: rotas,
      );
}

/**
 * flutter sdk: 1.16.3
 * flame: ^0.21.0
 * flame_splash_screen: ^0.0.1
 */
