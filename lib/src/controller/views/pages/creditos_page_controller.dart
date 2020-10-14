import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ihm_2020_3/src/model/animations/alien_flying_commander.dart';
import 'package:ihm_2020_3/src/model/animations/alien_hunter_golden_colors.dart';
import 'package:ihm_2020_3/src/model/animations/alien_hunter_walker.dart';
import 'package:ihm_2020_3/src/model/animations/alien_mini_ufo.dart';
import 'package:ihm_2020_3/src/model/animations/alien_smasher.dart';
import 'package:ihm_2020_3/src/model/animations/flesh_eating_slugger.dart';
import 'package:ihm_2020_3/src/model/animations/jellyfish.dart';
import 'package:ihm_2020_3/src/model/utils/game_model_constants.dart';
import 'package:ihm_2020_3/src/view/pages/creditos_page.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class CreditosPageController extends ControllerMVC {
  final logobsi = 'logo_bsi.png';
  final logouast = 'logo_uast.png';
  final desc =
      'Projeto desenvolvido por Clébson Luiz de Moraes Silva, sendo ' +
      'direcionado a disciplina de Interface Homem-Máquina (IHM), voltado ' +
      'para o curso de Bacharelado em Sistemas de Informação na Unidade Acadêmica de Serra Talhada (UAST) ' +
      'no período de 2020.3, este projeto foi acompanhado e orientado pelo professor da disciplina '
      'Richarlyson D\'Emery.';

  final List list = [];

  Widget get image1 => _buildImg(image: logouast, maxHeight: 100.0);
  Widget get image2 => _buildImg(image: logobsi, maxHeight: 70.0);

  Widget get imageCredits => _buildImg(
      image: AnotherConsts.MENU_ITEM_3,
      color: Colors.lightGreenAccent,
      maxHeight: 30);
  Widget get imageVoltar =>
      _buildImg(image: AnotherConsts.MENU_ITEM_12, color: Colors.yellow);

  Widget get imageCover =>
      Image.asset('assets/images/' + AnotherConsts.BG_OBJETIVE_2,
          color: Colors.grey[500],
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

  @override
  CreditosPageState get state => super.state;

  void onExpansionChanged(bool b) {
    if (b) {
      this.list.clear();
      _loadAnimations();
    }
  }

  void _loadAnimations() {
    AlienHunterGoldenColor()
        .detalhes
        .then((value) => setState(() => this.list.add(value)));
    AlienHunterWalker.detalhes
        .then((value) => setState(() => this.list.add(value)));
    AlienSmasher.detalhes.then((value) => setState(() => this.list.add(value)));
    FleshEatingSlug.detalhes
        .then((value) => setState(() => this.list.add(value)));
    AlienFlyingCommander.detalhes
        .then((value) => setState(() => this.list.add(value)));
    AlienMiniUFO.detalhes.then((value) => setState(() => this.list.add(value)));
    Jellyfish.detalhes.then((value) => setState(() => this.list.add(value)));
  }

  // Widget _buildImageSized({String image, double maxHeight = 70}) {
  //   return LimitedBox(
  //       maxHeight: maxHeight,
  //       child: Image.asset(
  //         'assets/images/' + image.toString(),
  //         color: null,
  //       ));
  // }

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

  navigatorPop() => Navigator.of(this.state.context).pop();
}
