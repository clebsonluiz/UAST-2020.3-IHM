import 'dart:ui';

import 'package:flame/animation.dart';
import 'package:flame/components/component.dart';
import 'package:flame/sprite.dart';

/// Baseado no package:flame/animation.dart, customizado para atender as minhas necessidades
class CustomAnimation extends Animation {
  List<SpriteComponent> _spriteComponents;

  CustomAnimation.empty() : super.empty();

  CustomAnimation(List<Frame> frames, {bool loop = false})
      : super(frames, loop: loop);

  CustomAnimation.spriteList(List<Sprite> sprites, {double stepTime, bool loop})
      : super.spriteList(sprites, stepTime: stepTime, loop: loop);

  SpriteComponent getSpriteComponent() =>
      (_spriteComponents ??= spritesComponents)[currentIndex];

  List<SpriteComponent> get spritesComponents {
    return List.generate(frames.length, (index) {
      return SpriteComponent.fromSprite(frames[index].sprite.src.width,
          frames[index].sprite.src.height, frames[index].sprite);
    });
  }

  @override
  CustomAnimation reversed() {
    return CustomAnimation(this.frames.reversed.toList(), loop: this.loop);
  }
}

class CustomSpriteAnimation {


  int currRow = 0, currColumn = 0;

  bool _loaded = false;

  List<CustomAnimation> _animations;

  CustomSpriteAnimation.fromAnimations(this._animations)
      : assert(_animations != null);

  void update(double dt, {int currentRow = 0}) async {
    if (animations == null || animations.length == 0) return;
    if (this.currRow != currentRow) animations[this.currRow].reset();
    this.currRow = currentRow;
    animations[this.currRow].update(dt);
  }

  void renderAtPosition(Canvas canvas,
      {double x = 0,
      double y = 0,
      bool invertX = false,
      bool invertY = false,
      double scale = 1.0}) {
    if (animations == null || animations.length == 0 || !loaded()) return;

    SpriteComponent spriteC = animations[currRow].getSpriteComponent();
    canvas.scale(scale);
    spriteC.x = x ;
    spriteC.y = y ;
    spriteC.renderFlipX = invertX;
    spriteC.renderFlipY = invertY;
    spriteC.render(canvas);
    canvas.scale(1.0);
  }

  bool loaded() => _loaded
      ? _loaded
      : (_loaded = animations.every((animation) => animation.loaded()));

  List<CustomAnimation> get animations => this._animations;

  CustomAnimation get currentAnimation =>
      animations.length != 0 ? animations[currRow] : null;

  SpriteComponent get currentSpriteFrame =>
      currentAnimation != null ? currentAnimation.getSpriteComponent() : null;

  double get currWidth => loaded() ? currentSpriteFrame.width : 0;
  double get currHeight => loaded() ? currentSpriteFrame.height : 0;

}
