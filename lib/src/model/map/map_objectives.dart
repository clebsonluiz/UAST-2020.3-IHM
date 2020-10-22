// import 'package:ihm_2020_3/src/model/abstracts/objective_map.dart';
// import 'package:ihm_2020_3/src/model/utils/game_model_constants.dart';

// class MapObjective1 extends ObjectiveMap {
//   MapObjective1() : super(AnotherConsts.BG_OBJETIVE_1);
// }

// class MapObjective2 extends ObjectiveMap {
//   MapObjective2() : super(AnotherConsts.BG_OBJETIVE_2);
// }

// class MapObjectiveSimple extends ObjectiveMap {
//   MapObjectiveSimple()
//       : super(
//           AnotherConsts.BG_TIMER,
//           y: (9 * 32.0).toDouble(),
//           width: (17 * 32).toDouble(),
//           height: (8 * 32).toDouble(),
//         );
// }

import 'dart:ui';

import 'package:ihm_2020_3/src/model/abstracts/customs/custom_sprite_position.dart';
import 'package:ihm_2020_3/src/model/entity/symbol/symbol_object_box_expression.dart';
import 'package:ihm_2020_3/src/model/objetivo/objetivo.dart';

class _MapObjective with CustomSpritePosition {
  String _text = "";

  String get text => _text;

  set text(text) => _text = text;

  final _maior = SymbolObjectBoxExpression.fromMaior();
  final _normal = SymbolObjectBoxExpression.fromNormal();
  final _menor = SymbolObjectBoxExpression.fromMenor();

  SymbolObjectBoxExpression _current;

  SymbolObjectBoxExpression get current => this._current ??= this._normal;

  void render(Canvas canvas) {
    if (!this.loaded()) return;
    this.current.renderOnPositioned(canvas);
  }

  void update(double dt) {
    if (_text.length <= 3) {
      this._current = _menor;
    } else if (_text.length <= 7) {
      this._current = _normal;
    } else {
      this._current = _maior;
    }
    if (!this.loaded()) return;
    this._current?.posX = this.posX;
    this._current?.posY = this.posY;
    this._current?.text = _text;
  }

  bool loaded() => this.current != null && this.current.loaded();
}

class MapObjectiveExpression with CustomSpritePosition {

  String get text => this._expressao?.text;

  set text(text) => this._expressao?.text = text;

  bool _show = true;

  void changeVisibility() => this._show = !this._show;

  final _MapObjective _expressao = _MapObjective();

  final List<_MapObjective> _dicionarios = [
    _MapObjective(),
    _MapObjective(),
    _MapObjective(),
  ];

  List<_MapObjective> get dicionarios => this._dicionarios;

  void render(Canvas canvas) {
    this._expressao.render(canvas);
    if (!this._show) return;
    this.objetivo.current.dicionario.forEach((str) {
      final index = this.objetivo.current.dicionario.indexOf(str);
      final e = this._dicionarios[index];
      e.render(canvas);
    });
    // this._dicionarios.forEach((e)=> e.render(canvas));
  }

  void update(double dt) {

    double _height = 7 * 32.0 * 0.15 ;

    this._expressao.posX = this.posX;
    this._expressao.posY = this.posY;

    this._expressao.update(dt);
    
    this.objetivo.current.dicionario.forEach((str) {
      final index = this.objetivo.current.dicionario.indexOf(str);
      final e = this._dicionarios[index];
      e.text = str;
      e.posX = this.posX;
      e.posY = this.posY + (_height * (index + 1)) ;
      e.update(dt);
    });


    // this._dicionarios.forEach((e){
    //   e.posX = this.posX;
    //   e.posY = this.posY + (_height * (this._dicionarios.indexOf(e) + 1)) ;
    //   e.update(dt);
    // });
  }

  Objetivo get objetivo => Objetivo();

}
