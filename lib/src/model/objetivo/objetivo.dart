import 'package:ihm_2020_3/src/model/database/models/expressao_emoji.dart';
import 'package:ihm_2020_3/src/model/objetivo/quest_expressao.dart';

class Objetivo {
  static final _this = Objetivo._();

  factory Objetivo() => _this;

  Objetivo._() {}

  final List<QuestExpressao> _questoes = <QuestExpressao>[];

  final List<QuestExpressao> _questoesLevel1 = <QuestExpressao>[];
  final List<QuestExpressao> _questoesLevel2 = <QuestExpressao>[];
  final List<QuestExpressao> _questoesLevel3 = <QuestExpressao>[];
  final List<QuestExpressao> _questoesLevel4 = <QuestExpressao>[];

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
    if (_expressoes == null) {
      _expressoes ??= elements;
    } else {
      _expressoes..addAll(elements);
    }

    final expTemp = _expressoes
      ..shuffle()
      ..sublist(0, 5);
    expTemp.forEach((el) {
      _questoes.add(QuestExpressao(el));
    });
    
  }

  Future<void> proximoObjetivo() async {
    _questoes.removeAt(0);
  }
}

final elements = [
  ExpressaoEmoji(
    expressaoEmoji: ";?;CON;(;✔;AND;✔;)",
    respostas: ";✔",
    erradas: ";✅;❌;✅",
  ),
  ExpressaoEmoji(
    expressaoEmoji: ";?;CON;(;👨;AND;🍽;)",
    respostas: ";🍝;🍛",
    erradas: ";⚾;🎼;🔥",
  ),
  ExpressaoEmoji(
    expressaoEmoji: ";(;🐒;AND;🍽;);CON;?",
    respostas: ";🍌",
    erradas: ";🔥;🍾;🍺",
  ),
  ExpressaoEmoji(
    expressaoEmoji: ";?;CON;(;🚹;OR;🚺;)",
    respostas: ";🚹;🚺",
    erradas: ";⛔;🍾;⚾",
  ),
  ExpressaoEmoji(
    expressaoEmoji: ";?;CON;NOT;🐵",
    respostas: ";🐢;🐨",
    erradas: ";🙈;🙉;🙊",
  ),
  ExpressaoEmoji(
    expressaoEmoji: ";(;NOT;NOT;🐵;);CON;?",
    respostas: ";🐵",
    erradas: ";🍞;🗿;🐶",
  ),
  ExpressaoEmoji(
    expressaoEmoji: ";?;BICON;(;🚹;AND;🚺;)",
    respostas: ";🚻",
    erradas: ";⛔;🗿;🆒",
  ),
  ExpressaoEmoji(
    expressaoEmoji: ";(;👨;AND;🍽;);CON;?",
    respostas: ";🍝;🍛",
    erradas: ";⚾;🎼;🔥",
  ),
];
