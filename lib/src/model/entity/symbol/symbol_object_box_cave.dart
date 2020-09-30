import 'dart:ui';

import 'package:flame/text_config.dart';
import 'package:ihm_2020_3/src/model/entity/component/key_object.dart';
import 'package:ihm_2020_3/src/model/entity/component/key_object_colors.dart';
import 'package:ihm_2020_3/src/model/entity/symbol/symbol_object.dart';
import 'package:ihm_2020_3/src/model/utils/game_model_constants.dart';

class SymbolObjectBoxCave extends SymbolObject {
  
  SymbolObjectBoxCave() : super.fromAsset(AnotherConsts.BG_SIMBOLO_1, scale: 0.4);

  @override
  KeyObject get keyObject => KeyDark();

  @override
  get textConfig => TextConfig(
      fontSize: 25.0,
      fontFamily: 'Awesome Font',
      color: const Color(0xFFFFFFFF));
}
