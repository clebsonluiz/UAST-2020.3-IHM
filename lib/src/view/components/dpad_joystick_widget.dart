import 'package:flutter/material.dart';
import 'package:ihm_2020_3/src/controller/views/components/dpad_widgets_controllers.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

//Minha adaptação para o uso nessa aplicação, Original vem de https://jap.alekhin.io/onscreen-joystick-joypad-controller-flame-game
class DpadJoystickWidget extends StatefulWidget {
  final void Function(Offset, JoystickDirection) onChange;

  DpadJoystickWidget({
    Key key,
    @required this.onChange,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DpadJoystickWidgetState();
}

class _DpadJoystickWidgetState extends StateMVC<DpadJoystickWidget> {

  _DpadJoystickWidgetState() : super(DpadJoystickController());

  DpadJoystickController get con => this.controller;

  Widget build(BuildContext context) => SizedBox(
        height: 60,
        width: 120,
        child: Container(
          //Verificar a necessidade desse container, ja que aparentemente ele não é importante
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
                  offset: this.con.deltaOffset,
                  child: SizedBox(
                    height: 50,
                    width: 70,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Icon(
                        this.con.deltaOffset.dx != 0
                            ? con.deltaOffset.dx < 0
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
            onPanDown: this.con.onDragDown,
            onPanUpdate: this.con.onDragUpdate,
            onPanEnd: this.con.onDragEnd,
          ),
        ),
      );

}

