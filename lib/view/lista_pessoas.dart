import 'dart:async';
import 'dart:convert';

import 'package:url_launcher/url_launcher_string.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../constantes.dart';
import '../model/pessoas_model2.dart';
import '../service/autenticacao_service.dart';
import 'passageiro_form.dart';

const baseUrl = "$kAPI_URI_Base/pessoas";

class API {
  static Future getListItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(kAPI_Chave_Token)!;
    var parametros = "?itensPorPagina=60";
    var resposta = await http.get(Uri.parse(baseUrl + parametros), headers: {'Authorization': token});
    if (kDebugMode) {
      print('===== getListItems =====');
      print('Status code: ${resposta.statusCode}');
      print('Body: ${resposta.body}');
      print('---------------------');
    }
    return resposta;
  }

  static Future updateItem(PessoaModel2 item) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(kAPI_Chave_Token)!;
    var resposta = await http.put(Uri.parse('$baseUrl/${item.idPessoa}'),
        headers: {'Authorization': token, 'Content-Type': 'application/json'}, body: jsonEncode(item));
    if (kDebugMode) {
      print('===== updateItem =====');
      print('Status code: ${resposta.statusCode}');
      print('Body: ${resposta.body}');
      print('---------------------');
    }
    return resposta;
  }

  static Future insertItem(PessoaModel2 item) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(kAPI_Chave_Token)!;
    var resposta =
        await http.post(Uri.parse(baseUrl), headers: {'Authorization': token, 'Content-Type': 'application/json'}, body: jsonEncode(item));
    if (kDebugMode) {
      print('===== insertItem =====');
      print('Status code: ${resposta.statusCode}');
      print('Body: ${resposta.body}');
      print('---------------------');
    }
    return resposta;
  }

  static Future deleteItem(PessoaModel2 item) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(kAPI_Chave_Token)!;
    var resposta = await http.delete(Uri.parse('$baseUrl/${item.idPessoa}'), headers: {'Authorization': token});
    if (kDebugMode) {
      print('===== deleteItem =====');
      print('Status code: ${resposta.statusCode}');
      print('Body: ${resposta.body}');
      print('---------------------');
    }
    return resposta;
  }
}

class ListaPessoas extends StatefulWidget {
  const ListaPessoas({Key? key}) : super(key: key);
  @override
  _ListaPessoasState createState() => _ListaPessoasState();
}

class _ListaPessoasState extends State<ListaPessoas> {
  var listaPessoas = <PessoaModel2>[];
  _getList() {
    API.getListItems().then((response) {
      setState(() {
        Iterable lista = jsonDecode(response.body)['data'];
        listaPessoas = lista.map((modelo) => PessoaModel2.fromJson(modelo)).toList();
        _passageiroLista = listaPessoas;
        _loading = false;
      });
    });
  }

