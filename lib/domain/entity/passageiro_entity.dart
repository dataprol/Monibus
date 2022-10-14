import 'dart:async';
import 'package:monibus/database/sqlite/conexao.dart';
import 'package:sqflite/sqflite.dart';
import '/model/passageiro.dart';

class PassageiroEntidade {
  static final PassageiroEntidade _instance = PassageiroEntidade.internal();
  factory PassageiroEntidade() => _instance;
  PassageiroEntidade.internal();

  Future<Passageiro> save(Passageiro passageiro) async {
    Database bancoDados = await Conexao.iniciar();
    passageiro.id = await bancoDados.insert('passageiros', passageiro.toMap());
    return passageiro;
  }

  Future<Passageiro> getById(int id) async {
    Database bancoDados = await Conexao.iniciar();
    List maps = await bancoDados.query('passageiros',
        columns: ['id', 'nome', 'presenca'], where: 'id = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Passageiro.fromMap(maps.first);
    } else {
      return Passageiro();
    }
  }

  Future<List<Passageiro>> getAll() async {
    Database bancoDados = await Conexao.iniciar();
    List listaMap = await bancoDados.rawQuery("SELECT * FROM passageiros");
    List<Passageiro> stuffList =
        listaMap.map((x) => Passageiro.fromMap(x)).toList();
    return stuffList;
  }

  Future<int> update(Passageiro passageiro) async {
    Database bancoDados = await Conexao.iniciar();
    return await bancoDados.update('passageiros', passageiro.toMap(),
        where: 'id = ?', whereArgs: [passageiro.id]);
  }

  Future<int> delete(int id) async {
    Database bancoDados = await Conexao.iniciar();
    return await bancoDados
        .delete('passageiros', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteAll() async {
    Database bancoDados = await Conexao.iniciar();
    return await bancoDados.rawDelete("DELETE * from passageiros");
  }
}
