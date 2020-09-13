import 'package:ihm_2020_3/src/model/animations/alien_hunter_golden_colors.dart';
import 'package:ihm_2020_3/src/model/animations/creater_animation.dart';
import 'package:ihm_2020_3/src/model/utils/assets_acess.dart';

class AlienHunterGoldenColorRed extends AlienHunterGoldenColor {
  
  static final AlienHunterGoldenColorRed _instance =
      AlienHunterGoldenColorRed.fromCreaterAnimation();

  factory AlienHunterGoldenColorRed() => _instance;

  AlienHunterGoldenColorRed.fromCreaterAnimation()
      : super.fromCreaterAnimation(
            CreaterAnimation(EntityAsset.ALIEN_HUNTER_GOLD_RED_MG));
}
