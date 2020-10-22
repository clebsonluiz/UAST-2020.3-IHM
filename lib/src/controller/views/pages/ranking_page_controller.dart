import 'dart:math';

import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:ihm_2020_3/src/model/database/models/rank.dart';
import 'package:ihm_2020_3/src/model/database/utils/rank_utils..dart';
import 'package:ihm_2020_3/src/model/utils/game_model_constants.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class RankingPageController extends ControllerMVC {
  Widget _widget1;

  RankingPageController() {
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

  Widget get imageVoltar =>
      _buildImg(image: AnotherConsts.MENU_ITEM_12, color: Colors.yellow);

  Widget get imageRanking =>
      _buildImg(image: AnotherConsts.MENU_ITEM_8, color: Colors.redAccent);

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

  Widget buildRanking(BuildContext context, int index) {
    final Rank rank = this.ranks[index];
    final vidas = rank.vidasRestantes;
    final tempo = RankUtils.convertStringToDuration(rank.tempo)
        .toString()
        .substring(3, 8)
        .replaceAll(".", "");
    final horario = rank.horario;

    final tile = ListTile(
      // leading:  Icon(Icons.timer, size: 30, color: Colors.black87,),
      leading: SizedBox(
          height: 30,
          width: 80,
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
        textAlign: TextAlign.left,
      ),
    );

    return Container(
      alignment: Alignment.center,
      height: 100,
      margin: EdgeInsets.symmetric(vertical: 5),
      color: Colors.transparent,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          _widget1 ?? Center(),
          Center(
            child: Container(
              alignment: Alignment.center,
              color: Colors.transparent,
              margin: EdgeInsets.all(5),
              child: tile,
            ),
          ),
        ],
      ),
    );
  }

  navigatorPop() => Navigator.of(this.state.context).pop();

  @override
  void initState() {
    super.initState();
    _loadRanks();
  }

  _loadRanks() {
    Rank.getAll().then((value) {
      value
        ..addAll([
          // Rank(
          //   vidasRestantes: 3,
          //   tempo: "0;0;05;30",
          //   horario: DateTime.now().toString(),
          // ),
          // Rank(
          //   vidasRestantes: 2,
          //   tempo: "0;0;05;30",
          //   horario: DateTime.now().toString(),
          // ),
          // Rank(
          //   vidasRestantes: 1,
          //   tempo: "0;0;04;30",
          //   horario: DateTime.now().toString(),
          // ),
          // Rank(
          //   vidasRestantes: 3,
          //   tempo: "0;0;05;40",
          //   horario: DateTime.now().toString(),
          // ),
        ]);

      value.sort();

      setState(() {
        this._ranks =
            List.of(value).sublist(0, value.length <= 6 ? value.length : 6);
      });
    });
  }

  List<Rank> get ranks => this._ranks;

  List<Rank> _ranks = [];
}
