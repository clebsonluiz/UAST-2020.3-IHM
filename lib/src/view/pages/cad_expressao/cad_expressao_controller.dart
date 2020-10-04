import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:ihm_2020_3/src/model/database/models/cadeia.dart';
import 'package:ihm_2020_3/src/model/utils/game_model_constants.dart';
import 'package:ihm_2020_3/src/view/components/dialog_emoji_page.dart';
import 'package:ihm_2020_3/src/view/components/simbolo_widget.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'cad_expressao_page.dart';

class CadExpressaoController extends ControllerMVC {
  @override
  CadExpressaoPageState get stateMVC => super.stateMVC;

  final _limiteExpressao = 10;

  get limiteExpressao => _limiteExpressao;

  final _scrollController = ScrollController();
  final _scrollControllerCertos = ScrollController();
  final _scrollControllerErrados = ScrollController();

  get scrollController => this._scrollController;
  get scrollControllerCertos => this._scrollControllerCertos;
  get scrollControllerErrados => this._scrollControllerErrados;

  var _firstChildren = <Widget>[];
  var _secondChildren = <Widget>[];
  var _thirdChildren = <Widget>[];
  var _fourthChildren = <Widget>[];
  var _fifthChildren = <Widget>[];
  var _sixthChildren = <Widget>[];
  var _seventhChildren = <Widget>[];

  int _indexDesconhecido = -1;

  get firstChildren => _firstChildren; // Expressão
  get secondChildren => _secondChildren; // Grid
  get thirdChildren => _thirdChildren; // Expressão para emoji
  get fourthChildren => _fourthChildren; // Seleção de interrogação
  get fifthChildren => _fifthChildren; // Alternativas dos Certos
  get sixthChildren => _sixthChildren; // Alternativas dos Errados
  get seventhChildren => _seventhChildren;

  Widget firstChildrenBuilder(BuildContext context, int i) =>
      Center(child: firstChildren[i]);

  Widget secondChildrenBuilder(int i) {
    final _simboloWidget = this.secondChildren[i];
    return this.stateMVC.generateWithGesture(_simboloWidget,
        onTap: () =>
            _simboloWidget.activate ? addDimissible(_simboloWidget) : () {});
  }

  Widget thirdChildrenBuilder(BuildContext context, int i) {
    final _simboloWidget = this.thirdChildren[i];
    return this.stateMVC.generateWithGesture(_simboloWidget, onTap: () async {
      final _child = _simboloWidget;
      // final _i = i;

      final sym = _child as SimboloWidget;
      if (sym.tipo == Cadeia.OP_VARIAVEL_A ||
          sym.tipo == Cadeia.OP_VARIAVEL_B ||
          sym.tipo == Cadeia.OP_VARIAVEL_C) {
        try {
          final emoji = await DialogEmojiPage.call(this.stateMVC.context);
          validate(emoji, _child);
        } catch (e) {}
        print("Variavel");
      } else {
        print("Operador");
      }
    });
  }

  Widget fourthChildrenBuilder(BuildContext context, int i) {
    final _simboloWidget = _indexDesconhecido != i
        ? this.fourthChildren[i]
        : SimboloWidget(
            tipo: Cadeia.OP_INTERROGACAO,
            simbolo: Cadeia.OP_INTERROGACAO,
          );

    return this.stateMVC.generateWithGesture(_simboloWidget, onTap: () async {
      final _child = _simboloWidget;
      // final _i = i;

      final sym = _child as SimboloWidget;
      if (sym.tipo == Cadeia.OP_VARIAVEL_A ||
          sym.tipo == Cadeia.OP_VARIAVEL_B ||
          sym.tipo == Cadeia.OP_VARIAVEL_C) {
        setState(() {
          _indexDesconhecido = i;
          _fifthChildren = []..add(this._fourthChildren[_indexDesconhecido]);
        });

        print("Variavel");
      } else {
        print("Operador");
      }
    });
  }

  Widget fifthChildrenBuilder(BuildContext context, int i) {
    final _simboloWidget =
        i != 0 || !this._fourthChildren.contains(this.fifthChildren[i])
            ? SimboloWidget(
                isDimissible: true,
                tipo: this.fifthChildren[i].tipo,
                simbolo: this.fifthChildren[i].simbolo,
                confirmDismiss: (d) => Future.value(true),
                onDismissed: (d) {
                  setState(() {
                    this._fifthChildren = List.from(fifthChildren)..removeAt(i);
                  });
                },
              )
            : this.fifthChildren[i];
    return Center(child: _simboloWidget);
  }

  Widget sixthChildrenBuilder(BuildContext context, int i) {
    final _simboloWidget = SimboloWidget(
      isDimissible: true,
      tipo: this.sixthChildren[i].tipo,
      simbolo: this.sixthChildren[i].simbolo,
      confirmDismiss: (d) => Future.value(true),
      onDismissed: (d) {
        setState(() {
          this._sixthChildren = List.from(sixthChildren)..removeAt(i);
        });
      },
    );

    return Center(child: _simboloWidget);
  }

