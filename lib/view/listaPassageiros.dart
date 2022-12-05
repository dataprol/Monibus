import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../view/passageiroForm.dart';
import '../domain/entity/passageiroEntity.dart';
import '../model/passageiroModel.dart';
import '../service/autenticacaoService.dart';

class ListaPassageiros extends StatefulWidget {
  const ListaPassageiros({Key? key}) : super(key: key);
  @override
  _ListaPassageirosState createState() => _ListaPassageirosState();
}

class _ListaPassageirosState extends State<ListaPassageiros> {
  AutenticacaoService apiLogin = AutenticacaoService();
  List<Passageiro> _passageiroLista = [];
  PassageiroEntidade _tabelaPassageiro = PassageiroEntidade();
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _tabelaPassageiro.getAll().then((list) {
      setState(() {
        _passageiroLista = list;
        _loading = false;
      });
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
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      border: Border.all(
                          width: 0.0,
                          color: Color.fromARGB(206, 255, 255, 255))),
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(15, 50, 15, 15),
                  child: Text("Usuário X",
                      style: Theme.of(context).textTheme.titleLarge)),
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
                      Text(" Sair",
                          style: Theme.of(context).textTheme.titleMedium),
                    ]),
                  )),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add), onPressed: _adicionaNovoPassageiro),
        body: Padding(
          padding: const EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: _buildPassageiroLista(),
        ));
  }

  Widget _buildPassageiroLista() {
    if (_passageiroLista.isEmpty) {
      return Center(
        child:
            _loading ? CircularProgressIndicator() : Text("Nenhum passageiro."),
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
      value: passageiro.presenca == 1,
      title: Text(passageiro.id.toString()),
      subtitle: Text(passageiro.nome.toString()),
      onChanged: (taMarcado) {
/*         Navigator.push(context,
            MaterialPageRoute(builder: (context) => FotografarPessoa()));
 */
        setState(() {
          passageiro.presenca = (taMarcado == true ? 1 : 0);
        });
        try {
          _tabelaPassageiro.update(passageiro);
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
              _adicionaNovoPassageiro(
                  passageiroAlterado: _passageiroLista[index], index: index);
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
              _removePassageiro(
                  removePassageiro: _passageiroLista[index], index: index);
            },
          ),
        ],
      ),
      child: _buildPassageiroItem(context, index),
    );
  }

  Future _adicionaNovoPassageiro(
      {Passageiro? passageiroAlterado, int? index}) async {
    Passageiro? passageiro = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                PassageiroForm(passageiro: passageiroAlterado)));
    if (passageiro != null) {
      setState(() {
        if (index == null) {
          try {
            _tabelaPassageiro
                .save(passageiro)
                .then((obj) => _passageiroLista.add(obj));
          } catch (e) {
            const AlertDialog(
              title: Text("Erro"),
              content: Text("Falha ao salvar novo passageiro!"),
            );
          }
        } else {
          _passageiroLista[index] = passageiro;
          try {
            _tabelaPassageiro.update(passageiro);
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

  void _removePassageiro(
      {required Passageiro removePassageiro, required int index}) {
    setState(() {
      _passageiroLista.removeAt(index);
    });

    try {
      _tabelaPassageiro.delete(removePassageiro.id!);
    } catch (e) {
      const AlertDialog(
        title: Text("Erro"),
        content: Text("Falha ao tentar remover passageiro!"),
      );
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Passageiro \"${removePassageiro.nome}\" removido."),
      action: SnackBarAction(
        label: "Desfazer",
        onPressed: () {
          setState(() {
            _passageiroLista.insert(index, removePassageiro);
            try {
              _tabelaPassageiro.update(removePassageiro);
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
