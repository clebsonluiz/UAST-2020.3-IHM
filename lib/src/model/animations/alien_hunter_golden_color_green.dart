import 'package:ihm_2020_3/src/model/animations/alien_hunter_golden_colors.dart';
import 'package:ihm_2020_3/src/model/animations/creater_animation.dart';
import 'package:ihm_2020_3/src/model/utils/assets_acess.dart';

class AlienHunterGoldenColorGreen extends AlienHunterGoldenColor {
  
  static final AlienHunterGoldenColorGreen _instance =
      AlienHunterGoldenColorGreen.fromCreaterAnimation();

  factory AlienHunterGoldenColorGreen() => _instance;

  AlienHunterGoldenColorGreen.fromCreaterAnimation()
      : super.fromCreaterAnimation(
            CreaterAnimation(EntityAsset.ALIEN_HUNTER_GOLD_GREEN_MG));
}
