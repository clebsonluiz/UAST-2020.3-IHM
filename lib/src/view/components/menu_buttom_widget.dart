import 'package:flutter/material.dart';

class MenuButtomWidget extends StatelessWidget {
  final Widget widget;
  final Function onAction;
  final String textContent;
  final Color splashColor;

  const MenuButtomWidget(
      {this.widget,
      this.onAction,
      this.textContent,
      this.splashColor = Colors.white})
      : assert(textContent != null || widget != null);

  @override
  Widget build(BuildContext context) {
    final element = (textContent != null) ? _actionText() : widget;

    return Stack(
      children: <Widget>[
        RaisedButton(
          splashColor: splashColor,
          highlightElevation: 0,
          textTheme: ButtonTextTheme.primary,
          elevation: 0,
          color: Colors.transparent,
          onPressed: onAction,
          child: element,
        )
      ],
    );
  }

  Widget _actionText() {
    return Text(
      textContent,
      style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
          fontFamily: 'Times'),
    );
  }
}
