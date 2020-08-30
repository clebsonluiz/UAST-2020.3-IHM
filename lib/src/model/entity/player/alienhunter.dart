import 'package:ihm_2020_3/src/model/abstracts/customs/custom_tiled_component.dart';
import 'package:ihm_2020_3/src/model/abstracts/entity_map.dart';
import 'package:ihm_2020_3/src/model/animations/alien_hunter_walker.dart';

class PlayerAlienHunter extends EntityMap {

  PlayerAlienHunter(CustomTiledComponent tileMap)
      : super(AlienHunterWalker.animations, isLookingAtLeft: true, tileMap: tileMap)
      {
        this.setCBox(height: 35, width: 32);
      }

  @override
  int get nextAnimation {
    if (isIdle && !(isJumping || isFalling))
      return AlienHunterWalker.IDLE;
    else if (isJumping)
      return AlienHunterWalker.JUMPING;
    else if (isFalling)
      return AlienHunterWalker.FALLING;
    else if (isWalkingLeft || isWalkingRight)
      return AlienHunterWalker.WALKING;
    else
      return AlienHunterWalker.IDLE;
  }

}
