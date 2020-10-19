import 'dart:ui';
// import 'package:flame/anchor.dart';
// import 'package:flame/components/text_component.dart';
// import 'package:flame/position.dart';
import 'package:flame/text_config.dart';
import 'package:flutter/material.dart' as material;

class CustomTextConfig extends TextConfig {
  const CustomTextConfig({
    fontSize = 24.0,
    color = const Color(0xFF000000),
    fontFamily = 'Arial',
    textAlign = TextAlign.left,
    textDirection = TextDirection.ltr,
  }) : super(
          fontSize: fontSize,
          color: color,
          fontFamily: fontFamily,
          textAlign: textAlign,
          textDirection: textDirection,
        );

  @override
  material.TextPainter toTextPainter(String text) {
    final material.TextStyle style = material.TextStyle(
        color: color,
        fontSize: fontSize,
        fontFamily: fontFamily,
        fontStyle: material.FontStyle.italic,
        fontWeight: material.FontWeight.bold);
    final material.TextSpan span = material.TextSpan(
      style: style,
      text: text,
    );
    final material.TextPainter tp = material.TextPainter(
      text: span,
      textAlign: textAlign,
      textDirection: textDirection,
    );
    tp.layout();
    return tp;
  }
}
