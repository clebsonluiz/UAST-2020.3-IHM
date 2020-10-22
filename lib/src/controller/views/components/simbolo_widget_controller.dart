import 'dart:math';

import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:ihm_2020_3/src/model/utils/game_model_constants.dart';
import 'package:ihm_2020_3/src/view/components/simbolo_widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class SimboloWidgetController extends ControllerMVC {

  var _spriteWidget1;
  var _spriteWidget2;

  SimboloWidgetController() {
    this._future(9 * 32.0, 9 * 32.0).then((sprite) => setState(() {
          _spriteWidget1 =
              Flame.util.spriteAsWidget(sprite.size.toSize(), sprite);
        }));
    this._future(18 * 32.0, 9 * 32.0).then((sprite) => setState(() {
          _spriteWidget2 =
              Flame.util.spriteAsWidget(sprite.size.toSize(), sprite);
        }));
  }

  Future<Sprite> _future(double x, double y) {
    return Sprite.loadSprite(AnotherConsts.BG_SIMBOLO_2,
        x: x, y: y, width: 8 * 32.0, height: 8 * 32.0);
  }

  @override
  SimboloWidgetState get state => super.state;

  get image =>
      ((this.state.activate) ? this.component1 : this.component2) ?? component3;

  get component1 => _spriteWidget1;
  get component2 => _spriteWidget2;
  get component3 => Image.asset(
        'assets/images/' + AnotherConsts.BG_SIMBOLO_1,
        color: this.state.activate ? null : Colors.grey,
      );

  get dimissibleKey =>
      this.state.widget.tipo +
      this.state.widget.simbolo +
      Random(10).nextDouble().toString();


  set activate(bool b) {
    this.setState(() => this.state.activate = b);
  }

  get activate => this.state.activate;
}
