import 'package:ihm_2020_3/src/model/database/sql/sqflite.dart';
import 'package:ihm_2020_3/src/model/database/utils/table_utils.dart';

class Expressao {
  int id;
  String expressao;

  Expressao({this.id=0, this.expressao});

  Expressao.fromJson(Map<String, dynamic> json) {
    id = json[TableExpressao.COL_ID];
    expressao = json[TableExpressao.COL_EXPRESSAO];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[TableExpressao.COL_ID] = this.id;
    data[TableExpressao.COL_EXPRESSAO] = this.expressao;
    return data;
  }

  Future save() async {
    this.id = await SqlHelper().insert(TableExpressao.NOME_TABELA, toJson());
    return Future.value(this.id);
  }

  static Future<List<Expressao>> getAll() async {
    List elements = await SqlHelper().getAll(TableExpressao.NOME_TABELA);
    List<Expressao> expressoes = List();
    elements.forEach((e) {
      expressoes.add(Expressao.fromJson(e));
    });
    return Future.value(expressoes);
  }

  static Future removeId(int id) async {
    await SqlHelper().removeId(TableExpressao.NOME_TABELA, id);
  }

  static Future removeAll() async {
    await SqlHelper().removeAll(TableExpressao.NOME_TABELA);
  }
}
