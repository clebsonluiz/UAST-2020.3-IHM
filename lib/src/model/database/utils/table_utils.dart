class TableExpressao {
  static const String NOME_TABELA = "table_expressao";
  static const String COL_ID = "id";
  static const String COL_EXPRESSAO = "expressao";

  static const CREATE_TABLE = "CREATE TABLE $NOME_TABELA ( "
      "$COL_ID INTEGER PRIMARY KEY, "
      "$COL_EXPRESSAO TEXT);";

  static const DROP_TABLE = "DROP TABLE IF EXISTS $NOME_TABELA";
}

class TableExpressaoEmoji {
  static const String NOME_TABELA = "table_expressao_emoji";
  static const String COL_ID = "id";
  static const String COL_EXPRESSAO_EMOJI = "expressao_emoji";
  static const String COL_RESPOSTAS = "respostas";
  static const String COL_ERRADAS = "erradas";

  static const CREATE_TABLE = "CREATE TABLE $NOME_TABELA ( "
      "$COL_ID INTEGER PRIMARY KEY, "
      "$COL_EXPRESSAO_EMOJI TEXT, "
      "$COL_RESPOSTAS TEXT, "
      "$COL_ERRADAS TEXT);";

  static const DROP_TABLE = "DROP TABLE IF EXISTS $NOME_TABELA";
}

class TableRank {
  static const String NOME_TABELA = "table_rank";
  static const String COL_ID = "id";
  static const String COL_TEMPO = "tempo";
  static const String COL_HORARIO = "horario";
  static const String COL_LIFES = "vidas_restantes";

  static const CREATE_TABLE = "CREATE TABLE $NOME_TABELA ( "
      "$COL_ID INTEGER PRIMARY KEY, "
      "$COL_TEMPO TEXT, "
      "$COL_HORARIO TEXT, "
      "$COL_LIFES INTEGER );";

  static const DROP_TABLE = "DROP TABLE IF EXISTS $NOME_TABELA";
}
