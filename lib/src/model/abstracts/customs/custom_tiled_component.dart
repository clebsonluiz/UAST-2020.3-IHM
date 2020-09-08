import 'dart:ui';

import 'package:flame/components/component.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:tiled/tiled.dart' show Layer, Tile, TileMap, TileMapParser;
// import 'package:flame/components/tiled_component.dart';
import 'package:flame/position.dart';

//Baseado no package:flame/components/tiled_component.dart, e no tutorial Java Platform Game DragonTaleTutorial do foreignguymike
// com mais funcionalidades para se adequar ao uso.
class CustomTiledComponent extends Component {
  
  static final Paint paint = Paint()..color = Colors.white;
  
  String _filename;
  TileMap _map;
  Image _image;
  Map<String, Image> _images = <String, Image>{};
  Future _future;
  bool _loaded = false;

  int _tilesRowCount;
  int _tilesColCount;

  int get tilesRowCount => _tilesRowCount;
  int get tilesColCount => _tilesColCount;

  int _imageWidth;
  int _imageHeight;

  int get imageWidth => _imageWidth;
  int get imageHeight => _imageHeight;


  int _tileWidth;
  int _tileHeight;

  int get tileWidth => _tileWidth;
  int get tileHeight => _tileHeight;

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
  Size _renderSize = Size.zero;


  CustomTiledComponent(
    this._filename,
  ) {
    _future = _load();

    _future.then((f) {
      _tilesRowCount ??= this._map.layers.first.height;
      _tilesColCount ??= this._map.layers.first.width;
      _tileWidth ??= this._map.layers.first.tiles[0].width ?? 32;
      _tileHeight ??= this._map.layers.first.tiles[0].height ?? 32;
      _imageWidth ??= tilesColCount * _tileWidth;
      _imageHeight ??= tilesRowCount * _tileHeight;

    });
    _position = Position.empty();
  }

  Future _load() async {
    this._map = await _loadMap();
    this._image = await Flame.images.load(this._map.tilesets[0].image.source);
    this._images = await _loadImages(this._map);
    _loaded = true;
  }

  Future<TileMap> _loadMap() {
    return Flame.bundle
        .loadString('assets/tiles/' + this._filename)
        .then((contents) {
      final parser = TileMapParser();
      return parser.parse(contents);
    });
  }

  Future<Map<String, Image>> _loadImages(TileMap map) async {
    final Map<String, Image> result = {};
    await Future.forEach(map.tilesets, (tileset) async {
      await Future.forEach(tileset.images, (tmxImage) async {
        result[tmxImage.source] = await Flame.images.load(tmxImage.source);
      });
    });
    return result;
  }

  List<List<int>> tileMatrix({int from}) {
    return (from != null && from >= 0)
        ? this._map.layers[from].tileMatrix
        : this._map.layers.last.tileMatrix;
  }

  bool loaded() => _loaded && !this._renderSize.isEmpty;

  @override
  void render(Canvas c) {
    if (!loaded()) return;
    c.save();
    this._map.layers.forEach((layer) {
      if (layer.visible) this._renderLayer(c, layer);
    });
    c.restore();
  }

  void _renderLayer(Canvas c, Layer layer) {
    final _numRowsToDraw = (this._renderSize.height ~/ tileHeight) + 2;
    final _numColsToDraw = (this._renderSize.width ~/ tileWidth) + 2;

    for (int row = _rowOffset; row < _rowOffset + _numRowsToDraw; row++) {
      if (row >= tilesRowCount) break;

      for (int col = _colOffset; col < _colOffset + _numColsToDraw; col++) {
        if (col >= tilesColCount) break;

        int index = col + (row * tilesColCount);

        Tile tile = layer.tiles.elementAt(index);

        if (tile.gid != 0) {
          final image = this._images[tile.image.source];

          final rect = tile.computeDrawRect();
          final src = Rect.fromLTWH(rect.left.toDouble(), rect.top.toDouble(),
              rect.width.toDouble(), rect.height.toDouble());
          final dst = Rect.fromLTWH(
              tile.x.toDouble() + this.x,
              tile.y.toDouble() + this.y,
              rect.width.toDouble(),
              rect.height.toDouble());

          c.drawImageRect(image, src, dst, CustomTiledComponent.paint);
        }
      }
    }
  }

  //TODO - 
  void updateScreenSize(Size size) {
    if (this.imageWidth == null || this.imageHeight == null) return;
    this._renderSize = size ?? Size.zero;
    this._min = Size(this._renderSize.width - this.imageWidth,
        this._renderSize.height - this.imageHeight);

  }

  Size get renderSize => this._renderSize;

  @override
  void update(double t) {
    if (!this.loaded() || this._renderSize.isEmpty) return;
  }

  void setTween(double d) {
    this._tween = d;
  }

  void updatePosition(double x, double y) {
    if (!loaded()) return;

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

  // Future<ObjectGroup> getObjectGroupFromLayer(String name) {
  //   return future.then((onValue) {
  //     return map.objectGroups
  //         .firstWhere((objectGroup) => objectGroup.name == name);
  //   });
  // }

  String get filename => _filename;
  TileMap get map => _map;
  Image get image => _image;
  Map<String, Image> get images => _images;
}
