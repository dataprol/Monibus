import 'dart:async';
import 'package:monibus/database/sqlite/conexao.dart';
import 'package:sqflite/sqflite.dart';
import '../../model/passageiroModel.dart';
import 'package:monibus/constantes.dart';

class PassageiroEntidade {
  static final PassageiroEntidade _instance = PassageiroEntidade.internal();
  factory PassageiroEntidade() => _instance;
  PassageiroEntidade.internal();

  Future<Passageiro> save(Passageiro passageiro) async {
    Database bancoDados = await Conexao.iniciar();
    passageiro.idPassageiro =
        await bancoDados.insert('passageiros', passageiro.toJson());
    return passageiro;
  }

  Future<Passageiro> getById(int id) async {
    Database bancoDados = await Conexao.iniciar();
    List maps = await bancoDados.query('passageiros',
        columns: ['id', 'nome', 'presenca'], where: 'id = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Passageiro.fromJson(maps.first);
    } else {
      return Passageiro();
    }
  }

  Future<List<Passageiro>> getAll() async {
    Database bancoDados = await Conexao.iniciar();
    List listaMap =
        await bancoDados.rawQuery("SELECT * FROM $kLocalTabelaPassageiros");
    List<Passageiro> passageirosLista =
        listaMap.map((x) => Passageiro.fromJson(x)).toList();
    return passageirosLista;
  }

  Future<int> update(Passageiro passageiro) async {
    Database bancoDados = await Conexao.iniciar();
    return await bancoDados.update(kLocalTabelaPassageiros, passageiro.toJson(),
        where: 'id = ?', whereArgs: [passageiro.idPassageiro]);
  }

  Future<int> delete(int id) async {
    Database bancoDados = await Conexao.iniciar();
    return await bancoDados
        .delete('passageiros', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteAll() async {
    Database bancoDados = await Conexao.iniciar();
    return await bancoDados.rawDelete("DELETE * from $kLocalTabelaPassageiros");
  }
}
