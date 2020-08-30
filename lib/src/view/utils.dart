import 'package:flutter/material.dart';

class SpriteName {
  static const String ALIEN_HUNTER_GOLD_MG =
      'Mobile - Metal Slug Attack - Golden Hunter Walker (Alpha Cannel).png';
}

class PageUtils {
  static Widget itemModelo(Widget child,
          {var isEditable = true,
          var padding = const EdgeInsets.only(),
          var margin = const EdgeInsets.only(bottom: 10.0, top: 5.0),
          var color = Colors.transparent,
          var radius = 5.0,
          var elevation = 2.0}) =>
      Container(
        color: Colors.transparent,
        padding: padding,
        margin: margin,
        child: Material(
          borderRadius: new BorderRadius.circular(radius.toDouble()),
          elevation: elevation,
          color: color,
          child: child,
        ),
      );
}

class Layout {
    static Widget scaffoldDialog(Widget child,
          {Color backgroundColor = Colors.black26,
          EdgeInsets padding = const EdgeInsets.fromLTRB(10, 40, 10, 10.0),
          double radius = 10.0,
          Color corBorda = Colors.black54}) =>
      new Scaffold(
          backgroundColor: backgroundColor,
          body: Center(
              child: Padding(
            padding: padding,
            child: new Material(
              borderRadius: new BorderRadius.circular(radius),
              elevation: 2.0,
              color: corBorda,
              child: child,
            ),
          )));
}

//// Singleton Example
// class Singleton{

//   Singleton._();

//   static Singleton _instance;

//   static Singleton get instance => _instance ??= Singleton._();

//   static void dispose() => _instance = null;

// }
