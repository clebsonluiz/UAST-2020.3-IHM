import 'dart:ui';

import 'package:flame/animation.dart';
import 'package:flame/components/component.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';

/// Baseado no package:flame/animation.dart, customizado para atender as minhas necessidades
class CustomAnimation extends Animation {
  List<SpriteComponent> _spriteComponents;

  CustomAnimation.empty() : super.empty();

  CustomAnimation(List<Frame> frames, {bool loop = false}) : super(frames, loop: loop);

  CustomAnimation.spriteList(List<Sprite> sprites,
      {double stepTime, bool loop})
      : super.spriteList(sprites, stepTime: stepTime, loop: loop);

  SpriteComponent getSpriteComponent() =>
      (_spriteComponents ??= spritesComponents)[currentIndex];

  List<SpriteComponent> get spritesComponents => List.generate(
      frames.length,
      (index) => SpriteComponent.fromSprite(frames[index].sprite.src.width,
          frames[index].sprite.src.height, frames[index].sprite));
  
  @override
  CustomAnimation reversed() => CustomAnimation(this.frames.reversed.toList(), loop: this.loop);
}

abstract class CustomSpriteAnimation {

  //Colision Box da Entidade
  int _boxWidth;
  int _boxHeight;

  int get cBoxWidth => _boxWidth ??= currWidth.toInt();
  int get cBoxHeight => _boxHeight ??= currHeight.toInt();

  int currRow = 0, currColumn = 0;

  Position _position;
  Position _vector;

  set posX(double x) => _position.x = x;
  set posY(double y) => _position.y = y;

  double get posX => _position.x;
  double get posY => _position.y;

  set dX(double x) => _vector.x = x;
  set dY(double y) => _vector.y = y;

  double get dX => _vector.x;
  double get dY => _vector.y;

  bool _loaded = false;

  List<CustomAnimation> _animations;

  CustomSpriteAnimation.fromAnimations(this._animations)
      : assert(_animations != null) {
    _position = Position.empty();
    _vector = Position.empty();
  }

  void update(double dt, {int currentRow = 0}) async {
    if (animations == null || animations.length == 0) return;
    if (this.currRow != currentRow) animations[this.currRow].reset();
    this.currRow = currentRow;
    animations[this.currRow].update(dt);
  }

  void renderAtPosition(Canvas canvas,
      {double x,
      double y,
      bool invertX = false,
      bool invertY = false,
      double scale = 1.0}) {
    if (animations == null || animations.length == 0 || !loaded()) return;

    SpriteComponent spriteC = animations[currRow].getSpriteComponent();
    canvas.scale(scale);
    spriteC.x = x ?? posX;
    spriteC.y = y ?? posY;
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

  void setPosition({double x, double y}) {
    this.posX = x ?? this.posX;
    this.posY = y ?? this.posY;
  }

  void setVector({double dx, double dy}) {
    this.dX = dx ?? this.dX;
    this.dY = dy ?? this.dY;
  }

  void setCBox({int width, int height}) {
    this._boxWidth = width;
    this._boxHeight = height;
  }

  Rect toRect() {
    if (this.animations == null || this.animations.length == 0) return Rect.zero;

    var sprite = this.animations[this.currRow].getSpriteComponent();

    return Rect.fromLTWH(
        this.posX - sprite.anchor.relativePosition.dx * cBoxWidth,
        this.posY - sprite.anchor.relativePosition.dy * cBoxHeight,
        cBoxWidth.toDouble(),
        cBoxHeight.toDouble());
  }

    bool isIntersectingAnotherBox(Rect outrem) {
    Rect rect = toRect().intersect(outrem);
    return (rect.width > 0 || rect.height > 0);
  }

}
