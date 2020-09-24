import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ihm_2020_3/src/controller/game/game_controller.dart';
import 'package:ihm_2020_3/src/model/utils/game_model_constants.dart';
import 'package:ihm_2020_3/src/view/pages/creditos_page.dart';
import 'package:ihm_2020_3/src/view/pages/game_page.dart';
import 'package:ihm_2020_3/src/view/pages/home_page.dart';
import 'package:ihm_2020_3/src/view/pages/splash_screen.dart';

final rotas = <String, WidgetBuilder>{
  SplashScreenGame.ROUTE: (_) => SplashScreenGame(),
  MyHomePage.ROUTE: (_) => MyHomePage(),
  GamePage.ROUTE: (_) => GamePage(mainGame: GameController()),
  CreditosPage.ROUTE: (_) => CreditosPage(),
  // CadCadeiaPage.ROUTE: (_) => CadCadeiaPage(),
  // CadExpressaoPage.ROUTE: (_) => CadExpressaoPage(),
};

void main() async {
  runApp(MyApp());

  final assets = <String>[]..addAll(ConstEntityAssets.ALL)..addAll(AnotherConsts.ALL);

  Flame.images.loadAll(assets);

  await SystemChrome.setEnabledSystemUIOverlays([]);
  await Flame.util.setPortraitUpOnly();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'A UAST IHM 2020.3 Game',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: SplashScreenGame.ROUTE,
        routes: rotas,
      );
}

/**
 * flutter sdk: 1.16.3
 * flame: ^0.18.3
 * flame_splash_screen: ^0.0.1
 */
