import 'package:ihm_2020_1/src/model/abstracts/customs/custom_tiled_component.dart';

class MapCave1 extends CustomTiledComponent {
  
  MapCave1()
      : super('cave_1.tmx', colisionValues: [
          1, 2, 3, 5, 6, 7, 8,
          12, 13, 14, 16, 
          23, 24, 25, 27, 31, 32, 33
        ]);
}
