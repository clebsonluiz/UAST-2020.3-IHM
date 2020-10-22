import 'package:flame_splash_screen/flame_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:ihm_2020_3/src/controller/views/pages/splash_screen_page_controller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class SplashScreenGame extends StatefulWidget {
  static const ROUTE = "/";

  @override
  State createState() => _SplashScreenGameState();
}

class _SplashScreenGameState extends StateMVC<SplashScreenGame> {
  _SplashScreenGameState() : super(SplashScreenPageController());

  SplashScreenPageController get con => this.controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    this.con.flameSplashController.dispose(); // dispose it when necessary
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FlameSplashScreen(
      showBefore: (context) => Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[this.con.imageUAST, this.con.imageBSI],
            ),
          )),
      theme: FlameSplashTheme.dark,
      onFinish: this.con.onFinish,
      controller: this.con.flameSplashController,
    );
  }
}
