import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ihm_2020_3/src/model/animations/alien_flying_commander.dart';
import 'package:ihm_2020_3/src/model/animations/alien_hunter_gold.dart';
import 'package:ihm_2020_3/src/model/animations/alien_hunter_walker.dart';
import 'package:ihm_2020_3/src/model/animations/alien_mini_ufo.dart';
import 'package:ihm_2020_3/src/model/animations/alien_smasher.dart';
import 'package:ihm_2020_3/src/model/animations/flesh_eating_slugger.dart';
import 'package:ihm_2020_3/src/model/animations/jellyfish.dart';
import 'package:ihm_2020_3/src/view/components/credito_widget.dart';

class CreditosPage extends StatefulWidget {
  final List list = [];

  CreditosPage();

  @override
  State<CreditosPage> createState() => CreditosPageState();
}

class CreditosPageState extends State<CreditosPage> {
  @override
  void initState() {
    super.initState();
    // _loadAnimations();
  }

  void _loadAnimations() {
    AlienHunterGold.detalhes
        .then((value) => setState(() => this.widget.list.add(value)));
    AlienHunterWalker.detalhes
        .then((value) => setState(() => this.widget.list.add(value)));
    AlienSmasher.detalhes
        .then((value) => setState(() => this.widget.list.add(value)));
    FleshEatingSlug.detalhes
        .then((value) => setState(() => this.widget.list.add(value)));
    AlienFlyingCommander.detalhes
        .then((value) => setState(() => this.widget.list.add(value)));
    AlienMiniUFO.detalhes
        .then((value) => setState(() => this.widget.list.add(value)));
    Jellyfish.detalhes
        .then((value) => setState(() => this.widget.list.add(value)));
  }

  @override
  Widget build(BuildContext context) {
    final logobsi = 'logo_bsi.png';
    final logouast = 'logo_uast.png';
    final desc =
        'Projeto direcionado a disciplina de Interface Homem-Máquina (IHM) ' +
            'para o curso de Bacharelado em Sistemas de Informação na Unidade Acadêmica de Serra Talhada (UAST) ' +
            'no período de 2020.1';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.grey,
        ),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                _buildTextSized(
                    text: 'Sobre a Aplicação',
                    maxLines: 2,
                    textAlin: TextAlign.center,
                    color: Color(0xFF8A8A8A),
                    fontSize: 20,
                    hSizedBox: 7),
                SizedBox(
                  height: 15,
                ),
                _buildTextSized(
                  text: desc,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildImageSized(image: logouast, maxHeight: 100.0),
                    _buildImageSized(image: logobsi, maxHeight: 70.0)
                  ],
                )
              ],
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            ),
          ),
          Card(
            elevation: 0,
            color: Colors.black26,
            child: ExpansionTile(
              onExpansionChanged: (b) async {
                if (b) {
                  this.widget.list.clear();
                  _loadAnimations();
                }
              },
              // backgroundColor: Colors.grey,
              initiallyExpanded: false,
              title: Text(
                'Sprites e Animações',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Créditos das imagens tiradas da internet',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              children: List.generate(widget.list.length,
                  (i) => CreditoWidget(element: widget.list[i])),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageSized({String image, double maxHeight = 70}) {
    return LimitedBox(
        maxHeight: maxHeight,
        child: Image.asset(
          'assets/images/' + image.toString(),
          color: null,
        ));
  }

  Widget _buildTextSized(
      {String text = '',
      double hSizedBox = 5,
      maxLines = 40,
      textAlin = TextAlign.justify,
      color = Colors.black54,
      double fontSize = 14.0,
      fontWeight = FontWeight.bold}) {
    return Column(children: <Widget>[
      Text(
        text,
        maxLines: maxLines,
        textAlign: textAlin,
        style: new TextStyle(
            color: color, fontSize: fontSize, fontWeight: fontWeight),
      ),
      SizedBox(
        height: hSizedBox,
      ),
    ]);
  }
}
