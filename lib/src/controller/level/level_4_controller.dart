import 'package:flame/position.dart';
import 'package:ihm_2020_3/src/controller/game/game_controller.dart';
import 'package:ihm_2020_3/src/model/map/map_levels.dart';

import 'level_controller.dart';

class Level4Controller extends LevelController {
  Level4Controller(GameController controller) : super(controller, MapLevel4());

  @override
  Future init() async {
    await Future.delayed(Duration(seconds: 3)).then((value) async {
      await super.init();
    });
  }

  @override
  Position get playerPosition => Position(32 * 13.0, 32.0 * 3);

  List<Position> get doorsPositions {
    final _height = (0.2 * 32 * 8);
    return [
      Position(32 * 13.0, 32 * 4.0 - _height), //White Door
      Position(32 * 14.0, 32 * 15 - _height), // Blue Door
      Position(32 * 3.0, 32 * 20 - _height), // Green Door
      Position(32 * 24.0, 32 * 24 - _height), // Yellow Door
      Position(32 * 12.0, 32 * 26 - _height), // Red Door
    ];
  }

  final _altPositions = [
    Position(32 * 15.0, 32 * 7.0),
    Position(32 * 8.0, 32 * 12.0),
    Position(32 * 25.0, 32 * 13.0),
    Position(32 * 3.0, 32 * 24.0),
  ];

  List<Position> get alternativasPositions => this._altPositions;
}
