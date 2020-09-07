import 'dart:ui';

mixin CustomSpriteColision {

  int _boxWidth;
  int _boxHeight;

  int get colisionBoxWidth => _boxWidth;
  int get colisionBoxHeight => _boxHeight;

  // Tipo de colisão da Entidade em 4 Posições,
  // Baseado no exemplo Java Platform Game DragonTaleTutorial do foreignguymike
  bool _colisionOnTopLeft = false;
  bool _colisionOnTopRight = false;
  bool _colisionOnBottomLeft = false;
  bool _colisionOnBottomRight = false;


  get colisionOnTopLeft => this._colisionOnTopLeft;
  get colisionOnTopRight => this._colisionOnTopRight;
  get colisionOnBottomLeft => this._colisionOnBottomLeft;
  get colisionOnBottomRight => this._colisionOnBottomRight;

  set colisionOnTopLeft(bool b) => this._colisionOnTopLeft = b;
  set colisionOnTopRight(bool b) => this._colisionOnTopRight = b;
  set colisionOnBottomLeft(bool b) => this._colisionOnBottomLeft = b;
  set colisionOnBottomRight(bool b) => this._colisionOnBottomRight = b;
  
  void setColisionBox({int width, int height}) {
    this._boxWidth = width;
    this._boxHeight = height;
  }

  bool isIntersectingAnotherBox(Rect outrem) {
    Rect rect = toRect().intersect(outrem);
    return (rect.width > 0 || rect.height > 0);
  }

  Rect toRect();
  
  List<int> colisionFactor();

}