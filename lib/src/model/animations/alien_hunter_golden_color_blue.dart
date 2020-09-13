import 'package:ihm_2020_3/src/model/animations/alien_hunter_golden_colors.dart';
import 'package:ihm_2020_3/src/model/animations/creater_animation.dart';
import 'package:ihm_2020_3/src/model/utils/assets_acess.dart';

class AlienHunterGoldenColorBlue extends AlienHunterGoldenColor {
  
  static final AlienHunterGoldenColorBlue _instance =
      AlienHunterGoldenColorBlue.fromCreaterAnimation();

  factory AlienHunterGoldenColorBlue() => _instance;

  AlienHunterGoldenColorBlue.fromCreaterAnimation()
      : super.fromCreaterAnimation(
            CreaterAnimation(EntityAsset.ALIEN_HUNTER_GOLD_BLUE_MG));
}
