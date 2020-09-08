import 'package:flutter/material.dart';

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

class _DpadButtonWidgetState extends State<DpadButtonWidget> {
  bool _holding = false;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 60,
        width: 60,
        child: GestureDetector(
          child: Container(
            child: Center(
              child: SizedBox(
                height: _holding ? 50 : 55,
                width: _holding ? 50 : 55,
                child: Container(
                  child: Icon(
                    _holding
                        ? widget.iconDataOnSelected ?? widget.iconData
                        : widget.iconData,
                    color: _holding
                        ? widget.iconSelectedColor
                        : widget.iconReleasedColor,
                    size: _holding
                        ? widget.sizeIconOnSelected
                        : widget.sizeIconOnReleased,
                  ),
                  decoration: BoxDecoration(
                    color: _holding
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
          onTapDown: (tdd) => onTapDown(tdd),
          onTapUp: (tud) => onTapUp(tud),
          onTapCancel: () => onTapCancel(),
        ),
      );

  void onTapDown(TapDownDetails tdd) {
    setState(() => _holding = true);
    widget.onAction();
  }

  void onTapUp(TapUpDetails tud) {
    setState(() => _holding = false);
  }

  void onTapCancel() {
    setState(() => _holding = false);
  }
}