  _ListaPessoasState() {
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
        floatingActionButton: FloatingActionButton(child: Icon(Icons.add), onPressed: _adicionaEditaPassageiro),
        body: Padding(
          padding: const EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: _buildPassageiroLista(),
        ));
  }

  Widget _buildPassageiroLista() {
    var endereco;
    if (_passageiroLista.isEmpty) {
      return Center(
        child: _loading ? CircularProgressIndicator() : Text("Nenhum passageiro."),
      );
    } else {
      return ListView.separated(
        itemBuilder: _buildPassageiroItemSlidable,
        separatorBuilder: (context, index) => Divider(
          height: 20,
          thickness: 2,
        ),
        itemCount: _passageiroLista.length,
      );
    }
  }

  Widget _buildPassageiroItem(BuildContext context, int index) {
    final passageiro = _passageiroLista[index];
    var endereco =
        '${_passageiroLista[index].enderecoBairroPessoa ?? ''} ${_passageiroLista[index].enderecoMunicipioPessoa ?? ''} ${_passageiroLista[index].enderecoUFPessoa ?? ''} ${_passageiroLista[index].enderecoCEPPessoa ?? ''}';
    return ListTile(
      leading: avatarPassageiro(),
      title: Row(
        children: [
          Text('  ${passageiro.nomePessoa}'),
        ],
      ),
      subtitle: Text(endereco),
      trailing: Checkbox(
        value: passageiro.presencaPessoa == '1',
        onChanged: (taMarcado) {
          /* Navigator.push(context,
            MaterialPageRoute(builder: (context) => FotografarPessoa())); */
          setState(() {
            passageiro.presencaPessoa = (taMarcado == true ? '1' : '0');
          });
          try {
            API.updateItem(passageiro);
          } catch (e) {
            const AlertDialog(
              title: Text("Erro"),
              content: Text("Falha ao tentar atualizar passageiro!"),
            );
          }
        },
      ),
    );
  }

  Widget _buildPassageiroItemSlidable(BuildContext context, int index) {
    var endereco =
        '${_passageiroLista[index].enderecoLogradouroPessoa ?? ''}, ${_passageiroLista[index].enderecoNumeroPessoa ?? ''}, ${_passageiroLista[index].enderecoBairroPessoa ?? ''}, ${_passageiroLista[index].enderecoMunicipioPessoa ?? ''}, ${_passageiroLista[index].enderecoUFPessoa ?? ''}, ${_passageiroLista[index].enderecoCEPPessoa ?? ''}';
    var mensagem = "Olá!";
    var codigoPais = "+55";
    var telefone = codigoPais + _passageiroLista[index].telefone1Pessoa!;
    return Slidable(
      startActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.25,
        children: [
          SlidableAction(
            label: 'Localizar',
            backgroundColor: Colors.yellow,
            icon: Icons.map,
            onPressed: (context) async {
              var url = "geo:0,0?q=$endereco";
              try {
                await launchUrlString(url);
              } catch (e) {
                if (kDebugMode) {
                  print("Algo deu errado ao tentar iniciar mapa! Erro: $e");
                }
              }
            },
          ),
          SlidableAction(
            label: 'Chamar',
            backgroundColor: Colors.green,
            icon: Icons.phone,
            onPressed: (context) async {
              var url = "whatsapp://send?phone=$telefone&text=$mensagem";
              try {
                await launchUrlString(url);
              } catch (e) {
                if (kDebugMode) {
                  print("Algo deu errado ao tentar fazer contato! Erro: $e");
                }
              }
            },
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.25,
        children: [
          SlidableAction(
            label: 'Editar',
            backgroundColor: Colors.blue,
            icon: Icons.edit,
            onPressed: (context) {
              _adicionaEditaPassageiro(passageiroAlterado: _passageiroLista[index], index: index);
            },
          ),
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

  Future _adicionaEditaPassageiro({PessoaModel2? passageiroAlterado, int? index}) async {
    PessoaModel2? passageiro =
        await Navigator.push(context, MaterialPageRoute(builder: (context) => PassageiroForm(passageiro: passageiroAlterado)));
    if (passageiro != null) {
      setState(() {
        if (index == null) {
          try {
            //_tabelaPassageiro.save(passageiro).then((obj) => _passageiroLista.add(obj));
            API.insertItem(passageiro);
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
            API.updateItem(passageiro);
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
      API.deleteItem(removePassageiro);
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
                title: Text("Erro na Restauração"),
                content: Text("Falha ao tentar restaurar o passageiro!"),
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

  avatarPassageiro() {
/*     try {
      return const CircleAvatar(
        foregroundImage: NetworkImage('$kAPI_URL_Arquivos/users/103.jpg'),
/*         onForegroundImageError: (_, __) {
          print('erro');
          return null;
        },
 */
      );
    } catch (e) {
      try {
        print('O carregamento da imagem 103.jpg falhou. Tentando carregar default.gif: $e');
        return const CircleAvatar(
          foregroundImage: NetworkImage('$kAPI_URL_Arquivos/users/default.gif'),
        );
      } catch (e) {
        if (kDebugMode) {
          print('Erro no carregamento de imagem de avatar: $e');
        }
      }
    }
 */
    return null;
  }
}
