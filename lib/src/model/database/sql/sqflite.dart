import 'package:ihm_2020_3/src/model/database/utils/table_utils.dart';
import 'package:path/path.dart' show join;
import 'package:sqflite/sqflite.dart'
    show Database, openDatabase, getDatabasesPath;

class SqlHelper {
  static const String NOME_BASE_DADOS = "main_base.db";
  static final SqlHelper _this = SqlHelper._();

  factory SqlHelper() => _this;

  SqlHelper._();

  Database _db;

  Future<Database> get db async {
    // if (_db == null) {
    //   _db = await initDd();
    // }
    return _db ??= await _initDd();
  }

  Future<Database> _initDd() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, NOME_BASE_DADOS);
    return await openDatabase(path,
        version: 1, onCreate: _create, onUpgrade: _update);
  }

  void _create(Database db, int newVersion) async {
    await db.execute(TableExpressao.CREATE_TABLE);
    await db.execute(TableExpressaoEmoji.CREATE_TABLE);
    await db.execute(TableRank.CREATE_TABLE);
  }

  void _update(Database db, int oldVersion, int newVersion) async {}

  Future insert(String table, Map map) async{
    Database dataBase = await this.db;
    int valor = await dataBase.insert(table, map);
    return Future.value(valor);
  }

  Future<List> getAll(String table) async {
    Database dataBase = await this.db;
    List listMap = await dataBase.rawQuery("SELECT * FROM $table");
    return listMap;
  }

  Future removeId(String table, int id) async {
    Database dataBase = await this.db;
    await dataBase.rawDelete("DELETE FROM $table where id='$id'");
  }

  Future removeAll(String table) async {
    Database dataBase = await this.db;
    await dataBase.rawDelete("DELETE FROM $table");
  }

}
