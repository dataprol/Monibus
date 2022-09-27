import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '/model/passageiro.dart';

class PassageiroHelper {
  static final PassageiroHelper _instance = PassageiroHelper.internal();
  factory PassageiroHelper() => _instance;

  PassageiroHelper.internal();
  late Database _bancoDados;

  Future<Database> get bd async {
    if (_bancoDados != null) {
      return _bancoDados;
    } else {
      _bancoDados = await initDb();
      return _bancoDados;
    }
  }

  Future<Database> initDb() async {
    final bancoDadosCaminho = await getDatabasesPath();
    final caminho = join(bancoDadosCaminho, "monibus.db");

    return openDatabase(caminho, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute("CREATE TABLE passageiros("
          "id INTEGER PRIMARY KEY,"
          "nome TEXT,"
          "presenca INTEGER)");
    });
  }

  Future<Passageiro> save(Passageiro passageiro) async {
    Database bancoDados = await bd;
    passageiro.id = await bancoDados.insert('passageiros', passageiro.toMap());
    return passageiro;
  }

  Future<Passageiro> getById(int id) async {
    Database database = await bd;
    List maps = await database.query('passageiros',
        columns: ['id', 'nome', 'presenca'], where: 'id = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Passageiro.fromMap(maps.first);
    } else {
      return Passageiro();
    }
  }

  Future<List<Passageiro>> getAll() async {
    Database bancoDados = await bd;
    List listaMap = await bancoDados.rawQuery("SELECT * FROM passageiros");
    List<Passageiro> stuffList =
        listaMap.map((x) => Passageiro.fromMap(x)).toList();
    return stuffList;
  }

  Future<int> update(Passageiro passageiro) async {
    Database bancoDados = await bd;
    return await bancoDados.update('passageiros', passageiro.toMap(),
        where: 'id = ?', whereArgs: [passageiro.id]);
  }

  Future<int> delete(int id) async {
    Database bancoDados = await bd;
    return await bancoDados
        .delete('passageiros', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteAll() async {
    Database bancoDados = await bd;
    return await bancoDados.rawDelete("DELETE * from passageiros");
  }
}
