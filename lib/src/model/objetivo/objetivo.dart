import 'package:ihm_2020_3/src/model/database/models/expressao_emoji.dart';
import 'package:ihm_2020_3/src/model/objetivo/quest_expressao.dart';

class Objetivo {
  static final _this = Objetivo._();

  factory Objetivo() => _this;

  Objetivo._() {}

  final List<QuestExpressao> _questoes = <QuestExpressao>[];

  // final List<QuestExpressao> _questoesLevel1 = <QuestExpressao>[];
  // final List<QuestExpressao> _questoesLevel2 = <QuestExpressao>[];
  // final List<QuestExpressao> _questoesLevel3 = <QuestExpressao>[];
  // final List<QuestExpressao> _questoesLevel4 = <QuestExpressao>[];

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
    // if (_expressoes == null) {
    //   _expressoes ??= elements;
    // } else {
    //   _expressoes..addAll(elements);
    // }

    final q1 = (_level1..shuffle()).first;
    final q2 = (_level2..shuffle()).first;
    final q3 = (_level3..shuffle()).first;
    final q4 = (_level4..shuffle()).first;
    final q5 = (_level4..shuffle()).first;

    final expTemp = [q1, q2, q3, q4, q5];

    // final expTemp = _expressoes
    //   ..shuffle()
    //   ..sublist(0, 5);

    expTemp.forEach((el) {
      _questoes.add(QuestExpressao(el));
    });
  }

  Future<void> proximoObjetivo() async {
    _questoes.removeAt(0);
  }
}

final _level1 = [
  ExpressaoEmoji(
    expressaoEmoji: ";NOT;A",
    respostas: ";V",
    erradas: ";F;F;F",
    dicionario: ";A:F",
  ),
  ExpressaoEmoji(
    expressaoEmoji: ";A;CON;B",
    respostas: ";V",
    erradas: ";F;F;F",
    dicionario: ";A:V;B:V",
  ),
  ExpressaoEmoji(
    expressaoEmoji: "A;BICON;B",
    respostas: ";F;F",
    erradas: ";V;V",
    dicionario: ";A:F;B:F",
  ),
  ExpressaoEmoji(
    expressaoEmoji: ";A;BICON;B",
    respostas: ";V;V",
    erradas: ";F;F",
    dicionario: ";A:V;B:F",
  ),
  ExpressaoEmoji(
    expressaoEmoji: ";(;A;OR;B;)",
    respostas: ";V;V",
    erradas: ";F;F",
    dicionario: ";A:V;B:F",
  ),
  ExpressaoEmoji(
    expressaoEmoji: ";(;A;OR;B;)",
    respostas: ";F;F",
    erradas: ";V;V",
    dicionario: ";A:F;B:F",
  ),
  ExpressaoEmoji(
    expressaoEmoji: ";(;A;AND;B;)",
    respostas: ";V;V",
    erradas: ";F;F",
    dicionario: ";A:V;B:V",
  ),
  ExpressaoEmoji(
    expressaoEmoji: ";NOT;(;A;AND;B;)",
    respostas: ";F;F",
    erradas: ";V;V",
    dicionario: ";A:V;B:V",
  ),
  ExpressaoEmoji(
    expressaoEmoji: ";NOT;A;CON;B",
    respostas: ";F",
    erradas: ";V;V;V",
    dicionario: ";A:F;B:F",
  ),
  ExpressaoEmoji(
    expressaoEmoji: ";NOT;NOT;A",
    respostas: ";F;F",
    erradas: ";V;V",
    dicionario: ";A:F",
  ),
];

