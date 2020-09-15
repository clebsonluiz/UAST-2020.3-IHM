import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ihm_2020_3/src/controller/game/game_controller.dart';
import 'package:ihm_2020_3/src/model/utils/assets_acess.dart';
import 'package:ihm_2020_3/src/view/pages/creditos_page.dart';
import 'package:ihm_2020_3/src/view/pages/game_page.dart';
import 'package:ihm_2020_3/src/view/pages/home_page.dart';
import 'package:ihm_2020_3/src/view/pages/splash_screen.dart';
// import 'package:ihm_2020_3/src/view/pages/home_page.dart';

final rotas = <String, WidgetBuilder>{
  SplashScreenGame.ROUTE: (_) => SplashScreenGame(),
  MyHomePage.ROUTE: (_) => MyHomePage(),
  GamePage.ROUTE: (_) => GamePage(mainGame: GameController()),
  CreditosPage.ROUTE: (_) => CreditosPage(),
};

void main() async {

  runApp(MyApp());

  Flame.images.loadAll(
    EntityAsset.asList()..addAll(Another.asList())
  );

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
        // home: MyHomePage(),
        initialRoute: SplashScreenGame.ROUTE,
        routes: rotas,
      );
}

/**
 * flutter sdk: 1.16.3
 * flame: ^0.18.3
 * flame_splash_screen: ^0.0.1
 */
