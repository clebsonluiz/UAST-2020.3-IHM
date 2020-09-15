import 'package:flame_splash_screen/flame_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:ihm_2020_3/src/view/pages/game_page.dart';


class SplashScreenGame extends StatefulWidget {
  static const ROUTE = "/";

  @override
  State createState() => _SplashScreenGameState();
}

class _SplashScreenGameState extends State<SplashScreenGame> {
  FlameSplashController _controller;

  @override
  void initState() {
    super.initState();
    _controller = FlameSplashController(
        fadeInDuration: Duration(seconds: 1),
        fadeOutDuration: Duration(seconds: 2),
        waitDuration: Duration(seconds: 1),
        autoStart: true);
  }

  @override
  void dispose() {
    _controller.dispose(); // dispose it when necessary
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final imagebsi = 'logo_bsi.png';
    final imageuast = 'logo_uast.png';
    final logobsi = _buildImageSized(image: imagebsi, maxHeight: 150);
    final logouast = _buildImageSized(image: imageuast, maxHeight: 250);

    return FlameSplashScreen(
      // showBefore: (context) => logobsi,
      showBefore: (context) => Container(
        color: Colors.white,
        child: Padding(
        
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            logouast, logobsi
          ],
        ),
      )
      ),
      theme: FlameSplashTheme.dark,
      onFinish: (context) async =>
          Navigator.pushReplacementNamed(context, GamePage.ROUTE),
      controller: _controller,
    );
  }
}

Widget _buildImageSized({String image, double maxHeight = 70}) {
  return LimitedBox(
      maxHeight: maxHeight,
      child: Image.asset(
        'assets/images/' + image.toString(),
        color: null,
      ));
}
