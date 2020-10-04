import 'package:flutter/material.dart';
import 'package:ihm_2020_3/src/view/components/simbolo_widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'cad_expressao_controller.dart';

class CadExpressaoPage extends StatefulWidget {
  static const ROUTE = "/cad-expressao-page";

  @override
  State<StatefulWidget> createState() => CadExpressaoPageState();
}

class CadExpressaoPageState extends StateMVC<CadExpressaoPage> {
  CadExpressaoPageState() : super(CadExpressaoController());

  CadExpressaoController get con => this.controller;

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
            // con.imageCover,
            ListView(children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Center(
                  child: Text(
                    "NOVA EXPRESSÃO",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                        color: Colors.black54),
                  ),
                ),
              ),
              _buildGridOrList(
                <Widget>[
                  // con.image,
                  ListView.builder(
                    padding: EdgeInsets.all(10),
                    itemCount: con.firstChildren.length,
                    itemBuilder: con.firstChildrenBuilder,
                    scrollDirection: Axis.horizontal,
                    controller: con.scrollController,
                  ),
                ],
              ),
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
                                GridView.count(
                                  crossAxisCount: 5,
                                  childAspectRatio: 1.0,
                                  padding: const EdgeInsets.all(20.0),
                                  mainAxisSpacing: 8.0,
                                  crossAxisSpacing: 8.0,
                                  children: List.generate(
                                    con.secondChildren.length,
                                    con.secondChildrenBuilder,
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
                    // SizedBox(
                    //   width: MediaQuery.of(context).size.width,
                    //   height: 200,
                    //   child: Center(),
                    // ),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  _raisedButton("Confirmar", con.confirmExpression,
                      padding: EdgeInsets.all(5)),
                  _raisedButton("Cadastrar?", con.uploadExpressao,
                      padding: EdgeInsets.all(5), icon: Icons.cloud_upload),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              ),
              con.thirdChildren.isEmpty
                  ? Center()
                  : Column(
                      children: <Widget>[
                        _buildGridOrList(
                          <Widget>[
                            // con.image,
                            ListView.builder(
                              padding: EdgeInsets.all(10),
                              itemCount: con.thirdChildren.length,
                              itemBuilder: con.thirdChildrenBuilder,
                              scrollDirection: Axis.horizontal,
                            ),
                          ],
                        ),
                        _textMin(
                            "*Selecione um emoji atrelado às váriaveis (A, B, C)"),

                        _buildGridOrList(
                          <Widget>[
                            // con.image,
                            ListView.builder(
                              padding: EdgeInsets.all(10),
                              itemCount: con.fourthChildren.length,
                              itemBuilder: con.fourthChildrenBuilder,
                              scrollDirection: Axis.horizontal,
                            ),
                          ],
                        ),
                        _textMin(
                            "*Selecione quem será o (?) pelas"),
                        
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
                                      child: _buildGridOrList(
                                        <Widget>[
                                          // con.image,
                                          ListView.builder(
                                            padding: EdgeInsets.all(10),
                                            itemCount:
                                                con.fifthChildren.length,
                                            itemBuilder:
                                                con.fifthChildrenBuilder,
                                            scrollDirection: Axis.horizontal,
                                            controller:
                                                con.scrollControllerCertos,
                                          ),
                                        ],
                                      ),
                                    ),
                                    _textMin("*Alternativas corretas"),
                                    _floatingActionButton(
                                        "Adicionar alternativas corretas",
                                        con.cadCorreto,
                                        cor: Colors.green[800]),
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    LimitedBox(
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              0.5,
                                      child: _buildGridOrList(
                                        <Widget>[
                                          // con.image,
                                          ListView.builder(
                                            padding: EdgeInsets.all(10),
                                            itemCount: con.sixthChildren.length,
                                            itemBuilder:
                                                con.sixthChildrenBuilder,
                                            scrollDirection: Axis.horizontal,
                                            controller:
                                                con.scrollControllerErrados,
                                          ),
                                        ],
                                      ),
                                    ),
                                    _textMin("*Alternativas incorretas"),
                                    _floatingActionButton(
                                        "Adicionar novas alternativas incorretas",
                                        con.cadIncorreto,
                                        cor: Colors.red[800]),
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
              fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black54),
        ),
      ),
    );
  }

  Widget _floatingActionButton(String msg, Function onPressed,
      {EdgeInsets padding = const EdgeInsets.all(5),
      Color cor = Colors.black54,
      IconData icon = Icons.add_circle_outline}) {
    return Padding(
      padding: padding,
      child: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(color: cor),
        ),
        splashColor: cor,
        tooltip: msg,
        onPressed: onPressed,
        mini: true,
        child: Icon(
          icon,
          color: Colors.black,
        ),
        backgroundColor: Colors.white70,
        elevation: 1,
      ),
    );
  }

  Widget _raisedButton(String msg, Function onPressed,
      {EdgeInsets padding = const EdgeInsets.symmetric(horizontal: 30),
      IconData icon = Icons.touch_app}) {
    return Padding(
      padding: padding,
      child: RaisedButton.icon(
        splashColor: Colors.black54,
        // splashColor: Colors.orange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(color: Colors.black54),
        ),
        elevation: 1,
        onPressed: onPressed,
        icon: Icon(icon, size: 30),
        label: Text(
          msg,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          maxLines: 2,
        ),
      ),
    );
  }

  //   Widget _buildHorizontalList({int itemCount, Widget Function(BuildContext, int) itemBuilder,
  //     ScrollController scrollController}) {
  //   return _buildGridOrList(
  //     <Widget>[
  //       // _buildImageSized(image: "objetivo_fundo_2.png", fit: BoxFit.fill),
  //       ListView.builder(
  //         padding: EdgeInsets.all(10),
  //         itemCount: _thirdChildren.length,
  //         itemBuilder: itemBuilder,
  //         scrollDirection: Axis.horizontal,
  //         controller: scrollController,
  //       ),
  //     ],
  //   );
  // }

  Widget _buildGridOrList(List<Widget> _children, {double height = 80}) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: Container(
          color: Colors.black26,
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
