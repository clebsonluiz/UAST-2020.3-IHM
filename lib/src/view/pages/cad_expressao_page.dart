import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ihm_2020_3/src/controller/views/pages/cad_expressao_page_controller.dart';
import 'package:ihm_2020_3/src/view/components/menu_buttom_widget.dart';
import 'package:ihm_2020_3/src/view/components/simbolo_widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class CadExpressaoPage extends StatefulWidget {
  static const ROUTE = "/cad-expressao-page";

  @override
  State<StatefulWidget> createState() => CadExpressaoPageState();
}

class CadExpressaoPageState extends StateMVC<CadExpressaoPage> {
  CadExpressaoPageState() : super(CadExpressaoPageController());

  CadExpressaoPageController get con => this.controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white60,
        body: Stack(
          children: <Widget>[
            Transform.scale(
              scale: 1.1,
              child: con.imageCover,
            ),
            ListView(children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Center(
                  child: this.con.imageExpressoes,
                ),
              ),
              _buildGridOrList(<Widget>[
                con.img ?? con.image,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: ListView.builder(
                    padding: EdgeInsets.all(10),
                    itemCount: con.firstChildren.length,
                    itemBuilder: con.firstChildrenBuilder,
                    scrollDirection: Axis.horizontal,
                    controller: con.scrollController,
                  ),
                ),
              ], cor: null, height: 110),
              _textMin(
                  "*Tamanho maximo permitido para expressões é ${con.limiteExpressao}!"),
              LimitedBox(
                // width: 300,
                maxHeight: 220,

                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            // height: 200,
                            child: _buildGridOrList(
                              <Widget>[
                                con.image,
                                Container(color: Colors.black26),
                                GridView.count(
                                  crossAxisCount: 5,
                                  childAspectRatio: 1.0,
                                  padding: const EdgeInsets.all(20.0),
                                  mainAxisSpacing: 8.0,
                                  crossAxisSpacing: 8.0,
                                  children: List.generate(
                                    con.secondChildren1.length,
                                    con.secondChildren1Builder,
                                  ),
                                )
                              ],
                              height: 160,
                            ),
                          ),
                        ),
                        _textMin(
                            "**Use os simbolos acima para gerar uma nova expressão!"),
                        _textMin(
                            "Ou deseja selecionar uma expressão já existente? →"),
                      ],
                    ),
                    Column(children: <Widget>[
                      Center(
                          child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        // height: 200,
                        child: _buildGridOrList(
                          <Widget>[
                            con.image,
                            Container(color: Colors.black26),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 8),
                              child: RefreshIndicator(
                                
                                child: con.secondChildren2.isEmpty
                                    ? ListView(
                                        children: <Widget>[
                                          SizedBox(
                                            height: 100,
                                            child: ListTile(
                                              title: Icon(
                                                Icons.file_download,
                                                size: 50,
                                                color: Colors.black54,
                                              ),
                                              subtitle: Text(
                                                "Arraste para baixo para atualizar",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black54,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : ListView.builder(
                                        itemCount: con.secondChildren2.length,
                                        itemBuilder:
                                            con.secondChildren2Builder),
                                onRefresh: con.onRefresh,
                              ),
                            )
                          ],
                          height: 160,
                        ),
                      )),
                      _textMin("**Toque em um dos elementos para usa-lo!"),
                      _textMin("← Ou deseja criar sua própria expressão?"),
                    ]),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  _raisedButton("Prosseguir", con.confirmExpression,
                      padding: EdgeInsets.all(5),
                      icon: Icons.check_circle,
                      height: 70),
                  _raisedButton(
                      "Salvar para\nusar mais\ntarde?", con.uploadExpressao,
                      padding: EdgeInsets.all(5),
                      icon: Icons.file_upload,
                      height: 70),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              ),
              con.thirdChildren.isEmpty
                  ? Center()
                  : Column(
                      children: <Widget>[
                        _buildGridOrList(<Widget>[
                          con.img ?? con.image,
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: ListView.builder(
                              padding: EdgeInsets.all(10),
                              itemCount: con.thirdChildren.length,
                              itemBuilder: con.thirdChildrenBuilder,
                              scrollDirection: Axis.horizontal,
                            ),
                          ),
                        ], cor: null, height: 110),
                        _textMin(
                            "*Selecione um emoji atrelado às váriaveis (A, B, C)"),
                        _buildGridOrList(<Widget>[
                          con.img ?? con.image,
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: ListView.builder(
                              padding: EdgeInsets.all(10),
                              itemCount: con.fourthChildren.length,
                              itemBuilder: con.fourthChildrenBuilder,
                              scrollDirection: Axis.horizontal,
                            ),
                          ),
                        ], cor: null, height: 110),
                        _textMin("*Selecione quem será o (?) pelas váriaveis"),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    LimitedBox(
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              0.5,
                                      child: _buildGridOrList(<Widget>[
                                        con.img ?? con.image,
                                        ListView.builder(
                                          padding: EdgeInsets.all(10),
                                          itemCount: con.fifthChildren.length,
                                          itemBuilder: con.fifthChildrenBuilder,
                                          scrollDirection: Axis.horizontal,
                                          controller:
                                              con.scrollControllerCertos,
                                        ),
                                      ], cor: null),
                                    ),
                                    _textMin("*Alternativas corretas"),
                                    _floatingActionButton(
                                        "Adicionar alternativas corretas",
                                        con.cadCorreto,
                                        cor: Colors.green[800],
                                        heroTag:
                                            "${Random(1).nextDouble().toString()} + G"),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    LimitedBox(
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              0.5,
                                      child: _buildGridOrList(<Widget>[
                                        con.img ?? con.image,
                                        ListView.builder(
                                          padding: EdgeInsets.all(10),
                                          itemCount: con.sixthChildren.length,
                                          itemBuilder: con.sixthChildrenBuilder,
                                          scrollDirection: Axis.horizontal,
                                          controller:
                                              con.scrollControllerErrados,
                                        ),
                                      ], cor: null),
                                    ),
                                    _textMin("*Alternativas incorretas"),
                                    _floatingActionButton(
                                        "Adicionar novas alternativas incorretas",
                                        con.cadIncorreto,
                                        cor: Colors.red[800],
                                        heroTag:
                                            "${Random(10).nextDouble().toString()} + T"),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 100,
                          child: _raisedButton(
                              "Cadastrar Expressão", con.cadExpressao,
                              padding: EdgeInsets.symmetric(vertical: 20),
                              icon: Icons.archive),
                        )
                      ],
                    ),
              Container(
                height: 100,
                alignment: Alignment.center,
                child: MenuButtomWidget(
                    widget: SizedBox(
                      child: this.con.imageVoltar,
                      width: 180,
                    ),
                    onAction: this.con.navigatorPop,
                    splashColor: Colors.yellow[800]),
              ),
            ]),
          ],
        ));
  }

  Widget _textMin(String msg) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Center(
        child: Text(
          msg,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white70),
        ),
      ),
    );
  }

  Widget _floatingActionButton(String msg, Function onPressed,
      {EdgeInsets padding = const EdgeInsets.all(5),
      String heroTag,
      Color cor = Colors.black54,
      IconData icon = Icons.add_circle_outline}) {
    return Padding(
      padding: padding,
      child: FloatingActionButton(
        heroTag: heroTag,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(color: cor, width: 3),
        ),
        splashColor: cor,
        tooltip: msg,
        onPressed: onPressed,
        mini: true,
        child: Icon(
          icon,
          color: cor,
        ),
        backgroundColor: Colors.white70,
        elevation: 1,
      ),
    );
  }

  Widget _raisedButton(String msg, Function onPressed,
      {EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 30),
      IconData icon = Icons.touch_app,
      Color borderColor = Colors.black87,
      double height,
      double width}) {
    Color _secondary = borderColor.opacity == 1.0
        ? (borderColor as MaterialColor)[900]
        : Colors.black;

    return Padding(
      padding: padding,
      child: SizedBox(
        height: height,
        width: width,
        child: RaisedButton.icon(
          splashColor: borderColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: BorderSide(color: borderColor, width: 3),
          ),
          elevation: 1,
          onPressed: onPressed,
          icon: Icon(icon, size: 30, color: _secondary),
          label: Text(
            msg,
            softWrap: true,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18, color: _secondary),
            maxLines: 3,
          ),
        ),
      ),
    );
  }


 

  Widget _buildGridOrList(List<Widget> _children,
      {double height = 80, Color cor = Colors.black26}) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: Container(
          color: cor,
          height: height,
          // width: Navigator.of(context).context.size.width,
          // padding: EdgeInsets.all(5),
          // margin: EdgeInsets.all(5),
          child: Stack(children: _children),
        ),
      ),
    );
  }

  Widget generateWithGesture(SimboloWidget simboloWidget, {Function onTap}) {
    final val = GestureDetector(
      child: SizedBox(
        height: 50,
        width: 50,
        child: Center(
            child: Stack(
          children: <Widget>[
            simboloWidget,
          ],
        )),
      ),
      onTap: onTap,
    );
    return Center(child: val);
  }
}
