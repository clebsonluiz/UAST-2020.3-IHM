import 'package:flame/position.dart';
import 'package:ihm_2020_3/src/controller/game/game_controller.dart';
import 'package:ihm_2020_3/src/model/map/map_levels.dart';

import 'level_controller.dart';

class Level3Controller extends LevelController {
  Level3Controller(GameController controller) : super(controller, MapLevel3());

  @override
  Future init() async {
    await Future.delayed(Duration(seconds: 3)).then((value) async {
      await super.init();
    });
  }

  @override
  Position get playerPosition => Position(32.0 * 14, 32.0 * 27);

  List<Position> get doorsPositions {
    final _height = (0.2 * 32 * 8);
    return [
      Position(32 * 14.0, 32 * 28.0 - _height), //White Door
      Position(32 * 6.0, 32 * 20 - _height), // Blue Door
      Position(32 * 25.0, 32 * 22 - _height), // Green Door
      Position(32 * 21.0, 32 * 8 - _height), // Yellow Door
      Position(32 * 9.0, 32 * 10 - _height), // Red Door
    ];
  }

  final _altPositions = [
    Position(32 * 13.0, 32 * 17.0),
    Position(32 * 20.0, 32 * 13.0),
    Position(32 * 16.0, 32 * 8.0),
    Position(32 * 8.0, 32 * 23.0),
  ];

  List<Position> get alternativasPositions => this._altPositions;
}