  Widget seventhChildrenBuilder(BuildContext context, int i) {}

  Widget _buildImageSized(
      {String image,
      BoxFit fit = BoxFit.fill,
      double maxHeight = double.infinity,
      double maxWidth = double.infinity}) {
    return Image.asset('assets/images/' + image.toString(),
        color: null, fit: fit, width: maxWidth, height: maxHeight);
  }

  Widget get image =>
      _buildImageSized(image: AnotherConsts.BG_OBJETIVE_2, fit: BoxFit.fill);
  Widget get imageCover =>
      _buildImageSized(image: AnotherConsts.BG_OBJETIVE_2, fit: BoxFit.cover);

  void confirmExpression() {
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
      _indexDesconhecido = -1;
      _thirdChildren = List.from(_thirdChildren);
      _fourthChildren = List.from(_thirdChildren);
      _fifthChildren = [];
      _sixthChildren = [];
    });
  }

  void uploadExpressao() {}

  Future<void> cadCorreto() async {
    final emoji = await DialogEmojiPage.call(this.stateMVC.context);

    final existsInterrogacao = _exists(fourthChildren, emoji);
    final existsCertos = _exists(fifthChildren, emoji);
    final existsErros = _exists(sixthChildren, emoji);

    if (emoji == null) return;

    if (existsInterrogacao || existsCertos || existsErros) {
      showMyDialog(
          'Não se pode adicionar emojis já existentes nesse contexto, evite ambiguidades e repetições!!');
    } else {
      setState(() {
        this._fifthChildren = List.of(fifthChildren)
          ..add(SimboloWidget(
            tipo: Cadeia.OP_INTERROGACAO,
            simbolo: emoji,
          ));
      });
    }
  }

  Future<void> cadIncorreto() async {
    final emoji = await DialogEmojiPage.call(this.stateMVC.context);
    if (emoji == null) return;

    final existsCertos = _exists(fifthChildren, emoji);

    if (existsCertos) {
      showMyDialog(
          'Não se pode adicionar emojis já existentes nos campos de Corretos, evite ambiguidades!!');
    } else {
      setState(() {
        this._sixthChildren = List.of(sixthChildren)
          ..add(SimboloWidget(
            tipo: Cadeia.OP_INTERROGACAO,
            simbolo: emoji,
          ));
      });
    }
  }

  void cadExpressao() {}

  void addDimissible(SimboloWidget simboloWidget) {
    final _index = _firstChildren.length;

    if (_index == _limiteExpressao) {
      showMyDialog(
          'Limite máximo permitido é de $_limiteExpressao elementos!!');
    } else {
      final _this = SimboloWidget(
          tipo: simboloWidget.tipo,
          simbolo: simboloWidget.simbolo,
          isDimissible: true,
          confirmDismiss: (_) async {
            return await Future.value(
                _index == _firstChildren.indexOf(_firstChildren.last));
          },
          onDismissed: (_) => this.removeDimissibleOfFirstScroll());

      setState(() {
        _thirdChildren = List.from(_thirdChildren)..clear();
        _firstChildren = List.from(_firstChildren)..add(_this);
      });
      this.scrollFirstControllerToEnd();

      // final indexOf = _secondChildren.indexOf(simboloWidget);
      // _secondChildren[indexOf] = SimboloWidget(activate: false,);

      // _secondChildren = List.from(_secondChildren);

    }
  }

  void removeDimissibleOfFirstScroll() {
    setState(() {
      _thirdChildren = List.from(_thirdChildren)..clear();
      _firstChildren = List.from(_firstChildren)..removeLast();
    });
    this.scrollFirstControllerToEnd();
  }

  bool _exists(List<Widget> children, String emoji) {
    return !children.every((e) {
      final _child = (e as SimboloWidget);
      return _child.simbolo != emoji;
    });
  }

  void validate(String emoji, SimboloWidget simboloWidget) {
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
        showMyDialog(
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

          _fourthChildren = List.of(_thirdChildren);
        });
      }
    }
  }

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

  void scrollFirstControllerToEnd() => this._scrollToEnd(this.scrollController);

  void _scrollToEnd(ScrollController _scrollCon) async {
    if (!_scrollCon.hasClients) {
      return;
    }

    this.setState(() {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _scrollCon.animateTo(
          _scrollCon.position.maxScrollExtent,
          duration: const Duration(milliseconds: 10),
          curve: Curves.easeOut,
        );
      });
    });
  }

  Future<void> _showDialog(Widget child, {bool dimissible = false}) async {
    return showDialog<void>(
      context: this.stateMVC.context,
      barrierDismissible: dimissible, // user must tap button!
      builder: (BuildContext context) => child,
    );
  }

  Future<void> showMyDialog(String msg) async {
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
            onPressed: navigatorPop,
          ),
        ],
      ),
    );
  }

  navigatorPop() => Navigator.of(this.stateMVC.context).pop();
}
