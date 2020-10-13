import 'package:flame/position.dart';
import 'package:ihm_2020_3/src/controller/game/game_controller.dart';
import 'package:ihm_2020_3/src/model/map/map_levels.dart';

import 'level_controller.dart';

class Level2Controller extends LevelController {
  Level2Controller(GameController controller) : super(controller, MapLevel2());

  @override
  Future init() async {
    await Future.delayed(Duration(seconds: 1)).then((value) async {
      await super.init();
    });
  }

  @override
  Position get playerPosition => Position(32 * 8.0, 32.0 * 3);

  List<Position> get doorsPositions {
    final _height = (0.2 * 32 * 8);
    return [
      Position(32 * 7.0, 32 * 4.0 - _height), //White Door
      Position(32 * 25.0, 32 * 23 - _height), // Blue Door
      Position(32 * 6.0, 32 * 17 - _height), // Green Door
      Position(32 * 1.0, 32 * 27 - _height), // Yellow Door
      Position(32 * 26.0, 32 * 11 - _height), // Red Door
    ];
  }

  final _altPositions = [
    Position(32 * 27.0, 32 * 3.0),
    Position(32 * 17.0, 32 * 11.0),
    Position(32 * 20.0, 32 * 26.0),
    Position(32 * 21.0, 32 * 21.0),
  ];

  List<Position> get alternativasPositions => this._altPositions;
}
