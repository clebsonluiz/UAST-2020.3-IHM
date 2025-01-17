import 'package:ihm_2020_3/src/model/database/sql/sqflite.dart';
import 'package:ihm_2020_3/src/model/database/utils/table_utils.dart';

class ExpressaoEmoji {
  int id;
  String expressaoEmoji;
  String respostas;
  String erradas;
  String dicionario;

  ExpressaoEmoji({this.id, this.expressaoEmoji, this.respostas, this.erradas, this.dicionario});

  ExpressaoEmoji.fromJson(Map<String, dynamic> json) {
    id = json[TableExpressaoEmoji.COL_ID];
    expressaoEmoji = json[TableExpressaoEmoji.COL_EXPRESSAO_EMOJI];
    respostas = json[TableExpressaoEmoji.COL_RESPOSTAS];
    erradas = json[TableExpressaoEmoji.COL_ERRADAS];
    dicionario = json[TableExpressaoEmoji.COL_DICT];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[TableExpressaoEmoji.COL_ID] = this.id;
    data[TableExpressaoEmoji.COL_EXPRESSAO_EMOJI] = this.expressaoEmoji;
    data[TableExpressaoEmoji.COL_RESPOSTAS] = this.respostas;
    data[TableExpressaoEmoji.COL_ERRADAS] = this.erradas;
    data[TableExpressaoEmoji.COL_DICT] = this.dicionario;
    return data;
  }

  @override
  String toString() => "${this.toJson()}";

  Future save() async {
    this.id = await SqlHelper()
        .insert(TableExpressaoEmoji.NOME_TABELA, this.toJson());
    return Future.value(this.id);
  }

  static Future<List<ExpressaoEmoji>> getAll() async {
    List elements = await SqlHelper().getAll(TableExpressaoEmoji.NOME_TABELA);
    List<ExpressaoEmoji> expressoes = List();
    elements.forEach((e) {
      expressoes.add(ExpressaoEmoji.fromJson(e));
    });
    return Future.value(expressoes);
  }

  static Future removeId(int id) async {
    await SqlHelper().removeId(TableExpressaoEmoji.NOME_TABELA, id);
  }

  static Future removeAll() async {
    await SqlHelper().removeAll(TableExpressaoEmoji.NOME_TABELA);
  }
}
