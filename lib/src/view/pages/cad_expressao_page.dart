import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:ihm_2020_3/src/model/database/models/cadeia.dart';
import 'package:ihm_2020_3/src/view/components/dialog_emoji_page.dart';
import 'package:ihm_2020_3/src/view/components/simbolo_widget.dart';

class CadExpressaoPage extends StatefulWidget {
  static const ROUTE = "/cad-expressao-page";

  @override
  State<StatefulWidget> createState() => _CadExpressaoPageState();
}

class _CadExpressaoPageState extends State<CadExpressaoPage> {
  final _limite = 10;

  final _scrollController = ScrollController();

  final _strings = <String>[];

  var _firstChildren = <Widget>[];
  var _secondChildren = <Widget>[];
  var _thirdChildren = <Widget>[];
  var _fourthChildren = <Widget>[];

  @override
  void initState() {
    _secondChildren
      ..clear()
      ..addAll([
        SimboloWidget(tipo: Cadeia.OP_NEGACAO, simbolo: "~"),
        SimboloWidget(tipo: Cadeia.OP_CONJUNCAO, simbolo: "^"),
        SimboloWidget(tipo: Cadeia.OP_DISJUNCAO, simbolo: "v"),
        SimboloWidget(tipo: Cadeia.OP_CONDICIONAL, simbolo: "→"),
        SimboloWidget(tipo: Cadeia.OP_BICONDICIONAL, simbolo: "↔"),
        SimboloWidget(tipo: Cadeia.OP_VARIAVEL_A, simbolo: "A"),
        SimboloWidget(tipo: Cadeia.OP_VARIAVEL_B, simbolo: "B"),
        SimboloWidget(tipo: Cadeia.OP_VARIAVEL_C, simbolo: "C"),
        SimboloWidget(
            tipo: Cadeia.OP_PARENTESE_E, simbolo: Cadeia.OP_PARENTESE_E),
        SimboloWidget(
            tipo: Cadeia.OP_PARENTESE_D, simbolo: Cadeia.OP_PARENTESE_D),
      ]);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white60,
        body: Stack(
          children: <Widget>[
            // _buildImageSized(image: "objetivo_fundo_2.png", fit: BoxFit.cover),
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
              Padding(
                padding: EdgeInsets.all(10),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Container(
                    color: Colors.black26,
                    height: 80,
                    // padding: EdgeInsets.all(5),
                    // margin: EdgeInsets.all(5),
                    child: Stack(
                      children: <Widget>[
                        // _buildImageSized(image: "objetivo_fundo_2.png", fit: BoxFit.fill),
                        ListView.builder(
                          padding: EdgeInsets.all(10),
                          itemCount: _firstChildren.length,
                          itemBuilder: (context, i) =>
                              Center(child: _firstChildren[i]),
                          scrollDirection: Axis.horizontal,
                          controller: _scrollController,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              _textMin("*Tamanho maximo permitido para expressões é $_limite!"),
              Padding(
                padding: EdgeInsets.all(10),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Container(
                    color: Colors.black26,
                    height: 160,
                    // padding: EdgeInsets.all(5),
                    // margin: EdgeInsets.all(5),
                    child: Stack(
                      children: <Widget>[
                        _buildImageSized(image: "objetivo_fundo_2.png"),
                        GridView.count(
                          crossAxisCount: 5,
                          childAspectRatio: 1.0,
                          padding: const EdgeInsets.all(20.0),
                          mainAxisSpacing: 8.0,
                          crossAxisSpacing: 8.0,
                          children: List.generate(
                            _secondChildren.length,
                            (i) => _generate(_secondChildren[i]),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              _textMin("**Use os simbolos acima para gerar uma expressão!"),
              _raisedButton("Confirmar Expressão", _confirmExpression),
              this._thirdChildren.isEmpty
                  ? Center()
                  : Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            child: Container(
                              color: Colors.black26,
                              height: 80,
                              // padding: EdgeInsets.all(5),
                              // margin: EdgeInsets.all(5),
                              child: Stack(
                                children: <Widget>[
                                  // _buildImageSized(image: "objetivo_fundo_1.png", fit: BoxFit.none),
                                  ListView.builder(
                                    padding: EdgeInsets.all(10),
                                    itemCount: _thirdChildren.length,
                                    itemBuilder: (context, i) => _generate(
                                        _thirdChildren[i], onTap: () async {
                                      final _child = _thirdChildren[i];
                                      // final _i = i;

                                      final sym = _child as SimboloWidget;
                                      if (sym.tipo == Cadeia.OP_VARIAVEL_A ||
                                          sym.tipo == Cadeia.OP_VARIAVEL_B ||
                                          sym.tipo == Cadeia.OP_VARIAVEL_C) {
                                        try {
                                          final emoji =
                                              await DialogEmojiPage.call(
                                                  context);
                                          _validate(emoji, _child);
                                        } catch (e) {}
                                        print("Variavel");
                                      } else {
                                        print("Operador");
                                      }
                                    }),
                                    scrollDirection: Axis.horizontal,
                                    // controller: _scrollController,
                                    // children: _firstChildren,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        _textMin(
                            "*Selecione um emoji atrelado às váriaveis (A, B, C)"),
                        _raisedButton("Cadastrar Expressão", () {}),
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

  Widget _raisedButton(String msg, Function onPressed) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        child: RaisedButton.icon(
          // splashColor: Colors.orange,
          elevation: 1,
          onPressed: onPressed,
          icon: const Icon(Icons.touch_app, size: 30),
          label: Text(msg,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        ),
      ),
    );
  }

  Widget _buildImageSized(
      {String image,
      BoxFit fit = BoxFit.fill,
      double maxHeight = double.infinity,
      double maxWidth = double.infinity}) {
    return Image.asset('assets/images/' + image.toString(),
        color: null, fit: fit, width: maxWidth, height: maxHeight);
  }

  Widget _generate(SimboloWidget simboloWidget, {Function onTap}) {
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
      onTap: onTap ?? () => simboloWidget.activate? addDimissible(simboloWidget) : (){},
    );
    return Center(child: val);
  }

  void addDimissible(SimboloWidget simboloWidget) {
    final _index = _firstChildren.length;

    if (_index == _limite) {
      _showMyDialog('Limite máximo permitido é de $_limite elementos!!');
    } else {
      final _this = SimboloWidget(
          tipo: simboloWidget.tipo,
          simbolo: simboloWidget.simbolo,
          isDimissible: true,
          confirmDismiss: (_) async {
            return await Future.value(
                _index == _firstChildren.indexOf(_firstChildren.last));
          },
          onDismissed: (_) => removeDimissible());

      setState(() {
        _thirdChildren = List.from(_thirdChildren)..clear();
        _firstChildren = List.from(_firstChildren)..add(_this);

        // final indexOf = _secondChildren.indexOf(simboloWidget);
        // _secondChildren[indexOf] = SimboloWidget(activate: false,);
        
        // _secondChildren = List.from(_secondChildren);

        _scrollToEnd();
      });
    }
  }

  void removeDimissible() {
    setState(() {
      _thirdChildren = List.from(_thirdChildren)..clear();
      _firstChildren = List.from(_firstChildren)..removeLast();
      _scrollToEnd();
    });
  }

  void _confirmExpression() {
    _thirdChildren.clear();
    _firstChildren.forEach((child) {
      final sym = child as SimboloWidget;

      _thirdChildren.add(SimboloWidget(
        tipo: sym.tipo,
        simbolo: sym.simbolo,
      ));
    });
    setState(() {
      // final list = <Widget>[];

      _thirdChildren = List.from(_thirdChildren);
    });
  }

  void _scrollToEnd() async {
    if (!_scrollController.hasClients) {
      return;
    }

    setState(() {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 10),
          curve: Curves.easeOut,
        );
      });
    });
  }

  Future<void> _showDialog(Widget child, {bool dimissible = false}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: dimissible, // user must tap button!
      builder: (BuildContext context) => child,
    );
  }

  // Future<void> _showExpressionDialog() async {
  //   _strings..clear();
  //   return _showDialog(
  //     Center(),
  //   );
  // }

  void _validate(String emoji, SimboloWidget simboloWidget) {
    final index = _thirdChildren.indexOf(simboloWidget);

    if (emoji != null &&
        (_thirdChildren[index] as SimboloWidget).simbolo != emoji) {
      final bool exists = !_thirdChildren.every((e) {
        final _child = (e as SimboloWidget);

        return _child != simboloWidget && _child.tipo != simboloWidget.tipo
            ? _child.simbolo != emoji
            : true;
      });

      if (exists) {
        _showMyDialog(
            'Todos os simbolos devem ser diferentes para evitar ambiguidades');
      } else {
        setState(() {
          final _indexes = <int>[];
          _thirdChildren.forEach((e) {
            if ((e as SimboloWidget).tipo == simboloWidget.tipo)
              _indexes.add(_thirdChildren.indexOf(e));
          });

          // final index = _thirdChildren.indexOf(simboloWidget);
          _indexes.forEach((i) => _thirdChildren[i] = SimboloWidget(
                tipo: simboloWidget.tipo,
                simbolo: emoji,
              ));
        });
      }
    }
  }

  Future<void> _showMyDialog(String msg) async {
    return _showDialog(
      AlertDialog(
        title: Text('Oops!',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.black54)),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(msg,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black54)),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
