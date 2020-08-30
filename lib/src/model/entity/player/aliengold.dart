import 'package:ihm_2020_3/src/model/abstracts/customs/custom_tiled_component.dart';
import 'package:ihm_2020_3/src/model/abstracts/entity_map.dart';
import 'package:ihm_2020_3/src/model/animations/alien_hunter_gold.dart';

class PlayerAlienGold extends EntityMap {

  @override
  double get moveSpeed => 0.7; // Vel in X axis
  @override
  double get maxMoveSpeed => 2.0; // Max Vel in X axis
  @override
  double get stopSpeed => 0.5; // Stop speed in X axis 
  @override
  double get maxFallSpeed => this.gravityValue * 3.0; // Stop speed in X axis 

  

  bool startInvertion = false;

  PlayerAlienGold(CustomTiledComponent tileMap)
      : super(AlienHunterGold.animations, isLookingAtLeft: true, tileMap: tileMap)
      {
        this.setCBox(height: 35, width: 32);
        // this.resetLifes();
      }

  @override
  void changeGravity() {
    if (!startInvertion)
    {
      super.changeGravity();
      startInvertion = true;
    }
  }

  @override
  void update(double dt, {int currentRow = 0}) async {

    super.update(dt, currentRow: -1);

    startInvertion = nextAnimation==AlienHunterGold.GRAVITY;
  }

  @override
  int get nextAnimation {
    if (isIdle && !(isJumping || isFalling || startInvertion))
      return AlienHunterGold.IDLE;
    else if (isJumping)
      return AlienHunterGold.JUMPING;
    else if (isFalling) 
      return (startInvertion)? AlienHunterGold.GRAVITY : AlienHunterGold.FALLING;
    else if (isWalkingLeft || isWalkingRight)
      return AlienHunterGold.WALKING;
    else
      return AlienHunterGold.IDLE;
  }

}
