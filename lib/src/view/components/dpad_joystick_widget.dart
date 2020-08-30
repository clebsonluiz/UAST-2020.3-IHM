import 'dart:math';
import 'package:flutter/material.dart';

//Minha adaptação para o uso nessa aplicação, Original vem de https://jap.alekhin.io/onscreen-joystick-joypad-controller-flame-game
class DpadJoystickWidget extends StatefulWidget {
  final void Function(Offset) onChange;

  DpadJoystickWidget({
    Key key, 
    @required this.onChange,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DpadJoystickWidgetState();
}

class _DpadJoystickWidgetState extends State<DpadJoystickWidget> {
  Offset _delta = Offset.zero;

  void updateDelta(Offset newDelta) {
    widget.onChange(newDelta);
    setState(() => _delta = newDelta);
  }

  void calculateDelta(Offset offset) {
    Offset newDelta = offset - Offset(60, 60);
    updateDelta(
      Offset.fromDirection(
        newDelta.direction,
        min(30, newDelta.distance),
      ),
    );
  }

  Widget build(BuildContext context) =>
    SizedBox(
      height: 60,
      width: 120,
      child: Container(//Verificar a necessidade desse container, ja que aparentemente ele não é importante
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
        ),
        child: GestureDetector(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(32),
            ),
            child: Center(
              child: Transform.translate(
                offset: _delta,
                child: SizedBox(
                  height: 50,
                  width: 70,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Icon(
                      _delta.dx != 0
                          ? _delta.dx < 0
                              ? Icons.chevron_left
                              : Icons.chevron_right
                          : Icons.blur_on,
                      size: 50,
                      color: Colors.black45,
                    ),
                  ),
                ),
              ),
            ),
          ),
          onPanDown: onDragDown,
          onPanUpdate: onDragUpdate,
          onPanEnd: onDragEnd,
        ),
      ),
    );

  void onDragDown(DragDownDetails d) => calculateDelta(d.localPosition);

  void onDragUpdate(DragUpdateDetails d) => calculateDelta(d.localPosition);

  void onDragEnd(DragEndDetails d) => updateDelta(Offset.zero);
}
