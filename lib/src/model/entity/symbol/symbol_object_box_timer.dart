import 'dart:ui';

import 'package:flame/text_config.dart';
import 'package:ihm_2020_3/src/model/abstracts/customs/custom_text_config.dart';
import 'package:ihm_2020_3/src/model/utils/game_model_constants.dart';

import 'symbol_object.dart';

abstract class SymbolObjectBoxTimer extends SymbolObject {
  SymbolObjectBoxTimer.fromAsset({double x = 0.0, double y = 0.0})
      : super.fromAsset(
          AnotherConsts.BG_TIMER,
          scaleX: 0.15,
          x: x,
          y: y,
          width: (17 * 32).toDouble(),
          height: (8 * 32).toDouble(),
        );
}

class SymbolObjectBoxTimerWhite extends SymbolObjectBoxTimer {
  static SymbolObjectBoxTimer _this = SymbolObjectBoxTimerWhite._();

  factory SymbolObjectBoxTimerWhite() => _this;

  SymbolObjectBoxTimerWhite._()
      : super.fromAsset(
          y: (9 * 32.0).toDouble(),
        );

  @override
  TextConfig get textConfig => CustomTextConfig(
      fontSize: 25.0, color: const Color(0xFF303030), fontStyle: FontStyle.italic);
}

class SymbolObjectBoxTimerDark extends SymbolObjectBoxTimer {
  static SymbolObjectBoxTimer _this = SymbolObjectBoxTimerDark._();

  factory SymbolObjectBoxTimerDark() => _this;

  SymbolObjectBoxTimerDark._() : super.fromAsset();

  @override
  TextConfig get textConfig => CustomTextConfig(
      fontSize: 25.0, color: const Color(0xFFFFFFFF), fontStyle: FontStyle.italic);
}
