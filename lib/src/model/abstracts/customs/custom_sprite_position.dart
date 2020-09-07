import 'package:flame/position.dart';

mixin CustomSpritePosition {
  Position _position = Position.empty();
  Position _vector = Position.empty();

  set posX(double x) => _position.x = x;
  set posY(double y) => _position.y = y;

  double get posX => _position.x;
  double get posY => _position.y;

  set dX(double x) => _vector.x = x;
  set dY(double y) => _vector.y = y;

  double get dX => _vector.x;
  double get dY => _vector.y;

  void setPosition({double x, double y}) {
    this.posX = x ?? this.posX;
    this.posY = y ?? this.posY;
  }

  void setVector({double dx, double dy}) {
    this.dX = dx ?? this.dX;
    this.dY = dy ?? this.dY;
  }
}
