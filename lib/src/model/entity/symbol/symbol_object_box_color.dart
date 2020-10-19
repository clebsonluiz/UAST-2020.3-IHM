import 'dart:ui';

import 'package:flame/text_config.dart';
import 'package:ihm_2020_3/src/model/entity/component/key_object.dart';
import 'package:ihm_2020_3/src/model/entity/component/key_object_colors.dart';
import 'package:ihm_2020_3/src/model/entity/symbol/symbol_object.dart';
import 'package:ihm_2020_3/src/model/utils/game_model_constants.dart';

abstract class SymbolObjectBoxColor extends SymbolObject {
  SymbolObjectBoxColor.fromAsset({double x = 0.0, double y = 0.0})
      : super.fromAsset(
          AnotherConsts.BG_SIMBOLO_2,
          scaleX: 0.16,
          x: x,
          y: y,
          width: (8 * 32).toDouble(),
          height: (8 * 32).toDouble(),
        ){
          this.keyObject;
        }

  KeyObject get keyObject;

  KeyObject get dropKey {
    final _key = this.keyObject;
    final x = (this.posX - this.component.width / 2) - (_key.component.width / 2);
    final y = (this.posY - this.component.height / 2) - (_key.component.height / 2);
    
    _key.setPosition(x: x, y: y);

    return _key;
  }

  @override
  TextConfig get textConfig => TextConfig(
      fontSize: 25.0, fontFamily: 'Roboto', color: const Color(0xFF303030));

}

class SymbolObjectBoxColorGreen extends SymbolObjectBoxColor {
  SymbolObjectBoxColorGreen() : super.fromAsset();

  @override
  KeyObject get keyObject => KeyGreen();
}

class SymbolObjectBoxColorYellow extends SymbolObjectBoxColor {
  SymbolObjectBoxColorYellow()
      : super.fromAsset(
          x: (9 * 32).toDouble(),
        );
  @override
  KeyObject get keyObject => KeyYellow();
}

class SymbolObjectBoxColorBlue extends SymbolObjectBoxColor {
  SymbolObjectBoxColorBlue()
      : super.fromAsset(
          x: (18 * 32).toDouble(),
        );

  @override
  KeyObject get keyObject => KeyBlue();
}

class SymbolObjectBoxColorRed extends SymbolObjectBoxColor {
  SymbolObjectBoxColorRed()
      : super.fromAsset(
          y: (9 * 32).toDouble(),
        );

  @override
  KeyObject get keyObject => KeyRed();
}

class SymbolObjectBoxColorWhite extends SymbolObjectBoxColor {
  SymbolObjectBoxColorWhite()
      : super.fromAsset(
          x: (9 * 32).toDouble(),
          y: (9 * 32).toDouble(),
        );
  @override
  KeyObject get keyObject => KeyDark();
}

class SymbolObjectBoxColorDark extends SymbolObjectBoxColor {
  SymbolObjectBoxColorDark()
      : super.fromAsset(
          x: (18 * 32).toDouble(),
          y: (9 * 32).toDouble(),
        );

  @override
  KeyObject get keyObject => KeyDark();

  @override
  get textConfig => TextConfig(
      fontSize: 25.0,
      fontFamily: 'Awesome Font',
      color: const Color(0xFFFFFFFF));
}
