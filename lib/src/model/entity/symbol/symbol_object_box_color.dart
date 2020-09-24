import 'package:ihm_2020_3/src/model/entity/symbol/symbol_object.dart';
import 'package:ihm_2020_3/src/model/utils/game_model_constants.dart';

abstract class SymbolObjectBoxColor extends SymbolObject {
  SymbolObjectBoxColor.fromAsset({double x = 0.0, double y = 0.0})
      : super.fromAsset(
          AnotherConsts.BG_SIMBOLO_2,
          scale: 0.16,
          x: x,
          y: y,
          width: (8 * 32).toDouble(),
          height: (8 * 32).toDouble(),
        );
}

class SymbolObjectBoxColorGreen extends SymbolObjectBoxColor {
  SymbolObjectBoxColorGreen() : super.fromAsset();
}

class SymbolObjectBoxColorYellow extends SymbolObjectBoxColor {
  SymbolObjectBoxColorYellow()
      : super.fromAsset(
          x: (9 * 32).toDouble(),
        );
}

class SymbolObjectBoxColorBlue extends SymbolObjectBoxColor {
  SymbolObjectBoxColorBlue()
      : super.fromAsset(
          x: (18 * 32).toDouble(),
        );
}

class SymbolObjectBoxColorRed extends SymbolObjectBoxColor {
  SymbolObjectBoxColorRed()
      : super.fromAsset(
          y: (9 * 32).toDouble(),
        );
}

class SymbolObjectBoxColorWhite extends SymbolObjectBoxColor {
  SymbolObjectBoxColorWhite()
      : super.fromAsset(
          x: (9 * 32).toDouble(),
          y: (9 * 32).toDouble(),
        );
}

class SymbolObjectBoxColorDark extends SymbolObjectBoxColor {
  SymbolObjectBoxColorDark()
      : super.fromAsset(
          x: (18 * 32).toDouble(),
          y: (9 * 32).toDouble(),
        );
}
