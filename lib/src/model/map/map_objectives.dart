import 'package:ihm_2020_3/src/model/abstracts/objective_map.dart';
import 'package:ihm_2020_3/src/model/utils/game_model_constants.dart';

class MapObjective1 extends ObjectiveMap {
  MapObjective1() : super(AnotherConsts.BG_OBJETIVE_1);
}

class MapObjective2 extends ObjectiveMap {
  MapObjective2() : super(AnotherConsts.BG_OBJETIVE_2);
}

class MapObjectiveSimple extends ObjectiveMap {
  MapObjectiveSimple()
      : super(
          AnotherConsts.BG_TIMER,
          y: (9 * 32.0).toDouble(),
          width: (17 * 32).toDouble(),
          height: (8 * 32).toDouble(),
        );
}
