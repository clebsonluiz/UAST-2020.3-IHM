import 'package:flutter/material.dart';
import 'package:ihm_2020_3/src/controller/views/components/help_widget_controller.dart';
import 'package:ihm_2020_3/src/view/components/menu_buttom_widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class HelpWidget extends StatefulWidget {
  @override
  _HelpWidgetState createState() => _HelpWidgetState();
}

class _HelpWidgetState extends StateMVC<HelpWidget> {
  _HelpWidgetState() : super(HelpWidgetController());

  HelpWidgetController get con => super.controller;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 400,
        width: MediaQuery.of(context).size.width * 0.95,
        color: Colors.black87,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              "AJUDA",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white60,
              ),
            ),
            Container(
              color: Colors.transparent,
              child: SizedBox(
                height: 250,
                width: 260,
                child: Center(
                  child: this.con.current,
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _floatingBHelp(text: "~", onPressed: this.con.changeToNOT),
                _floatingBHelp(text: "∧", onPressed: this.con.changeToAND),
                _floatingBHelp(text: "v", onPressed: this.con.changeToOR),
                _floatingBHelp(text: "→", onPressed: this.con.changeToCON),
                _floatingBHelp(text: "↔", onPressed: this.con.changeToBICON),
              ],
            ),
            MenuButtomWidget(
                widget: this.con.imageVoltar,
                onAction: this.con.navigatorPop,
                splashColor: Colors.redAccent[800]),
          ],
        ),
      ),
    );
  }

  Widget _floatingBHelp(
      {Color cor, Function onPressed, Color splashColor, String text}) {
    return FloatingActionButton(
      heroTag: "$cor + $text + $splashColor",
      splashColor: splashColor,
      elevation: 1,
      child: Text(
        text,
        style: TextStyle(
            color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 20),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(color: Colors.grey, width: 2),
      ),
      backgroundColor: cor ?? Colors.white70,
      mini: true,
      onPressed: onPressed,
    );
  }
}
