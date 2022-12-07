import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../constantes.dart';
import '../model/pessoasModel2.dart';
import '../service/autenticacaoService.dart';
import '../view/passageiroForm2.dart';

const baseUrl = "$kAPI_URI_Base/pessoas";

class API {
  static Future getList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(kAPI_Chave_Token)!;
    return await http.get(Uri.parse(baseUrl), headers: {'Authorization': token});
  }

  static Future updateItem(String id, String item) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(kAPI_Chave_Token)!;
    return await http.put(Uri.parse('$baseUrl/$id'), headers: {'Authorization': token, 'Content-Type': 'application/json'}, body: item);
  }

  static Future insertItem(String item) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(kAPI_Chave_Token)!;
    return await http.post(Uri.parse(baseUrl), headers: {'Authorization': token, 'Content-Type': 'application/json'}, body: item);
  }

  static Future deleteItem(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(kAPI_Chave_Token)!;
    return await http.delete(Uri.parse('$baseUrl/$id'), headers: {'Authorization': token});
  }
}

class ListaPessoas2 extends StatefulWidget {
  const ListaPessoas2({Key? key}) : super(key: key);
  @override
  _ListaPessoas2State createState() => _ListaPessoas2State();
}

class _ListaPessoas2State extends State<ListaPessoas2> {
  var pessoas = <PessoaModel2>[];
  _getList() {
    API.getList().then((response) {
      setState(() {
        Iterable lista = json.decode(response.body)['data'];
        pessoas = lista.map((model) => PessoaModel2.fromJson(model)).toList();
        _passageiroLista = pessoas;
        _loading = false;
      });
    });
  }

  _ListaPessoas2State() {
    _getList();
  }

  AutenticacaoService apiLogin = AutenticacaoService();
  List<PessoaModel2> _passageiroLista = [];

  bool _loading = true;

  @override
  void initState() {
    super.initState();

    setState(() {
      _getList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Lista de Passageiros'),
        ),
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: Column(
            children: [
              Container(
                  decoration: BoxDecoration(color: Colors.blue, border: Border.all(width: 0.0, color: Color.fromARGB(206, 255, 255, 255))),
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(15, 50, 15, 15),
                  child: Text("Usuário Luiz", style: Theme.of(context).textTheme.titleLarge)),
              Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                  alignment: Alignment.centerLeft,
                  height: 50.0,
                  child: TextButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    onPressed: () => apiLogin.desconectarUsuario(context),
                    child: Row(children: [
                      const Icon(Icons.exit_to_app, color: Colors.black),
                      Text(" Sair", style: Theme.of(context).textTheme.titleMedium),
                    ]),
                  )),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(child: Icon(Icons.add), onPressed: _adicionaNovoPassageiro),
        body: Padding(
          padding: const EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: _buildPassageiroLista(),
        ));
  }

  Widget _buildPassageiroLista() {
    if (_passageiroLista.isEmpty) {
      return Center(
        child: _loading ? CircularProgressIndicator() : Text("Nenhum passageiro."),
      );
    } else {
      return ListView.builder(
        itemBuilder: _buildPassageiroItemSlidable,
        itemCount: _passageiroLista.length,
      );
    }
  }

  Widget _buildPassageiroItem(BuildContext context, int index) {
    final passageiro = _passageiroLista[index];
    return CheckboxListTile(
      title: Text(passageiro.nomePessoa.toString()),
      value: passageiro.presencaPessoa == '1',
      subtitle: Text(passageiro.telefone1Pessoa.toString() + ' ' + passageiro.emailPessoa.toString()),
      onChanged: (taMarcado) {
/*         Navigator.push(context,
            MaterialPageRoute(builder: (context) => FotografarPessoa()));
 */
        setState(() {
          passageiro.presencaPessoa = (taMarcado == true ? '1' : '0');
        });
        try {
          //_tabelaPassageiro.update(passageiro);
          API.updateItem(passageiro.idPessoa.toString(), passageiro.toJson().toString());
        } catch (e) {
          const AlertDialog(
            title: Text("Erro"),
            content: Text("Falha ao tentar atualizar passageiro!"),
          );
        }
      },
    );
  }

  Widget _buildPassageiroItemSlidable(BuildContext context, int index) {
    return Slidable(
      startActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.25,
        children: [
          SlidableAction(
            label: 'Editar',
            backgroundColor: Colors.blue,
            icon: Icons.edit,
            onPressed: (context) {
              _adicionaNovoPassageiro(passageiroAlterado: _passageiroLista[index], index: index);
            },
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.25,
        children: [
          SlidableAction(
            label: 'Remover',
            backgroundColor: Colors.red,
            icon: Icons.delete,
            onPressed: (context) {
              _removePassageiro(removePassageiro: _passageiroLista[index], index: index);
            },
          ),
        ],
      ),
      child: _buildPassageiroItem(context, index),
    );
  }

  Future _adicionaNovoPassageiro({PessoaModel2? passageiroAlterado, int? index}) async {
    PessoaModel2? passageiro = await Navigator.push(context, MaterialPageRoute(builder: (context) => PassageiroForm2(passageiro: passageiroAlterado)));
    if (passageiro != null) {
      setState(() {
        if (index == null) {
          try {
            //_tabelaPassageiro.save(passageiro).then((obj) => _passageiroLista.add(obj));
            API.insertItem(passageiro.toJson().toString());
          } catch (e) {
            const AlertDialog(
              title: Text("Erro"),
              content: Text("Falha ao salvar novo passageiro!"),
            );
          }
        } else {
          _passageiroLista[index] = passageiro;
          try {
            //_tabelaPassageiro.update(passageiro);
            API.updateItem(passageiro.idPessoa.toString(), passageiro.toJson().toString());
          } catch (e) {
            const AlertDialog(
              title: Text("Erro"),
              content: Text("Falha ao tentar atualizar passageiro!"),
            );
          }
        }
      });
    }
  }

  void _removePassageiro({required PessoaModel2 removePassageiro, required int index}) {
    setState(() {
      _passageiroLista.removeAt(index);
    });

    try {
      //_tabelaPassageiro.delete(removePassageiro.id!);
      API.deleteItem(removePassageiro.idPessoa.toString());
    } catch (e) {
      const AlertDialog(
        title: Text("Erro"),
        content: Text("Falha ao tentar remover passageiro!"),
      );
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Passageiro \"${removePassageiro.nomePessoa}\" removido."),
      action: SnackBarAction(
        label: "Desfazer",
        onPressed: () {
          setState(() {
            _passageiroLista.insert(index, removePassageiro);
            try {
              //_tabelaPassageiro.update(removePassageiro);
            } catch (e) {
              AlertDialog(
                title: Text("Erro"),
                content: Text("Falha ao tentar restaurar passageiro!"),
                actions: [
                  TextButton(
                    onPressed: () => voltarTelaAnterior,
                    child: const Text('Ok'),
                  ),
                ],
              );
            }
          });
        },
      ),
    ));
  }

  void voltarTelaAnterior() {
    Navigator.pop(context);
  }
}
