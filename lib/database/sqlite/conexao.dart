import 'dart:async';
import 'package:monibus/constantes.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Conexao {
  static late Database _db;
  static bool _iniciado = false;
  static Future<Database> iniciar() async {
    if (!_iniciado) {
      var bancoDadosCaminho = await getDatabasesPath();
      bancoDadosCaminho = join(bancoDadosCaminho, "monibus.db");
      //await deleteDatabase(bancoDadosCaminho);
      _db =
          await openDatabase(bancoDadosCaminho, version: 1, onConfigure: (db) {
        // Sempre antes que o banco de dados é aberto/criado/atualizado/desatualizado
/*         db.execute(kTabelaPassageirosApagar);
        db.execute(kTabelaPassageirosCriar); */
      }, onCreate: (Database db, int newerVersion) {
        db.execute(kTabelaPassageirosCriar);
      }, onUpgrade: (db, a, b) {
        // Quando atualizar banco de dados
      }, onDowngrade: (db, a, b) {
        // Quando desatualizar banco de dados
      }, onOpen: (db) {
        // Na abertura do banco de dados
      });
      _iniciado = true;
    }
    return _db;
  }

  static Future<void> terminar() async {
    await _db.close();
  }

  static Future<void> remover() async {
    var bancoDadosCaminho = await getDatabasesPath();
    bancoDadosCaminho = join(bancoDadosCaminho, "monibus.db");
    await deleteDatabase(bancoDadosCaminho);
  }
}
