import 'package:flutter/material.dart';
import 'package:ihm_2020_3/src/controller/views/components/dpad_widgets_controllers.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class DpadButtonWidget extends StatefulWidget {
  final Function() onAction;
  final IconData iconData;
  final IconData iconDataOnSelected;
  final Color onSelectedColor;
  final Color onReleasedColor;
  final Color iconSelectedColor;
  final Color iconReleasedColor;
  final double sizeIconOnSelected;
  final double sizeIconOnReleased;

  DpadButtonWidget({
    @required this.onAction,
    @required this.iconData,
    this.iconDataOnSelected,
    this.onSelectedColor = Colors.white70,
    this.onReleasedColor = Colors.grey,
    this.iconSelectedColor = Colors.black,
    this.iconReleasedColor = Colors.white,
    this.sizeIconOnSelected = 30.0,
    this.sizeIconOnReleased = 35.0,
  });

  @override
  State<StatefulWidget> createState() => _DpadButtonWidgetState();
}

class _DpadButtonWidgetState extends StateMVC<DpadButtonWidget> {
  _DpadButtonWidgetState() : super(DpadButtonController());

  DpadButtonController get con => this.controller;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 60,
        width: 60,
        child: GestureDetector(
          child: Container(
            child: Center(
              child: SizedBox(
                height: this.con.holding ? 50 : 55,
                width: this.con.holding ? 50 : 55,
                child: Container(
                  child: Icon(
                    this.con.holding
                        ? widget.iconDataOnSelected ?? widget.iconData
                        : widget.iconData,
                    color: this.con.holding
                        ? widget.iconSelectedColor
                        : widget.iconReleasedColor,
                    size: this.con.holding
                        ? widget.sizeIconOnSelected
                        : widget.sizeIconOnReleased,
                  ),
                  decoration: BoxDecoration(
                    color: this.con.holding
                        ? widget.onSelectedColor
                        : widget.onReleasedColor,
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(32),
            ),
          ),
          onTapDown: this.con.onTapDown,
          onTapUp: this.con.onTapUp,
          onTapCancel: this.con.onTapCancel,
        ),
      );
}
