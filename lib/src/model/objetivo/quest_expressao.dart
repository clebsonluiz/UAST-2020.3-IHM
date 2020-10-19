import 'package:ihm_2020_3/src/model/utils/const_simbolos.dart';
import 'package:ihm_2020_3/src/model/database/models/expressao_emoji.dart';
import 'package:ihm_2020_3/src/model/entity/symbol/symbol_object.dart';
import 'package:ihm_2020_3/src/model/entity/symbol/symbol_object_box_color.dart';

class QuestExpressao {
  final ExpressaoEmoji _expressaoEmoji;

  final _expressao = <SymbolObject>[];
  final _dicionario = <String>[];
  final _respostas = <SymbolObject>[];
  final _erradas = <SymbolObject>[];
  final _alternativas = <SymbolObject>[
    SymbolObjectBoxColorBlue(),
    SymbolObjectBoxColorGreen(),
    SymbolObjectBoxColorYellow(),
    // SymbolObjectBoxColorWhite(),
    SymbolObjectBoxColorRed(),
  ];

  

  QuestExpressao(this._expressaoEmoji);

  Future<void> build() async {

    final emojinador = this._expressaoEmoji;

    _expressao..clear()..addAll(_splitter(emojinador.expressaoEmoji));
    _respostas..clear()..addAll(_splitter(emojinador.respostas));
    _erradas..clear()..addAll(_splitter(emojinador.erradas));
    

    final _dict = emojinador.dicionario.split(";")..removeWhere((e) => e.isEmpty);

    _dicionario..clear()..addAll(
      _dict.map((e) {
        final _s = e.split(":");
        return "${_s.first}=${_s.last}";
      }).toList()
    );





    final _temp = <SymbolObject>[];
    _alternativas..shuffle();
    _temp..addAll(_respostas)..addAll(_erradas);
    
    while(_temp.length > _alternativas.length)   _temp.removeLast();
    for (int i = 0; i < _temp.length; i ++){
      _alternativas[i].text = _temp[i].text;
    }
    _alternativas.shuffle();
    
    return Future.value();
  }

  List<SymbolObject> _splitter(String s){
    final _list = <SymbolObject>[];
    final _splited = s.split(";")..removeWhere((e) => e.isEmpty);
    _splited.forEach((string) => _list.add(_get(string)));
    return _list;
  }

  SymbolObject _get(String s){
    switch (s) {
      case ConstSimbolos.OP_PARENTESE_E: 
        return _sym("(");
      case ConstSimbolos.OP_PARENTESE_D: 
        return _sym(")");
      case ConstSimbolos.OP_NEGACAO: 
        return _sym("~");
      case ConstSimbolos.OP_INTERROGACAO: 
        return _sym("?");
      case ConstSimbolos.OP_CONJUNCAO: 
        return _sym("∧");
      case ConstSimbolos.OP_DISJUNCAO: 
        return _sym("v");
      case ConstSimbolos.OP_CONDICIONAL: 
        return _sym("→");
      case ConstSimbolos.OP_BICONDICIONAL: 
        return _sym("↔");
      default: {
        return _sym(s);
      }
    }
  }

  SymbolObject _sym(String s) => SymbolObjectBoxColorDark()..text = s;

  List<SymbolObject> get expressao => this._expressao;
  List<SymbolObject> get alternativas => this._alternativas;
  List<SymbolObject> get respostas => this._respostas;


  bool responder(SymbolObject _sym){
    final _isRight = _checkResposta(_sym);
    if (_isRight){
      final index = _expressao.indexWhere((sym) => sym.text == ConstSimbolos.OP_INTERROGACAO);
      if(index >= 0){
        _expressao[index].text = _sym.text;
      }
    }
    _alternativas.remove(_sym);
    return _isRight;
  }

  bool _checkResposta(SymbolObject _sym){
    return !this._respostas.every((sym) => sym.text != _sym.text);
  }


}
