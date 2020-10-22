import 'package:flutter/material.dart';
import 'package:ihm_2020_3/src/controller/views/components/simbolo_widget_controller.dart';
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
  SimboloWidgetState createState() => SimboloWidgetState(controller: controller);
}

class SimboloWidgetState extends StateMVC<SimboloWidget> {
  
  bool activate = false;


  SimboloWidgetState({SimboloWidgetController controller}) : super(controller ?? SimboloWidgetController());

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
