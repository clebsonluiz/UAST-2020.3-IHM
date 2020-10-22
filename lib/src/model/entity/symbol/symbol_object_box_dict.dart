import 'dart:ui';

import 'package:flame/text_config.dart';
import 'package:ihm_2020_3/src/model/abstracts/customs/custom_text_config.dart';
import 'package:ihm_2020_3/src/model/utils/game_model_constants.dart';

import 'symbol_object.dart';

abstract class SymbolObjectBoxExpressionDict extends SymbolObject {


  SymbolObjectBoxExpressionDict.fromMaior()
      : super.fromAsset(
          AnotherConsts.BG_TIMER_EXPRESSAO,
          scaleX: 0.20,
          scaleY: 0.15,
        );

  SymbolObjectBoxExpressionDict.fromNormal()
      : super.fromAsset(
          AnotherConsts.BG_TIMER_EXPRESSAO,
          scaleX: 0.15,
        );

  SymbolObjectBoxExpressionDict.fromMenor()
      : super.fromAsset(
          AnotherConsts.BG_TIMER,
          scaleX: 0.15,
          // x: x,
          y: (9 * 32.0).toDouble(),
          width: (17 * 32).toDouble(),
          height: (8 * 32).toDouble(),
        );

  @override
  TextConfig get textConfig => CustomTextConfig(
      fontSize: 25.0, fontFamily: 'Roboto', color: const Color(0xFF303030));
}


