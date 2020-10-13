import 'dart:math';

import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ihm_2020_3/src/model/database/models/rank.dart';
import 'package:ihm_2020_3/src/model/database/utils/rank_utils..dart';
import 'package:ihm_2020_3/src/model/utils/game_model_constants.dart';
import 'package:ihm_2020_3/src/view/components/menu_buttom_widget.dart';

import 'package:mvc_pattern/mvc_pattern.dart';

class RankPage extends StatefulWidget {
  static const ROUTE = "/rank";

  RankPage();

  @override
  RankPageState createState() => RankPageState();
}

class RankPageState extends StateMVC<RankPage> {
  RankPageState() : super(RankPageController());

  RankPageController get con => this.controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: WillPopScope(
          onWillPop: this.con.onWillPop,
          child: Stack(
            children: <Widget>[
              Transform.scale(
                scale: 1.0,
                child: this.con.imageBG,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(20),
                    height: 100,
                    alignment: Alignment.topCenter,
                    child: this.con.imageRank,
                  ),
                  Container(
                      padding: EdgeInsets.all(20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        // color: Colors.transparent,
                        child: Container(
                          alignment: Alignment.center,
                          height: 150,
                          color: Colors.transparent,
                          child: Stack(
                            alignment: Alignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              con.img ?? Center(),
                              Center(
                                child: Container(
                                  alignment: Alignment.center,

                                  color: Colors.transparent,
                                  // elevation: 0,
                                  margin: EdgeInsets.all(20),
                                  child: this.con.ranking,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      MenuButtomWidget(
                          widget: this.con.imageSair,
                          onAction: this.con.navigatorPop,
                          splashColor: Colors.yellow[800]),
                    ],
                  ),
                ],
              ),
            ],
          )),
    );
  }
}

class RankPageController extends ControllerMVC {
  RankPageController() {

    this._rank = Rank(
      vidasRestantes: RankUtils().vidasRestantes,
      tempo: RankUtils().tempoDecorridoStr,
      horario: DateTime.now().toString(),
    );
    _rank.save();

    Sprite.loadSprite(
      AnotherConsts.BG_TIMER,
      x: 0,
      y: (9 * 32.0).toDouble(),
      width: (17 * 32).toDouble(),
      height: (8 * 32).toDouble(),
    ).then((value) {
      setState(() {
        _widget1 = Flame.util.spriteAsWidget(value.size.toSize(), value);
      });
    });
  }

  Widget get ranking {
    final vidas = _rank.vidasRestantes;
    final tempo = RankUtils.convertStringToDuration(_rank.tempo)
        .toString()
        .substring(3, 8)
        .replaceAll(".", "");
    final horario = _rank.horario;

    return ListTile(
      // leading:  Icon(Icons.timer, size: 30, color: Colors.black87,),
      leading: SizedBox(
          height: 30,
          width: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _buildImg(image: AnotherConsts.HEARTH_STATUS, maxHeight: 20),
              Text(
                " x $vidas",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                textAlign: TextAlign.end,
              ),
            ],
          )),
      dense: true,
      title: Text(
        tempo,
        style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
        // textAlign: TextAlign.center,
      ),
      subtitle: Text(
        horario.substring(0, 19),
        style: TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.end,
      ),
    );
  }

  Widget _widget1;
  Widget get img => _widget1;

  Widget get imageSair =>
      _buildImg(image: AnotherConsts.MENU_ITEM_4, color: Colors.yellow);

  Widget get imageRank =>
      _buildImg(image: AnotherConsts.MENU_ITEM_9, color: Colors.redAccent);

  Widget get imageCover =>
      Image.asset('assets/images/' + AnotherConsts.BG_OBJETIVE_2,
          color: Colors.grey,
          fit: BoxFit.fill,
          colorBlendMode: BlendMode.modulate,
          width: double.infinity,
          height: double.infinity);

  Widget get imageBG => Image.asset(
        'assets/images/' + AnotherConsts.BG_OBJETIVE_2,
        colorBlendMode: BlendMode.modulate,
        color: Colors.grey[500],
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );

  Widget _buildImg({String image, double maxHeight = 25, Color color}) {
    return LimitedBox(
        key: Key("${Random(10).nextDouble()}" + image),
        maxHeight: maxHeight,
        child: Stack(
          children: <Widget>[
            Image.asset(
              'assets/images/' + image.toString(),
              color: color,
              colorBlendMode: BlendMode.modulate,
            )
          ],
        ));
  }

  static const _duration = Duration(milliseconds: 300);
  DateTime _backButtonPressTime;
  Future<bool> onWillPop() async {
    DateTime currentTime = DateTime.now();

    bool backButtonHasNotBeenPressed = _backButtonPressTime == null ||
        currentTime.difference(_backButtonPressTime) > _duration;

    if (backButtonHasNotBeenPressed) {
      _backButtonPressTime = currentTime;
      return false;
    }
    return true;
  }

  navigatorPop() => Navigator.of(this.state.context).pop();
  navigatorExit() {
    navigatorPop();
    navigatorPop();
  }

  @override
  void initState() {
    super.initState();
  }

  Rank _rank;
}
