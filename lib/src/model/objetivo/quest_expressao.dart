import 'package:ihm_2020_3/src/model/database/models/cadeia.dart';
import 'package:ihm_2020_3/src/model/database/models/expressao_emoji.dart';
import 'package:ihm_2020_3/src/model/entity/symbol/symbol_object.dart';
import 'package:ihm_2020_3/src/model/entity/symbol/symbol_object_box_color.dart';

class QuestExpressao {
  final ExpressaoEmoji _expressaoEmoji;

  final _expressao = <SymbolObject>[];
  final _respostas = <SymbolObject>[];
  final _erradas = <SymbolObject>[];
  final _alternativas = <SymbolObject>[
    SymbolObjectBoxColorBlue(),
    SymbolObjectBoxColorGreen(),
    SymbolObjectBoxColorYellow(),
    SymbolObjectBoxColorWhite(),
    SymbolObjectBoxColorRed(),
  ];

  

  QuestExpressao(this._expressaoEmoji);

  void build() {

    final emojinador = this._expressaoEmoji;

    _expressao..clear()..addAll(_splitter(emojinador.expressaoEmoji));
    _respostas..clear()..addAll(_splitter(emojinador.respostas));
    _erradas..clear()..addAll(_splitter(emojinador.erradas));

    final _temp = <SymbolObject>[];
    _alternativas..shuffle();
    _temp..addAll(_respostas)..addAll(_erradas);
    
    while(_temp.length > _alternativas.length)   _temp.removeLast();
    for (int i = 0; i < _temp.length; i ++){
      _alternativas[i].text = _temp[i].text;
    }

    _alternativas..clear()..addAll(_splitter(emojinador.erradas));
  }

  List<SymbolObject> _splitter(String s){
    final _list = <SymbolObject>[];
    final _splited = s.split(";")..removeWhere((e) => e.isEmpty);
    _splited.forEach((string) => _list.add(_get(string)));

    return _list;
  }

  SymbolObject _get(String s){
    switch (s) {
      case Cadeia.OP_PARENTESE_E: 
        return _sym("(");
      case Cadeia.OP_PARENTESE_D: 
        return _sym(")");
      case Cadeia.OP_NEGACAO: 
        return _sym("~");
      case Cadeia.OP_INTERROGACAO: 
        return _sym("?");
      case Cadeia.OP_CONJUNCAO: 
        return _sym("∧");
      case Cadeia.OP_DISJUNCAO: 
        return _sym("v");
      case Cadeia.OP_CONDICIONAL: 
        return _sym("→");
      case Cadeia.OP_BICONDICIONAL: 
        return _sym("↔");
      default: {
        return _sym(s);
      }
    }
  }

  SymbolObject _sym(String s) => SymbolObjectBoxColorDark()..text = s;

  get expressao => this._expressao;
  get alternativas => this._alternativas;
  get respostas => this._respostas;


  //TODO - Mudar para adicionar o Drop Key
  bool responder(SymbolObject _sym){
    final _isRight = _checkResposta(_sym);
    if (_isRight){
      final index = _expressao.indexWhere((sym) => sym.text == Cadeia.OP_INTERROGACAO);
      if(index >= 0){
        _expressao[index] = _sym;
      }
      _alternativas.remove(_sym);

    }
    return _isRight;
  }

  bool _checkResposta(SymbolObject _sym){
    return !this._respostas.every((sym) => sym.text != _sym.text);
  }


}
