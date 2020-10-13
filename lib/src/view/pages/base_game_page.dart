
import 'package:flutter/material.dart';
import 'package:ihm_2020_3/src/controller/views/pages/base_game_page_controller.dart';
import 'package:ihm_2020_3/src/view/components/dpad_buttom_widget.dart';
import 'package:ihm_2020_3/src/view/components/dpad_joystick_widget.dart';
import 'package:ihm_2020_3/src/view/components/dpad_widget.dart';
import 'package:ihm_2020_3/src/view/components/menu_buttom_widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';


class BaseGamePage extends StatefulWidget {
  static const ROUTE = "/main-game-route";

  const BaseGamePage({Key key}) : super(key: key);

  @override
  BaseGamePageState createState() => BaseGamePageState();
}

class BaseGamePageState extends StateMVC<BaseGamePage> {
  BaseGamePageState() : super(BaseGamePageController());

  BaseGamePageController get con => this.controller;

  final GlobalKey _globalKey = GlobalKey();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  Widget _screenGame() {
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
        child: Container(
          color: Colors.black,
          child: Padding(
            padding: EdgeInsets.only(top: 20, bottom: 5, left: 5, right: 5),
            child: ClipRRect(
              key: _globalKey,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: con.game != null ? con.game.widget : Center(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _dpadGame() {
    return Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            bottom: 0,
            top: 5,
          ),
          child: SizedBox(
            height: 240,
            child: Container(
              // color: Colors.white,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black,
                    Colors.grey,
                    // Colors.black,
                    // Colors.transparent,
                    // Colors.black,
                    // Colors.grey,
                    // Colors.white,
                    // Colors.white,
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  DpadWidget(
                    topButtom: SizedBox(
                        height: 40,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            DpadButtonWidget(
                              onAction: con.game.actionObjective,
                              iconData: Icons.inbox,
                              onReleasedColor: Colors.deepOrange,
                              onSelectedColor: Colors.white,
                              iconReleasedColor: Colors.white,
                              iconSelectedColor: Colors.deepOrange,
                            ),
                            // DpadButtonWidget(
                            //   iconData: Icons.help_outline,
                            //   onAction: () {},
                            // ),
                          ],
                        )),
                    botoesDirecionais: <Widget>[
                      DpadJoystickWidget(onChange: con.game.actionMovement)
                    ],
                    botoesAcao: <Widget>[
                      con.selectionMode
                          ? _floatingB(
                              splashColor: Colors.blue,
                              cor: con.asKeyBlue ? Colors.blue : null,
                              onPressed: con.asKeyBlue
                                  ? con.onAsKeyBlue
                                  : con.onAsKeyDark,
                            )
                          : DpadButtonWidget(
                              iconData: Icons.looks_one,
                              onAction: con.game.actionButtonOne,
                            ),
                      con.selectionMode
                          ? _floatingB(
                              splashColor: Colors.green,
                              cor: con.asKeyGreen ? Colors.green : null,
                              onPressed: con.asKeyGreen
                                  ? con.onAsKeyGreen
                                  : con.onAsKeyDark,
                            )
                          : DpadButtonWidget(
                              iconData: Icons.looks_two,
                              onAction: con.game.actionButtonTwo,
                            ),
                      con.selectionMode
                          ? _floatingB(onPressed: con.onAsKeyDark)
                          : SizedBox(width: 20),
                      con.selectionMode
                          ? _floatingB(
                              splashColor: Colors.yellow,
                              cor: con.asKeyYellow ? Colors.yellow : null,
                              onPressed: con.asKeyYellow
                                  ? con.onAsKeyYellow
                                  : con.onAsKeyDark,
                            )
                          : DpadButtonWidget(
                              iconData: Icons.looks_3,
                              onAction: con.game.actionButtonTree,
                            ),
                      con.selectionMode
                          ? _floatingB(
                              splashColor: Colors.red,
                              cor: con.asKeyRed ? Colors.red : null,
                              onPressed: con.asKeyRed
                                  ? con.onAsKeyRed
                                  : con.onAsKeyDark,
                            )
                          : DpadButtonWidget(
                              iconData: Icons.looks_4,
                              onAction: con.game.actionButtonFour,
                            ),
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: WillPopScope(
          onWillPop: con.onWillPop,
          child: Stack(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _screenGame(),
                  _dpadGame(),
                ],
              ),
            ],
          )),
    );
  }

  Widget _floatingB({Color cor, Function onPressed, Color splashColor}) {
    return FloatingActionButton(
      splashColor: splashColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(color: Colors.black54, width: 2),
      ),
      backgroundColor: cor ?? Colors.grey[800],
      mini: true,
      onPressed: onPressed,
    );
  }

  Widget alert() {
    return AlertDialog(
        // backgroundColor: Colors.black87,
        // insetPadding: EdgeInsets.all(0),

        contentPadding: EdgeInsets.all(0),
        content: Card(
            // color: Colors.black87,
            child: Container(
          // padding: EdgeInsets.all(20),
          // margin: EdgeInsets.all(20),

          height: 300,
          color: Colors.black87,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                "GAME PAUSADO",
                style: TextStyle(
                  color: Colors.white60,
                ),
              ),
              MenuButtomWidget(
                  // textContent: 'AJUSTES',
                  widget: this.con.imageContinuar,
                  onAction: this.con.navigatorPop,
                  splashColor: Colors.lightGreenAccent[800]),
              MenuButtomWidget(
                  // textContent: 'AJUSTES',
                  widget: this.con.imageSair,
                  onAction: this.con.navigatorExit,
                  splashColor: Colors.redAccent[800]),
            ],
          ),
        )));
  }
}

