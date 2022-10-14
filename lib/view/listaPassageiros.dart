import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:monibus/view/fotografarPessoa.dart';
import '/domain/entity/passageiro_entity.dart';
import '/model/passageiro.dart';
import '/view/passageiro_dialog.dart';

class ListaPassageiros extends StatefulWidget {
  const ListaPassageiros({Key? key}) : super(key: key);
  @override
  _ListaPassageirosState createState() => _ListaPassageirosState();
}

class _ListaPassageirosState extends State<ListaPassageiros> {
  List<Passageiro> _passageiroLista = [];
  PassageiroEntidade _tabelaPassageiro = PassageiroEntidade();
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    try {
      _tabelaPassageiro.getAll().then((list) {
        setState(() {
          _passageiroLista = list;
          _loading = false;
        });
      });
    } catch (e) {
      const AlertDialog(
        title: Text("Erro"),
        content: Text("Falha ao tentar obter lista de passageiros!"),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Passageiros')),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add), onPressed: _adicionaNovoPassageiro),
      body: _buildPassageiroLista(),
    );
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
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => FotografarPessoa()));
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
            label: 'Alterar',
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
            label: 'Excluir',
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
    final passageiro = await showDialog<Passageiro>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PassageiroDialog(passageiro: passageiroAlterado);
      },
    );

    if (passageiro != null) {
      setState(() {
        if (index == null) {
          _passageiroLista.add(passageiro);
          try {
            _tabelaPassageiro.save(passageiro);
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
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Tá'),
                  ),
                ],
              );
            }
          });
        },
      ),
    ));
  }
}
