import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '/helper/monibus_helper.dart';
import '/model/passageiro.dart';
import '/view/passageiro_dialog.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Passageiro> _passageiroLista = [];
  PassageiroHelper _helper = PassageiroHelper();
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _helper.getAll().then((list) {
      setState(() {
        _passageiroLista = list;
        _loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Tarefas')),
      floatingActionButton:
          FloatingActionButton(child: Icon(Icons.add), onPressed: _addNewTask),
      body: _buildTaskList(),
    );
  }

  Widget _buildTaskList() {
    if (_passageiroLista.isEmpty) {
      return Center(
        child: _loading ? CircularProgressIndicator() : Text("Sem tarefas!"),
      );
    } else {
      return ListView.builder(
        itemBuilder: _buildTaskItemSlidable,
        itemCount: _passageiroLista.length,
      );
    }
  }

  Widget _buildTaskItem(BuildContext context, int index) {
    final passageiro = _passageiroLista[index];
    return CheckboxListTile(
      value: passageiro.presenca,
      title: Text(passageiro.id.toString()),
      subtitle: Text(passageiro.nome.toString()),
      onChanged: (taMarcado) {
        setState(() {
          passageiro.presenca = taMarcado!;
        });
        _helper.update(passageiro);
      },
    );
  }

  Widget _buildTaskItemSlidable(BuildContext context, int index) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: _buildTaskItem(context, index),
      actions: <Widget>[
        IconSlideAction(
          caption: 'Editar',
          color: Colors.blue,
          icon: Icons.edit,
          onTap: () {
            _addNewTask(editedTask: _passageiroLista[index], index: index);
          },
        ),
        IconSlideAction(
          caption: 'Excluir',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {
            _deleteTask(deletedTask: _passageiroLista[index], index: index);
          },
        ),
      ],
    );
  }

  Future _addNewTask({Passageiro? editedTask, int? index}) async {
    final passageiro = await showDialog<Passageiro>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PassageiroDialog(passageiro: editedTask);
      },
    );

    if (passageiro != null) {
      setState(() {
        if (index == null) {
          _passageiroLista.add(passageiro);
          _helper.save(passageiro);
        } else {
          _passageiroLista[index] = passageiro;
          _helper.update(passageiro);
        }
      });
    }
  }

  void _deleteTask({required Passageiro deletedTask, required int index}) {
    setState(() {
      _passageiroLista.removeAt(index);
    });

    _helper.delete(deletedTask.id);

    Flushbar(
      title: "Exclusão de tarefas",
      message: "Tarefa \"${deletedTask.nome}\" removida.",
      margin: EdgeInsets.all(8),
      borderRadius: 8,
      duration: Duration(seconds: 3),
      mainButton: ElevatedButton(
        child: Text(
          "Desfazer",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          setState(() {
            _passageiroLista.insert(index, deletedTask);
            _helper.update(deletedTask);
          });
        },
      ),
    )..show(context);
  }
}
