import 'dart:convert' show jsonDecode;

import 'package:flutter/services.dart';
import 'package:ihm_2020_3/src/model/database/models/expressao_emoji.dart';
import 'package:ihm_2020_3/src/model/objetivo/quest_expressao.dart';

class Objetivo {
  static final _this = Objetivo._();

  factory Objetivo() => _this;

  Objetivo._();

  final List<QuestExpressao> _questoes = <QuestExpressao>[];

  QuestExpressao get current {
    try {
      return _questoes.first;
    } catch (e) {
      return null;
    }
  }

  Future<void> build() async {
    _questoes..clear();
    var _expressoes = await ExpressaoEmoji.getAll();
    if (_expressoes.isEmpty || _expressoes.length <= 3) {
      await rootBundle
          .loadString("assets/json/default_quests.json")
          .then((jsonStr) {
        print("----- Carregando expressões pelo default_quests.json");
        final map = jsonDecode(jsonStr) as Map;
        final _q1 = ExpressaoEmoji.fromJson(((map["fase1"] as List)..shuffle()).first);
        final _q2 = ExpressaoEmoji.fromJson(((map["fase2"] as List)..shuffle()).first);
        final _q3 = ExpressaoEmoji.fromJson(((map["fase3"] as List)..shuffle()).first);
        final _q4 = ExpressaoEmoji.fromJson(((map["fase4"] as List)..shuffle()).first);
        final _q5 = ExpressaoEmoji.fromJson(((map["fase4"] as List)..shuffle()).first);
        _expressoes = [_q1, _q2, _q3, _q4, _q5];
      }).catchError((err) {
        print("----- Erro ao carregar expressões pelo default_quests.json");
        final _q1 = ExpressaoEmoji(
          expressaoEmoji: ";A;CON;B",
          respostas: ";V",
          erradas: ";F;F;F",
          dicionario: ";A:V;B:V",
        );
        final _q2 = ExpressaoEmoji(
          expressaoEmoji: ";NOT;A;CON;A",
          respostas: ";F;F",
          erradas: ";V;V",
          dicionario: ";A:F",
        );
        final _q3 = ExpressaoEmoji(
          expressaoEmoji: ";NOT;A;CON;NOT;A",
          respostas: ";V;V",
          erradas: ";F;F",
          dicionario: ";A:F",
        );
        final _q4 = ExpressaoEmoji(
          expressaoEmoji: ";(;NOT;A;CON;NOT;A;);BICON;A",
          respostas: ";F;F",
          erradas: ";V;V",
          dicionario: ";A:F",
        );
        final _q5 = ExpressaoEmoji(
          expressaoEmoji: ";(;NOT;A;);CON;(;NOT;B;BICON;C;)",
          respostas: ";V;V",
          erradas: ";F;F",
          dicionario: ";A:V;B:F;C:F",
        );
        _expressoes = [_q1, _q2, _q3, _q4, _q5];
      });
    } else {
      // Futuramente pode ser que tenha alguma implementação
    }

    _expressoes.forEach((el) {
      _questoes.add(QuestExpressao(el));
    });
  }

  Future<void> proximoObjetivo() async {
    _questoes.removeAt(0);
  }
}