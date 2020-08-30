import 'package:flame/flame.dart';
import 'package:flame_splash_screen/flame_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:ihm_2020_3/src/view/pages/creditos_page.dart';
// import 'package:ihm_2020_1/src/view/pages/game_test.dart';

final rotas = <String, WidgetBuilder>{
  '/': (_) => FlameSplashScreen(
      theme: FlameSplashTheme.dark,
      
      onFinish: (BuildContext context) =>
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> CreditosPage()))),
  // '/home': (_) => MyHomePage(),
};

void main() async {
  runApp(MyApp());
  await Flame.util.setPortraitUpOnly();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Aliens Adventure: A UAST IHM 2020.1 Game',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: MyHomePage(),
        initialRoute: '/',
        routes: rotas,
      );
}

/**
 * flutter sdk: 1.16.3
 * flame: ^0.18.3
 * flame_splash_screen: ^0.0.1
 */
