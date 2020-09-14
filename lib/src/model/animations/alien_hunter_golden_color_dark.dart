import 'package:ihm_2020_3/src/model/animations/alien_hunter_golden_colors.dart';
import 'package:ihm_2020_3/src/model/animations/creater_animation.dart';
import 'package:ihm_2020_3/src/model/utils/assets_acess.dart';

class AlienHunterGoldenColorDark extends AlienHunterGoldenColor {
  
  static final AlienHunterGoldenColorDark _instance =
      AlienHunterGoldenColorDark.fromCreaterAnimation();

  factory AlienHunterGoldenColorDark() => _instance;

  AlienHunterGoldenColorDark.fromCreaterAnimation()
      : super.fromCreaterAnimation(
            CreaterAnimation(EntityAsset.ALIEN_HUNTER_GOLD_DARK_MG));
}
