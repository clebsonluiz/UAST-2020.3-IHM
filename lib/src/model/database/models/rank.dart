import 'package:ihm_2020_3/src/model/database/sql/sqflite.dart';
import 'package:ihm_2020_3/src/model/database/utils/rank_utils..dart';
import 'package:ihm_2020_3/src/model/database/utils/table_utils.dart';

class Rank implements Comparable<Rank> {
  int id;
  String tempo;
  String horario;
  int vidasRestantes;

  Rank({this.id, this.tempo, this.horario, this.vidasRestantes});

  Rank.fromJson(Map<String, dynamic> json) {
    id = json[TableRank.COL_ID];
    tempo = json[TableRank.COL_TEMPO];
    horario = json[TableRank.COL_HORARIO];
    vidasRestantes = json[TableRank.COL_LIFES];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data[TableRank.COL_ID] = this.id;
    data[TableRank.COL_TEMPO] = this.tempo;
    data[TableRank.COL_HORARIO] = this.horario ?? DateTime.now().toString();
    data[TableRank.COL_LIFES] = this.vidasRestantes;
    return data;
  }

  Future save() async {
    this.id = await SqlHelper().insert(TableRank.NOME_TABELA, toJson());
    return Future.value(this.id);
  }

  static Future<List<Rank>> getAll() async {
    List elements = await SqlHelper().getAll(TableRank.NOME_TABELA);
    List<Rank> ranks = List();
    elements.forEach((e) {
      ranks.add(Rank.fromJson(e));
    });
    return Future.value(ranks);
  }

  static Future removeId(int id) async {
    await SqlHelper().removeId(TableRank.NOME_TABELA, id);
  }

  static Future removeAll() async {
    await SqlHelper().removeAll(TableRank.NOME_TABELA);
  }

  @override
  int compareTo(Rank other) {
    final tempo1 = RankUtils.convertStringToDuration(this.tempo);
    final tempo2 = RankUtils.convertStringToDuration(other.tempo);

    if (tempo1 < tempo2) if ((this.vidasRestantes) > (other.vidasRestantes)) {
      return -1;
    } else
      return -1;
    if (tempo1 > tempo2) if ((this.vidasRestantes) < (other.vidasRestantes)) {
      return 1;
    } else
      return 1;
    return 0;
  }
}
