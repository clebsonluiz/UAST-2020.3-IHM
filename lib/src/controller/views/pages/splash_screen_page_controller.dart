import 'package:flame_splash_screen/flame_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:ihm_2020_3/src/model/utils/game_model_constants.dart';
import 'package:ihm_2020_3/src/view/pages/home_page.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class SplashScreenPageController extends ControllerMVC {
  FlameSplashController _controller = FlameSplashController(
      fadeInDuration: Duration(seconds: 1),
      fadeOutDuration: Duration(seconds: 2),
      waitDuration: Duration(seconds: 1),
      autoStart: true);

  FlameSplashController get flameSplashController => this._controller;

  Widget _buildImageSized({String image, double maxHeight = 70}) {
    return LimitedBox(
        maxHeight: maxHeight,
        child: Image.asset(
          'assets/images/' + image.toString(),
          color: null,
        ));
  }

  Widget get imageBSI =>
      _buildImageSized(image: AnotherConsts.LOGO_BSI, maxHeight: 150);

  Widget get imageUAST =>
      _buildImageSized(image: AnotherConsts.LOGO_UAST, maxHeight: 250);

  void onFinish(BuildContext context) async =>
      Navigator.pushReplacementNamed(context, MyHomePage.ROUTE);
}
