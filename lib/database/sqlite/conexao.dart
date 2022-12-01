import 'dart:async';
import 'package:monibus/constantes.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Conexao {
  static late Database _db;
  static bool _iniciado = false;
  static Future<Database> iniciar() async {
    print(kTabelaCriar);
    if (!_iniciado) {
      var bancoDadosCaminho = await getDatabasesPath();
      bancoDadosCaminho = join(bancoDadosCaminho, "monibus.db");
      _db = await openDatabase(
        bancoDadosCaminho,
        version: 1,
        onCreate: (Database db, int newerVersion) {
          db.execute(kTabelaCriar);
        },
        onConfigure: (db) {
          /* db.execute(tabelaApagar);
          db.execute(tabelaCriar); */
        },
      );
    }
    return _db;
  }
}