final _level2 = [
  ExpressaoEmoji(
    expressaoEmoji: ";NOT;A;CON;A",
    respostas: ";F;F",
    erradas: ";V;V",
    dicionario: ";A:F",
  ),
  ExpressaoEmoji(
    expressaoEmoji: ";NOT;A;CON;B",
    respostas: ";V",
    erradas: ";F;F;F",
    dicionario: ";A:V;B:V",
  ),
  ExpressaoEmoji(
    expressaoEmoji: ";NOT;A;BICON;B",
    respostas: ";V;V",
    erradas: ";F;F",
    dicionario: ";A:F;B:F",
  ),
  ExpressaoEmoji(
    expressaoEmoji: ";NOT;A;BICON;B",
    respostas: ";F;F",
    erradas: ";V;V",
    dicionario: ";A:V;B:F",
  ),
  ExpressaoEmoji(
    expressaoEmoji: ";NOT;(;A;OR;B;)",
    respostas: ";F;F",
    erradas: ";V;V",
    dicionario: ";A:V;B:F",
  ),
  ExpressaoEmoji(
    expressaoEmoji: ";NOT;(;A;OR;B;)",
    respostas: ";F;F",
    erradas: ";V;V",
    dicionario: ";A:F;B:V",
  ),
  ExpressaoEmoji(
    expressaoEmoji: ";NOT;(;A;AND;B;)",
    respostas: ";V;V",
    erradas: ";F;F",
    dicionario: ";A:V;B:F",
  ),
  ExpressaoEmoji(
    expressaoEmoji: ";NOT;(;A;AND;B;)",
    respostas: ";F;F",
    erradas: ";V;V",
    dicionario: ";A:V;B:V",
  ),
  ExpressaoEmoji(
    expressaoEmoji: ";NOT;A;CON;B",
    respostas: ";F",
    erradas: ";V;V;V",
    dicionario: ";A:F;B:F",
  ),
  ExpressaoEmoji(
    expressaoEmoji: ";NOT;A;CON;(;NOT;B;)",
    respostas: ";V",
    erradas: ";F;F;F",
    dicionario: ";A:F;B:F",
  ),
];

final _level3 = [
  ExpressaoEmoji(
    expressaoEmoji: ";NOT;A;CON;NOT;A",
    respostas: ";V;V",
    erradas: ";F;F",
    dicionario: ";A:F",
  ),
  ExpressaoEmoji(
    expressaoEmoji: ";(;NOT;A;);CON;(;NOT;B;)",
    respostas: ";V",
    erradas: ";F;F;F",
    dicionario: ";A:V;B:F",
  ),
  ExpressaoEmoji(
    expressaoEmoji: ";(;NOT;A;);BICON;(;NOT;B;)",
    respostas: ";V;V",
    erradas: ";F;F",
    dicionario: ";A:F;B:V",
  ),
  ExpressaoEmoji(
    expressaoEmoji: ";(;NOT;A;);BICON;A",
    respostas: ";F;F",
    erradas: ";V;V",
    dicionario: ";A:V",
  ),
  ExpressaoEmoji(
    expressaoEmoji: ";NOT;(;A;OR;NOT;A;)",
    respostas: ";F;F",
    erradas: ";V;V",
    dicionario: ";A:V",
  ),
  ExpressaoEmoji(
    expressaoEmoji: ";NOT;(;NOT;A;OR;B;)",
    respostas: ";F;F",
    erradas: ";V;V",
    dicionario: ";A:F;B:V",
  ),
  ExpressaoEmoji(
    expressaoEmoji: ";NOT;(;NOT;A;AND;B;)",
    respostas: ";V;V",
    erradas: ";F;F",
    dicionario: ";A:V;B:F",
  ),
  ExpressaoEmoji(
    expressaoEmoji: ";NOT;(;A;AND;NOT;B;)",
    respostas: ";F;F",
    erradas: ";V;V",
    dicionario: ";A:V;B:F",
  ),
  ExpressaoEmoji(
    expressaoEmoji: ";NOT;A;CON;(;NOT;NOT;B;)",
    respostas: ";F",
    erradas: ";V;V;V",
    dicionario: ";A:F;B:F",
  ),
  ExpressaoEmoji(
    expressaoEmoji: ";NOT;A;CON;(;NOT;A;)",
    respostas: ";V",
    erradas: ";F;F;F",
    dicionario: ";A:F",
  ),
];

