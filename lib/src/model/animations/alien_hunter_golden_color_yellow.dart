import 'package:ihm_2020_3/src/model/animations/alien_hunter_golden_colors.dart';
import 'package:ihm_2020_3/src/model/animations/creater_animation.dart';
import 'package:ihm_2020_3/src/model/utils/assets_acess.dart';

class AlienHunterGoldenColorYellow extends AlienHunterGoldenColor {
  
  static final AlienHunterGoldenColorYellow _instance =
      AlienHunterGoldenColorYellow.fromCreaterAnimation();

  factory AlienHunterGoldenColorYellow() => _instance;

  AlienHunterGoldenColorYellow.fromCreaterAnimation()
      : super.fromCreaterAnimation(
            CreaterAnimation(EntityAsset.ALIEN_HUNTER_GOLD_YELLOW_MG));
}
