import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ihm_2020_3/src/model/database/models/rank.dart';
import 'package:ihm_2020_3/src/model/database/utils/rank_utils..dart';
import 'package:ihm_2020_3/src/model/utils/game_model_constants.dart';
import 'package:ihm_2020_3/src/view/components/menu_buttom_widget.dart';

import 'package:mvc_pattern/mvc_pattern.dart';

class RankingPage extends StatefulWidget {
  static const ROUTE = "/ranking";

  RankingPage();

  @override
  RankingPageState createState() => RankingPageState();
}

class RankingPageState extends StateMVC<RankingPage> {
  RankingPageState() : super(RankingPageController());

  RankingPageController get con => this.controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Stack(
        children: <Widget>[
          Transform.scale(
            scale: 1.0,
            child: this.con.imageBG,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20),
                height: 100,
                alignment: Alignment.topCenter,
                child: this.con.imageRanking,
              ),
              Container(
                  padding: EdgeInsets.all(20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    // color: Colors.transparent,
                    child: Container(
                      alignment: Alignment.center,
                      height: 350,
                      color: Colors.transparent,
                      child: Stack(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          con.imageCover,
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 22),
                            child: ListView.builder(
                              itemBuilder: this.con.buildRanking,
                              itemCount: this.con.ranks.length,
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  MenuButtomWidget(
                      widget: this.con.imageVoltar,
                      onAction: this.con.navigatorPop,
                      splashColor: Colors.yellow[800]),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RankingPageController extends ControllerMVC {
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
        textAlign: TextAlign.end,
      ),
    );

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(color: Colors.black87, width: 5),
      ),
      color: Colors.grey,
      child: tile,
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
