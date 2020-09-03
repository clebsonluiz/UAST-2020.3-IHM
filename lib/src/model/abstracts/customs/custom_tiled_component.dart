import 'dart:convert';
import 'dart:ui';

import 'package:tiled/tiled.dart' show Layer, Tile;
import 'package:flame/components/tiled_component.dart';
import 'package:flame/position.dart';
import 'package:flutter/services.dart';

//Baseado no package:flame/components/tiled_component.dart, e no tutorial Java Platform Game DragonTaleTutorial do foreignguymike
// com mais funcionalidades para se adequar ao uso.
class CustomTiledComponent extends TiledComponent {
  List<List<dynamic>> _colisionTileMatrix = [];
  List<int> colisionValues;
  int tilesRowCount;
  int tilesColCount;
  // Image fullImage;
  int imageWidth;
  int imageHeight;
  int tileWidth;
  int tileHeight;

  int _rowOffset = 0;
  int _colOffset = 0;

  double _tween = 0.0;

  Position _position = Position.empty();

  set x(double x) => _position.x = x;
  set y(double y) => _position.y = y;

  double get x => _position.x;
  double get y => _position.y;

  // limites
  Size _min = Size.zero;
  Size _max = Size.zero;
  Size _screen = Size.zero;

  String fileAssetColisionPath;

  CustomTiledComponent(String tmxFileName,
      {this.colisionValues = const [1], this.fileAssetColisionPath})
      : super(tmxFileName) {
    future.then((f) {
      tilesRowCount ??= map.layers.first.height;
      tilesColCount ??= map.layers.first.width;
      tileWidth ??= map.layers.first.tiles[0].width ?? 32;
      tileHeight ??= map.layers.first.tiles[0].height ?? 32;
      imageWidth ??= tilesColCount * tileWidth;
      imageHeight ??= tilesRowCount * tileHeight;
      _loadFutures();
    });
    _position = Position.empty();
  }

  Future<void> _loadFutures() async {
    if (this.fileAssetColisionPath != null)
      _loadTileMapColision(this.fileAssetColisionPath);
    else
      _loadColisionValues();
  }

  Future<void> _loadTileMapColision(String filePath) async {
    await rootBundle.loadString('assets/' + filePath).then((value) {
      _colisionTileMatrix = LineSplitter()
          .convert(value)
          .map((s) => s.trim().split(","))
          .toList();
      colisionMap.forEach((e) => e.removeWhere((s) => s.length == 0));
    });
  }

  void _loadColisionValues() {
    var colisionMatrix = map.layers.last.tileMatrix;

    colisionMatrix.forEach((y) {
      colisionMap.add([]);
      int index = colisionMatrix.indexOf(y);

      y.forEach((x) {

        int value = colisionValues.contains(x)? 1 : 0 ;

        colisionMap[index].add(value);
      });
    });
  }

  //Mapa de colisão da matriz, 0 para não colisível e 1 para colisível
  List<List<dynamic>> get colisionMap => _colisionTileMatrix;

  List<List<int>> tileMatrix({int from}){
    return (from != null && from >= 0)? this.map.layers[from].tileMatrix : this.map.layers.last.tileMatrix;
  }

  bool loadedScenario() => loaded() && !this._screen.isEmpty;

  @override
  void render(Canvas c) {
    if (!loadedScenario()) return;

      map.layers.forEach((layer) {
        if (layer.visible) this.renderLayer(c, layer);
      });
  }
  
  void renderLayer(Canvas c, Layer layer) {
    
    final _numRowsToDraw = (this._screen.height ~/ tileHeight) + 2;
		final _numColsToDraw = (this._screen.width ~/ tileWidth) + 2;

    for (int row = _rowOffset; row < _rowOffset + _numRowsToDraw; row++) 
    {
      if (row >= tilesRowCount) break;

      for (int col = _colOffset; col < _colOffset + _numColsToDraw; col++) 
      {
        if (col >= tilesColCount) break;

        int index = col + (row * tilesColCount);

        Tile tile = layer.tiles.elementAt(index);

        if (tile.gid != 0) 
        {
          final image = images[tile.image.source];

          final rect = tile.computeDrawRect();
          final src = Rect.fromLTWH(rect.left.toDouble(), rect.top.toDouble(),
              rect.width.toDouble(), rect.height.toDouble());
          final dst = Rect.fromLTWH(tile.x.toDouble() + this.x, tile.y.toDouble() + this.y,
              rect.width.toDouble(), rect.height.toDouble());

          c.drawImageRect(image, src, dst, TiledComponent.paint);
        }
      }
    }
  }

  //TODO - Mudar Aqui
  bool getTileColision(int row, int col) =>
      int.parse(colisionMap[row][col].toString()) == 1;

  void updateScreenSize(Size size) {
    // print(size);
    // print(imageWidth);
    if (this.imageWidth == null || this.imageHeight == null) return;
    this._screen = size ?? Size.zero;
    this._min = Size(this._screen.width - this.imageWidth,
        this._screen.height - this.imageHeight);
    // print(this._screen.isEmpty);
  }

  Size get renderSize => this._screen;

  @override
  void update(double t) {
    print(this._screen.isEmpty);
    if (!this.loadedScenario() || this._screen.isEmpty) return;
  }

  void setTween(double d) {
    this._tween = d;
  }

  void updatePosition(double x, double y) {
    if (!loadedScenario()) return;

    this.x = this.x + (x - this.x) * _tween;
    this.y = this.y + (y - this.y) * _tween;

    _fixBounds();

    _colOffset = -this.x ~/ tileWidth;
    _rowOffset = -this.y ~/ tileHeight;
  }

  void _fixBounds() {
    if (x < _min.width) x = _min.width;
    if (y < _min.height) y = _min.height;
    if (x > _max.width) x = _max.width;
    if (y > _max.height) y = _max.height;
  }
}
