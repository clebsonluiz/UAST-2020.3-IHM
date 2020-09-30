import 'dart:math';

import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:ihm_2020_3/src/model/utils/game_model_constants.dart';

class SimboloWidget extends StatefulWidget {
  final String tipo;
  final String simbolo;
  final bool activate;
  final bool isDimissible;

  final Future<bool> Function(DismissDirection) confirmDismiss;
  final Function(DismissDirection) onDismissed;

  const SimboloWidget({
    Key key,
    this.simbolo,
    this.tipo,
    this.activate = true,
    this.isDimissible = false,
    this.confirmDismiss,
    this.onDismissed,
  }) : super(key: key);

  @override
  _SimboloWidgetState createState() => _SimboloWidgetState();
}

class _SimboloWidgetState extends State<SimboloWidget> {
  var spriteWidget1;
  var spriteWidget2;
  @override
  Widget build(BuildContext context) {
    return widget.isDimissible ? _dismissible() : _card();
  }

  @override
  void initState() {
    final sprite1 = Sprite.loadSprite(AnotherConsts.BG_SIMBOLO_2,
        x: (9 * 32).toDouble(),
        y: (9 * 32).toDouble(),
        width: (8 * 32).toDouble(),
        height: (8 * 32).toDouble());

    sprite1.then((value) => setState(() {
          spriteWidget1 = Flame.util.spriteAsWidget(value.size.toSize(), value);
        }));


    final sprite2 = Sprite.loadSprite(AnotherConsts.BG_SIMBOLO_2,
        x: (18 * 32).toDouble(),
        y: (9 * 32).toDouble(),
        width: (8 * 32).toDouble(),
        height: (8 * 32).toDouble());

    sprite2.then((value) => setState(() {
          spriteWidget2 = Flame.util.spriteAsWidget(value.size.toSize(), value);
        }));

    super.initState();
  }

  Widget _dismissible() {
    return Dismissible(
      key: Key(
          widget.tipo + widget.simbolo + Random(10).nextDouble().toString()),
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
            _buildImageSized(image: AnotherConsts.BG_SIMBOLO_1),
            Center(
              child: Text(
                widget.simbolo ?? "",
                style: TextStyle(
                    fontSize: 30,
                    color: (widget.activate? this.spriteWidget1 : this.spriteWidget2) != null ? Colors.black : Colors.white,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSized({String image, double maxHeight = 70}) {
    return LimitedBox(
      maxHeight: maxHeight,
      child: (widget.activate? this.spriteWidget1 : this.spriteWidget2) ??
          Image.asset(
            'assets/images/' + image.toString(),
            color: widget.activate ? null : Colors.grey,
          ),
    );
  }
}
