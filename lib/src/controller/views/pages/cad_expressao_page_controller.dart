import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:ihm_2020_3/src/model/database/models/expressao.dart';
import 'package:ihm_2020_3/src/model/database/models/expressao_emoji.dart';
import 'package:ihm_2020_3/src/model/utils/const_simbolos.dart';
import 'package:ihm_2020_3/src/model/utils/game_model_constants.dart';
import 'package:ihm_2020_3/src/view/components/dialog_emoji_page.dart';
import 'package:ihm_2020_3/src/view/components/expressao_widget.dart';
import 'package:ihm_2020_3/src/view/components/simbolo_widget.dart';
import 'package:ihm_2020_3/src/view/pages/cad_expressao_page.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class CadExpressaoPageController extends ControllerMVC {
  CadExpressaoPageController() {
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
  Widget get imageSair =>
      _buildImageSized(image: AnotherConsts.MENU_ITEM_4, color: Colors.yellow, maxHeight: 25);

  Widget _widget1;
  Widget get img => _widget1;

  Widget get imageExpressoes => _buildImageSized(
      image: AnotherConsts.MENU_ITEM_11,
      color: Colors.deepPurpleAccent,
      maxHeight: 30);

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
  var _secondChildren1 = <Widget>[];
  var _secondChildren2 = <Widget>[];
  var _thirdChildren = <Widget>[];
  var _fourthChildren = <Widget>[];
  var _fifthChildren = <Widget>[];
  var _sixthChildren = <Widget>[];

  int _indexDesconhecido = -1;

  get firstChildren => _firstChildren; // Expressão
  get secondChildren1 => _secondChildren1; // Grid
  get secondChildren2 => _secondChildren2; // Expressões da base
  get thirdChildren => _thirdChildren; // Expressão para emoji
  get fourthChildren => _fourthChildren; // Seleção de interrogação
  get fifthChildren => _fifthChildren; // Alternativas dos Certos
  get sixthChildren => _sixthChildren; // Alternativas dos Errados

  final simboloNOTController = SimboloWidgetController();
  final simboloANDController = SimboloWidgetController();
  final simboloAController = SimboloWidgetController();
  final simboloBController = SimboloWidgetController();
  final simboloCController = SimboloWidgetController();
  final simboloCONJController = SimboloWidgetController();
  final simboloDISController = SimboloWidgetController();
  final simboloCONController = SimboloWidgetController();
  final simboloBICONController = SimboloWidgetController();
  final simboloParDController = SimboloWidgetController();
  final simboloParEController = SimboloWidgetController();

  bool _activateNOT = true;
  bool _activateOP = false;
  bool _activateParE = true;
  bool _activateParD = false;
  bool _activateVAR = true;

  void _updateExpressionButtons(
      {bool not = false,
      bool op = false,
      bool parentesisE = false,
      bool parentesisD = false,
      bool variables = false}) {
    setState(() {
      _activateNOT = not;
      _activateOP = op;
      _activateParE = parentesisE;
      _activateParD = parentesisD;
      _activateVAR = variables;
    });
    simboloNOTController.activate = _activateNOT;
    simboloANDController.activate = _activateOP;
    simboloAController.activate = _activateVAR;
    simboloBController.activate = _activateVAR;
    simboloCController.activate = _activateVAR;
    simboloCONJController.activate = _activateOP;
    simboloDISController.activate = _activateOP;
    simboloCONController.activate = _activateOP;
    simboloBICONController.activate = _activateOP;
    simboloParDController.activate = _activateParD;
    simboloParEController.activate = _activateParE;
  }

  void _checkActivateButtons() {
    if (this.elementAtRight == null) {
      this._updateExpressionButtons(
          not: true, parentesisE: true, variables: true);
    } else {
      final _op = this.elementAtRight.tipo;

      if (_op == ConstSimbolos.OP_NEGACAO ||
          _op == ConstSimbolos.OP_PARENTESE_E) {
        this._updateExpressionButtons(
            not: true, parentesisE: true, variables: true);
      } else if (_op == ConstSimbolos.OP_VARIAVEL_A ||
          _op == ConstSimbolos.OP_VARIAVEL_B ||
          _op == ConstSimbolos.OP_VARIAVEL_C ||
          _op == ConstSimbolos.OP_PARENTESE_D) {
        this._updateExpressionButtons(op: true, parentesisD: true);
      } else {
        this._updateExpressionButtons(
            not: true, parentesisE: true, variables: true);
      }
    }
  }

  SimboloWidget get elementAtRight {
    try {
      return this._firstChildren.last as SimboloWidget;
    } catch (e) {
      return null;
    }
  }

  Widget firstChildrenBuilder(BuildContext context, int i) =>
      Center(child: firstChildren[i]);

  Widget secondChildren1Builder(int i) {
    final _simboloWidget = this.secondChildren1[i];
    return this.stateMVC.generateWithGesture(_simboloWidget,
        onTap: () => _simboloWidget.controller.activate
            ? addDimissible(_simboloWidget)
            : () {});
  }

  Widget secondChildren2Builder(BuildContext context, int i) {
    return this._secondChildren2[i];
  }

  Widget thirdChildrenBuilder(BuildContext context, int i) {
    final _simboloWidget = this.thirdChildren[i];
    return this.stateMVC.generateWithGesture(_simboloWidget, onTap: () async {
      final _child = _simboloWidget;

      final sym = _child as SimboloWidget;
      if (sym.tipo == ConstSimbolos.OP_VARIAVEL_A ||
          sym.tipo == ConstSimbolos.OP_VARIAVEL_B ||
          sym.tipo == ConstSimbolos.OP_VARIAVEL_C) {
        try {
          final emoji = await DialogEmojiPage.call(this.stateMVC.context);
          validate(emoji, _child);
        } catch (e) {}
      }
    });
  }

  Widget fourthChildrenBuilder(BuildContext context, int i) {
    final _simboloWidget = _indexDesconhecido != i
        ? this.fourthChildren[i]
        : SimboloWidget(
            tipo: ConstSimbolos.OP_INTERROGACAO,
            simbolo: ConstSimbolos.OP_INTERROGACAO,
          );

    return this.stateMVC.generateWithGesture(_simboloWidget, onTap: () async {
      final _child = _simboloWidget;
      // final _i = i;

      final sym = _child as SimboloWidget;
      if (sym.tipo == ConstSimbolos.OP_VARIAVEL_A ||
          sym.tipo == ConstSimbolos.OP_VARIAVEL_B ||
          sym.tipo == ConstSimbolos.OP_VARIAVEL_C) {
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

  Widget _buildImageSized(
      {String image,
      BoxFit fit = BoxFit.fill,
      double maxHeight = double.infinity,
      double maxWidth = double.infinity,
      Color color}) {
    return Image.asset(
      'assets/images/' + image.toString(),
      color: color,
      fit: fit,
      width: maxWidth,
      height: maxHeight,
      colorBlendMode: BlendMode.modulate,
    );
  }

  Widget get image =>
      _buildImageSized(image: AnotherConsts.BG_OBJETIVE_2, fit: BoxFit.fill);
  Widget get imageCover => _buildImageSized(
      image: AnotherConsts.BG_OBJETIVE_2,
      fit: BoxFit.cover,
      color: Colors.grey[700]);

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
      _checkActivateButtons();
      this.scrollFirstControllerToEnd();
    }
  }

  void removeDimissibleOfFirstScroll() {
    setState(() {
      _thirdChildren = List.from(_thirdChildren)..clear();
      _firstChildren = List.from(_firstChildren)..removeLast();
    });
    _checkActivateButtons();
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

          _indexes.forEach((i) => _thirdChildren[i] = SimboloWidget(
                tipo: simboloWidget.tipo,
                simbolo: emoji,
              ));

          _fourthChildren = List.of(_thirdChildren);
          if (_indexDesconhecido != -1)
            _fifthChildren = []..add(this._fourthChildren[_indexDesconhecido]);
        });
      }
    }
  }

  @override
  void initState() {
    _secondChildren1 = _revalidateButtons();
    super.initState();
  }

  List<Widget> _revalidateButtons() {
    return [
      SimboloWidget(
        tipo: ConstSimbolos.OP_NEGACAO,
        simbolo: "~",
        activate: _activateNOT,
        controller: simboloNOTController,
      ),
      SimboloWidget(
        tipo: ConstSimbolos.OP_CONJUNCAO,
        simbolo: "∧",
        activate: _activateOP,
        controller: simboloCONJController,
      ),
      SimboloWidget(
        tipo: ConstSimbolos.OP_DISJUNCAO,
        simbolo: "v",
        activate: _activateOP,
        controller: simboloDISController,
      ),
      SimboloWidget(
        tipo: ConstSimbolos.OP_CONDICIONAL,
        simbolo: "→",
        activate: _activateOP,
        controller: simboloCONController,
      ),
      SimboloWidget(
        tipo: ConstSimbolos.OP_BICONDICIONAL,
        simbolo: "↔",
        activate: _activateOP,
        controller: simboloBICONController,
      ),
      SimboloWidget(
        tipo: ConstSimbolos.OP_VARIAVEL_A,
        simbolo: "A",
        activate: _activateVAR,
        controller: simboloAController,
      ),
      SimboloWidget(
        tipo: ConstSimbolos.OP_VARIAVEL_B,
        simbolo: "B",
        activate: _activateVAR,
        controller: simboloBController,
      ),
      SimboloWidget(
        tipo: ConstSimbolos.OP_VARIAVEL_C,
        simbolo: "C",
        activate: _activateVAR,
        controller: simboloCController,
      ),
      SimboloWidget(
        tipo: ConstSimbolos.OP_PARENTESE_E,
        simbolo: ConstSimbolos.OP_PARENTESE_E,
        activate: _activateParE,
        controller: simboloParEController,
      ),
      SimboloWidget(
        tipo: ConstSimbolos.OP_PARENTESE_D,
        simbolo: ConstSimbolos.OP_PARENTESE_D,
        activate: _activateParD,
        controller: simboloParDController,
      ),
    ];
  }

  Future<void> onRefresh() async {
    Expressao.getAll().then((value) {
      final _list = <Widget>[];

      if (value.isEmpty) {
        // print("Vazio");
      }

      value.addAll([
        Expressao(expressao: ";A;CON;(;B;AND;C;)"),
        Expressao(expressao: ";A;CON;(;B;OR;C;)"),
        Expressao(expressao: ";A;BICON;(;B;AND;C;)"),
        Expressao(expressao: ";A;BICON;(;B;OR;C;)"),
        Expressao(expressao: ";A;CON;(;NOT;B;OR;B;)"),
        Expressao(expressao: ";A;CON;NOT;B"),
      ]);

      value.forEach((e) {
        final _splited = e.expressao.split(";")..removeWhere((e) => e.isEmpty);

        final _cadeia = <Widget>[];

        String str = "";

        _splited.forEach((string) {
          String _tipo;
          String el;
          switch (string) {
            case ConstSimbolos.OP_PARENTESE_E:
              el = "(";
              _tipo = ConstSimbolos.OP_PARENTESE_E;
              break;
            case ConstSimbolos.OP_PARENTESE_D:
              el = ")";
              _tipo = ConstSimbolos.OP_PARENTESE_D;
              break;
            case ConstSimbolos.OP_NEGACAO:
              el = "~";
              _tipo = ConstSimbolos.OP_NEGACAO;
              break;
            case ConstSimbolos.OP_CONJUNCAO:
              el = "∧";
              _tipo = ConstSimbolos.OP_CONJUNCAO;
              break;
            case ConstSimbolos.OP_DISJUNCAO:
              el = "v";
              _tipo = ConstSimbolos.OP_DISJUNCAO;
              break;
            case ConstSimbolos.OP_CONDICIONAL:
              el = "→";
              _tipo = ConstSimbolos.OP_CONDICIONAL;
              break;
            case ConstSimbolos.OP_BICONDICIONAL:
              el = "↔";
              _tipo = ConstSimbolos.OP_BICONDICIONAL;
              break;
            default:
              {
                el = string;

                if (el == ConstSimbolos.OP_VARIAVEL_A)
                  _tipo = ConstSimbolos.OP_VARIAVEL_A;
                if (el == ConstSimbolos.OP_VARIAVEL_B)
                  _tipo = ConstSimbolos.OP_VARIAVEL_B;
                if (el == ConstSimbolos.OP_VARIAVEL_C)
                  _tipo = ConstSimbolos.OP_VARIAVEL_C;

                break;
              }
          }
          str += el ?? "";

          _cadeia.add(SimboloWidget(
            tipo: _tipo,
            simbolo: el,
          ));
        });

        _list.add(ExpressaoWidget(
          id: e.id,
          expressao: str,
          onTap: () {
            _firstChildren..clear();
            _cadeia.forEach((el) {
              final e = el as SimboloWidget;
              this.addDimissible(e);
            });
          },
        ));
      });

      setState(() {
        this._secondChildren2 = _list;
      });
    });
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

  Future<void> showMyDialog(String msg, {String title}) async {
    return _showDialog(
      AlertDialog(
        title: Text(title ?? 'Oops!',
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

  void confirmExpression() {
    _thirdChildren.clear();

    int _iP1 = 0;
    int _iP2 = 0;
    int _iOP = 0;

    _firstChildren.forEach((child) {
      final sym = child as SimboloWidget;

      _iP1 += (sym.simbolo == ConstSimbolos.OP_PARENTESE_E) ? 1 : 0;
      _iP2 += (sym.simbolo == ConstSimbolos.OP_PARENTESE_D) ? 1 : 0;

      _iOP += (sym.simbolo != ConstSimbolos.OP_PARENTESE_E &&
              sym.simbolo != ConstSimbolos.OP_PARENTESE_D &&
              sym.simbolo != ConstSimbolos.OP_VARIAVEL_A &&
              sym.simbolo != ConstSimbolos.OP_VARIAVEL_B &&
              sym.simbolo != ConstSimbolos.OP_VARIAVEL_C)
          ? 1
          : 0;

      _thirdChildren.add(SimboloWidget(
        tipo: sym.tipo,
        simbolo: sym.simbolo,
      ));
    });

    if (_firstChildren.length < 2 ||
        (_iP1 != _iP2) ||
        (_iOP < 1) ||
        !((_firstChildren.last as SimboloWidget).tipo ==
                ConstSimbolos.OP_VARIAVEL_A ||
            (_firstChildren.last as SimboloWidget).tipo ==
                ConstSimbolos.OP_VARIAVEL_B ||
            (_firstChildren.last as SimboloWidget).tipo ==
                ConstSimbolos.OP_VARIAVEL_C ||
            (_firstChildren.last as SimboloWidget).tipo ==
                ConstSimbolos.OP_PARENTESE_D)) {
      showMyDialog("Verifique se a sua expressão tenha os requisitos: \n\n\n"
          "*Ao menos 1 variável\n\n"
          "*Ao menos 1 operador válido!\n\n"
          "*Cada parentese aberto presente, tenha um fechando\n");
      return;
    }

    setState(() {
      _indexDesconhecido = -1;
      _thirdChildren = List.from(_thirdChildren);
      _fourthChildren = List.from(_thirdChildren);
      _fifthChildren = [];
      _sixthChildren = [];
    });
  }

  void uploadExpressao() {
    int _iP1 = 0;
    int _iP2 = 0;
    int _iOP = 0;

    String _expressao = "";

    _firstChildren.forEach((child) {
      final sym = child as SimboloWidget;

      _iP1 += (sym.simbolo == ConstSimbolos.OP_PARENTESE_E) ? 1 : 0;
      _iP2 += (sym.simbolo == ConstSimbolos.OP_PARENTESE_D) ? 1 : 0;

      _iOP += (sym.simbolo != ConstSimbolos.OP_PARENTESE_E &&
              sym.simbolo != ConstSimbolos.OP_PARENTESE_D &&
              sym.simbolo != ConstSimbolos.OP_VARIAVEL_A &&
              sym.simbolo != ConstSimbolos.OP_VARIAVEL_B &&
              sym.simbolo != ConstSimbolos.OP_VARIAVEL_C)
          ? 1
          : 0;

      _expressao += ";" + sym.tipo;
    });

    if (_firstChildren.length < 2 ||
        (_iP1 != _iP2) ||
        (_iOP < 1) ||
        !((_firstChildren.last as SimboloWidget).tipo ==
                ConstSimbolos.OP_VARIAVEL_A ||
            (_firstChildren.last as SimboloWidget).tipo ==
                ConstSimbolos.OP_VARIAVEL_B ||
            (_firstChildren.last as SimboloWidget).tipo ==
                ConstSimbolos.OP_VARIAVEL_C ||
            (_firstChildren.last as SimboloWidget).tipo ==
                ConstSimbolos.OP_PARENTESE_D)) {
      showMyDialog("Verifique se a sua expressão tenha os requisitos: \n\n\n"
          "*Ao menos 1 variável\n\n"
          "*Ao menos 1 operador válido!\n\n"
          "*Cada parentese aberto presente, tenha um fechando\n");
      return;
    }

    Expressao(expressao: _expressao).save().then((value) {
      if (value != null && value > 0) {
        showMyDialog("Expressão salva com sucesso!", title: "Sucesso!");
        onRefresh();
      }
    });
  }

  Future<void> cadCorreto() async {
    if (this.fifthChildren.length == 2) {
      showMyDialog(
          "Desculpe, mas o maximo de alternativas corretas é de 2 elementos!");
      return;
    }

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
            tipo: ConstSimbolos.OP_INTERROGACAO,
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
            tipo: ConstSimbolos.OP_INTERROGACAO,
            simbolo: emoji,
          ));
      });
    }
  }

  //TODO
  void cadExpressao() {
    if ((this._fifthChildren.length + this._sixthChildren.length) < 4) {
      final _c = this._fifthChildren.length;
      final _e = (_c - 4).abs();

      showMyDialog(
          "Desculpe, mas é necessário $_c alternativa(s) correta(s) e pelo menos $_e alternativas incorretas");

      return;
    }

    String expressao = "";
    String corretas = "";
    String incorretas = "";

    for (int i = 0; i < _fourthChildren.length; i++) {
      final e = _fourthChildren[i] as SimboloWidget;
      if (i == _indexDesconhecido) {
        expressao += ";" + ConstSimbolos.OP_INTERROGACAO;
      } else {
        if (e.tipo == ConstSimbolos.OP_VARIAVEL_A ||
            e.tipo == ConstSimbolos.OP_VARIAVEL_B ||
            e.tipo == ConstSimbolos.OP_VARIAVEL_C) {
          expressao += ";" + e.simbolo;
        } else {
          expressao += ";" + e.tipo;
        }
      }
    }

    _fifthChildren.forEach((e) {
      corretas += ";" + (e as SimboloWidget).simbolo;
    });
    _sixthChildren.forEach((e) {
      incorretas += ";" + (e as SimboloWidget).simbolo;
    });

    ExpressaoEmoji(
      expressaoEmoji: expressao,
      respostas: corretas,
      erradas: incorretas,
    ).save().then((value) {
      if (value != null && value > 0) {
        showMyDialog("Expressão salva com sucesso!", title: "Salvo!");
      }
    });
  }
}
