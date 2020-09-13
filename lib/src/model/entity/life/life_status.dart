import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';
import 'package:ihm_2020_3/src/model/abstracts/customs/custom_sprite_entity.dart';

class LifeEntity{

  static LifeEntity _this;

  static LifeEntity get instance => _this??= LifeEntity._();
  
  // factory LifeEntity(){
  //   return _this??= LifeEntity._();
  // }

  SpriteComponent _life;

  LifeEntity._() 
  {
    Sprite.loadSprite('Vida.png', x: 0, y: 0, width: 65, height: 55).then((life){
      this._life = SpriteComponent.fromSprite(life.size.x  * 0.15, life.size.y * 0.15, life);
    });
  }

  void render(Canvas canvas, CustomSpriteEntity e) async
  {
    if(_life == null || !_life.loaded()) return;
    
    double x = e.posX + e.tileMap.x;
    double y = e.posY + e.tileMap.y;
    double height = e.colisionBoxHeight.toDouble();
    double width = e.colisionBoxWidth.toDouble();
    bool g = e.isGravityInverted;
    int lifes = e.life;
    
    for(int i = 1; i <= lifes; i++)
    {
      if( i == 3)
      {
        _life.x = x - width  * 0.35;
        _life.y = y - height *  (g? -0.9  : 1.1);
      }
      else if (i == 2)
      {
        _life.x = x - width * - 0.15;
        _life.y = y - height * (g? -0.9  : 1.1);
      }
      else
      {
        _life.x = x - width * 0.1;
        _life.y = y - height * (g? - 0.7  : 0.9);
      }
      canvas.save();
      _life.renderFlipY = e.isGravityInverted;
      _life.render(canvas);
      canvas.restore();
    }
  }

}