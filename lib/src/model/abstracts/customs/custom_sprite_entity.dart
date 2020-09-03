import 'dart:ui';
import 'custom_sprite_animation.dart';
import 'custom_tiled_component.dart';


//Definição dos atributos padrões que irão compor uma entidade com Sprites
abstract class CustomSpriteEntity extends CustomSpriteAnimation {
  //TileMap a qual a Entidade se encontra
  CustomTiledComponent tileMap;

  // Tipo de colisão da Entidade em 4 Posições,
  // Baseado no exemplo Java Platform Game DragonTaleTutorial do foreignguymike
  bool _colisionTopLeft = false;
  bool _colisionTopRight = false;
  bool _colisionBottomLeft = false;
  bool _colisionBottomRight = false;

  //Movimento, em plataforma up pode ser o pulo(Jump) e down pode ser a queda(Fall)
  bool _idle = true, _up = false, _down = false, _left = false, _right = false;
  bool isLookingAtLeft = false;

  bool _gInverted = false;

  CustomSpriteEntity.fromAnimations(List<CustomAnimation> animations,
      {this.isLookingAtLeft = false, this.tileMap})
      : super.fromAnimations(animations);


  //TODO - Mudar Aqui
  void calcularPosicaoNoMapa(double x, double y) {
    if (tileMap == null || !tileMap.loadedScenario()) return;

    int leftTile = ((x - cBoxWidth / 2) ~/ tileMap.tileWidth);
    int rightTile = ((x + cBoxWidth / 2 - 1) ~/ tileMap.tileWidth);
    int topTile = ((y - cBoxHeight / 2) ~/ tileMap.tileHeight);
    int bottomTile = ((y + cBoxHeight / 2 - 1) ~/ tileMap.tileHeight);

    // _colisionTopLeft = tileMap.getTileColision(topTile, leftTile);
    // _colisionTopRight = tileMap.getTileColision(topTile, rightTile);
    // _colisionBottomLeft = tileMap.getTileColision(bottomTile, leftTile);
    // _colisionBottomRight = tileMap.getTileColision(bottomTile, rightTile);

    _colisionTopLeft = colisionFactor().contains(tileMap.tileMatrix()[topTile] [leftTile]);
    _colisionTopRight = colisionFactor().contains(tileMap.tileMatrix()[topTile] [rightTile]);
    _colisionBottomLeft = colisionFactor().contains(tileMap.tileMatrix()[bottomTile] [leftTile]);
    _colisionBottomRight = colisionFactor().contains(tileMap.tileMatrix()[bottomTile] [rightTile]);

  }

  void checkTileMapColision() {
    if (tileMap == null || !tileMap.loadedScenario()) return;

    int currCol = (this.posX ~/ tileMap.tileWidth);
    int currRow = (this.posY ~/ tileMap.tileHeight);

    double xdest = posX + dX;
    double ydest = posY + dY;

    double xtemp = posX;
    double ytemp = posY;

    calcularPosicaoNoMapa(posX, ydest);

    if (dY < 0) 
    {
      if (_colisionTopLeft || _colisionTopRight) 
      {
        dY = 0;
        ytemp = currRow * tileMap.tileHeight + cBoxHeight / 2;
        if (this._gInverted) this.stopFall();
      } else
        ytemp += dY;
    }
    if (dY > 0) 
    {
      if (_colisionBottomLeft || _colisionBottomRight) 
      {
        dY = 0;
        if(!this._gInverted) stopFall();
        ytemp = (currRow + 1) * tileMap.tileHeight - cBoxHeight / 2;
      } else
        ytemp += dY;
    }

    calcularPosicaoNoMapa(xdest, posY);

    if (dX < 0) 
    {
      if (_colisionTopLeft || _colisionBottomLeft) 
      {
        dX = 0;
        xtemp = currCol * tileMap.tileWidth + cBoxWidth / 2;
      } else
        xtemp += dX;
    }

    if (dX > 0) 
    {
      if (_colisionTopRight || _colisionBottomRight) 
      {
        dX = 0;
        xtemp = (currCol + 1) * tileMap.tileWidth - cBoxWidth / 2;
      } else
        xtemp += dX;
    }

    if (!isFalling) 
    {
      calcularPosicaoNoMapa(posX, ydest + this.gravityValue);

      if ((this._gInverted)? 
        (!_colisionTopLeft && !_colisionTopRight) : 
        (!_colisionBottomLeft && !_colisionBottomRight)) doFall();
    }
    setPosition(x: xtemp, y: ytemp);
  }

  //Movimento somente em duas direções(Esquerda ou direita)
  void walkTo({bool esquerda = false, bool direita = false}) {
    this._left = esquerda;
    this._right = direita;
    stopIdle();
  }

  void doIdle() => this._idle = true;
  void doJump() => this._up = true;
  void doFall() => this._down = true;
  void stopIdle() => this._idle = false;
  void stopJump() => this._up = false;
  void stopFall() => this._down = false;

  bool get isJumping => this._up;
  bool get isFalling => this._down;

  bool get isIdle => _idle;
  bool get isWalkingLeft => _left;
  bool get isWalkingRight => _right;

  double get gravityValue => (this._gInverted) ? -1.0 : 1.0;

  void changeGravity() => this._gInverted = !this._gInverted;
  bool get isGravityInverted => this._gInverted;

  void render(Canvas canvas,
      {double x, double y, bool invertX, bool invertY, double scale}) async {

    
    if(!this.isVisible) return;
    x ??= this.posX + this.tileMap.x - currWidth / 2;
    y ??= this.posY + this.tileMap.y - currHeight / 2;

    invertX ??= isLookingAtLeft ? (!this._left) : (!this._right);
    invertY ??= false;
    scale ??= 1.0;

    super.renderAtPosition(canvas,
        x: x, y: y, invertX: invertX, invertY: invertY, scale: scale);
  }

  /// Retorna `true` se o elemento estiver dentro do quadrante onde se concentra a tela
  bool get isVisible {


    // print("Player: ($posX, $posY) :::: Colision: (${this.currWidth}, ${this.currHeight})");
    // print("TileMap: (${tileMap.x}, ${tileMap.y}) :::: TileMap: ${this.tileMap.renderSize}");


    // print("Esquerda: ${this.posX + this.tileMap.x + this.currWidth > 0}");
    // print("Direita: ${this.posX + this.tileMap.x - this.currWidth < this.tileMap.renderSize.width}");
		// print("Cima: ${this.posY + this.tileMap.y + this.currHeight > 0 }");
		// print("Baixo: ${this.posY + this.tileMap.y - this.currHeight < this.tileMap.renderSize.height}");

    return this.posX + this.tileMap.x + this.currWidth > 0 &&
			this.posX + this.tileMap.x - this.currWidth < this.tileMap.renderSize.width&&
			this.posY + this.tileMap.y + this.currHeight > 0 &&
			this.posY + this.tileMap.y - this.currHeight < this.tileMap.renderSize.height;
  }

  List<int> colisionFactor();

}