final _level4 = [
  ExpressaoEmoji(
    expressaoEmoji: ";(;NOT;A;CON;NOT;A;);BICON;A",
    respostas: ";V;V",
    erradas: ";F;F",
    dicionario: ";A:F",
  ),
  ExpressaoEmoji(
    expressaoEmoji: ";(;NOT;A;);CON;(;NOT;B;BICON;C;)",
    respostas: ";V;V",
    erradas: ";F;F",
    dicionario: ";A:V;B:F;C:F",
  ),
  ExpressaoEmoji(
    expressaoEmoji: ";(;NOT;A;BICON;NOT;B;);OR;C",
    respostas: ";V;V",
    erradas: ";F;F",
    dicionario: ";A:F;B:V;C;V",
  ),
  ExpressaoEmoji(
    expressaoEmoji: ";(;NOT;A;);BICON;(;A;OR;NOT;A;)",
    respostas: ";F;F",
    erradas: ";V;V",
    dicionario: ";A:V",
  ),
  ExpressaoEmoji(
    expressaoEmoji: ";NOT;(;A;OR;NOT;B;);AND;(;B;OR;C;)",
    respostas: ";F;F",
    erradas: ";V;V",
    dicionario: ";A:V;B:F;C:F",
  ),
  ExpressaoEmoji(
    expressaoEmoji: ";NOT;(;NOT;A;OR;B;);CON;C",
    respostas: ";V;V",
    erradas: ";F;F",
    dicionario: ";A:F;B:V;C:F",
  ),
  ExpressaoEmoji(
    expressaoEmoji: ";NOT;(;NOT;A;AND;B;);BICON;C",
    respostas: ";V;V",
    erradas: ";F;F",
    dicionario: ";A:V;B:F;C:V",
  ),
  ExpressaoEmoji(
    expressaoEmoji: ";NOT;(;A;AND;NOT;B;);AND;B",
    respostas: ";F;F",
    erradas: ";V;V",
    dicionario: ";A:V;B:F",
  ),
  ExpressaoEmoji(
    expressaoEmoji: ";(;NOT;A;OR;C;);CON;(;NOT;NOT;B;)",
    respostas: ";F;F",
    erradas: ";V;V",
    dicionario: ";A:F;B:F;C:F",
  ),
  ExpressaoEmoji(
    expressaoEmoji: ";(;NOT;A;BICON;A;);CON;(;NOT;A;OR;A)",
    respostas: ";V;F",
    erradas: ";F;F",
    dicionario: ";A:F",
  ),
];

// final elements = [
//   ExpressaoEmoji(
//     expressaoEmoji: ";?;CON;(;✔;AND;✔;)",
//     respostas: ";✔",
//     erradas: ";✅;❌;✅",
//   ),
//   ExpressaoEmoji(
//     expressaoEmoji: ";?;CON;(;👨;AND;🍽;)",
//     respostas: ";🍝;🍛",
//     erradas: ";⚾;🎼;🔥",
//   ),
//   ExpressaoEmoji(
//     expressaoEmoji: ";(;🐒;AND;🍽;);CON;?",
//     respostas: ";🍌",
//     erradas: ";🔥;🍾;🍺",
//   ),
//   ExpressaoEmoji(
//     expressaoEmoji: ";?;CON;(;🚹;OR;🚺;)",
//     respostas: ";🚹;🚺",
//     erradas: ";⛔;🍾;⚾",
//   ),
//   ExpressaoEmoji(
//     expressaoEmoji: ";?;CON;NOT;🐵",
//     respostas: ";🐢;🐨",
//     erradas: ";🙈;🙉;🙊",
//   ),
//   ExpressaoEmoji(
//     expressaoEmoji: ";(;NOT;NOT;🐵;);CON;?",
//     respostas: ";🐵",
//     erradas: ";🍞;🗿;🐶",
//   ),
//   ExpressaoEmoji(
//     expressaoEmoji: ";?;BICON;(;🚹;AND;🚺;)",
//     respostas: ";🚻",
//     erradas: ";⛔;🗿;🆒",
//   ),
//   ExpressaoEmoji(
//     expressaoEmoji: ";(;👨;AND;🍽;);CON;?",
//     respostas: ";🍝;🍛",
//     erradas: ";⚾;🎼;🔥",
//   ),
// ];
