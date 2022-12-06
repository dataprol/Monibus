import 'dart:async';
import 'package:monibus/database/sqlite/conexao.dart';
import 'package:sqflite/sqflite.dart';
import '../../model/passageiroModel.dart';
import 'package:monibus/constantes.dart';

import '../../service/pessoasService.dart';

class PassageiroEntidade {
  static final PassageiroEntidade _instance = PassageiroEntidade.internal();

  factory PassageiroEntidade() => _instance;

  PassageiroEntidade.internal();

  Future<List<Passageiro>> getAll() async {
/*     var api = PessoasService();
    var resultado = await api.listarPessoas();
    if (resultado.isError()) {
      print('ERRO: ' + resultado.getError().toString());
    } else {
      print('SUCESSO: ${resultado.getSuccess()}');
    }
 */
    Database bancoDados = await Conexao.iniciar();
    try {
      List listaMap =
          await bancoDados.rawQuery("SELECT * FROM $kTabelaPassageiros");
      List<Passageiro> passageirosLista =
          listaMap.map((x) => Passageiro.fromJson(x)).toList();
      return passageirosLista;
    } catch (e) {
      return [];
    }
  }

  Future<Passageiro> getById(int id) async {
    Database bancoDados = await Conexao.iniciar();
    List maps = await bancoDados.query('passageiros',
        columns: [], where: 'id = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      return Passageiro.fromJson(maps.first);
    } else {
      return Passageiro();
    }
  }

  Future<Passageiro> save(Passageiro passageiro) async {
    Database bancoDados = await Conexao.iniciar();
    passageiro.id = await bancoDados.insert('passageiros', passageiro.toJson());
    return passageiro;
  }

  Future<int> update(Passageiro passageiro) async {
    Database bancoDados = await Conexao.iniciar();
    return await bancoDados.update(kTabelaPassageiros, passageiro.toJson(),
        where: 'id = ?', whereArgs: [passageiro.id]);
  }

  Future<int> delete(int id) async {
    Database bancoDados = await Conexao.iniciar();
    return await bancoDados
        .delete('passageiros', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteAll() async {
    Database bancoDados = await Conexao.iniciar();
    return await bancoDados.rawDelete("DELETE * from $kTabelaPassageiros");
  }
}
