import 'dart:math';

import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:ihm_2020_3/src/model/utils/game_model_constants.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class SimboloWidget extends StatefulWidget {
  final String tipo;
  final String simbolo;
  final bool activate;
  final bool isDimissible;

  final Future<bool> Function(DismissDirection) confirmDismiss;
  final Function(DismissDirection) onDismissed;
  final controller;


  SimboloWidget({
    Key key,
    this.simbolo,
    this.tipo,
    this.activate = true,
    this.isDimissible = false,
    this.confirmDismiss,
    this.onDismissed,
    this.controller
  }) : super(key: key);

  @override
  _SimboloWidgetState createState() => _SimboloWidgetState(controller: controller);
}

class _SimboloWidgetState extends StateMVC<SimboloWidget> {
  
  bool activate = false;


  _SimboloWidgetState({SimboloWidgetController controller}) : super(controller ?? SimboloWidgetController());

  SimboloWidgetController get con => this.controller;

  @override
  void initState() {
    this.activate = this.widget.activate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isDimissible ? _dismissible() : _card();
  }

  Widget _dismissible() {
    return Dismissible(
      key: Key(con.dimissibleKey),
      direction: DismissDirection.vertical,
      background: Icon(
        Icons.delete_sweep,
        color: Colors.red,
        size: 30,
      ),
      confirmDismiss: widget.confirmDismiss,
      onDismissed: widget.onDismissed,
      child: _card(),
    );
  }

  Widget _card() {
    return Card(
      key: ValueKey(widget.simbolo),
      margin: EdgeInsets.all(2),
      elevation: 0,
      color: Colors.transparent,
      child: Container(
        height: 50,
        width: 50,
        child: Stack(
          children: <Widget>[
            LimitedBox(
              maxHeight: 70,
              child: con.image,
            ),
            Center(
              child: Text(
                widget.simbolo ?? "",
                style: TextStyle(
                    fontSize: 30,
                    color: (activate? Colors.black : Colors.black26),
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
  _SimboloWidgetState get state => super.state;

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
