import 'package:flutter/material.dart';
import '../model/passageiro.dart';

class PassageiroDialog extends StatefulWidget {
  final Passageiro passageiro;

  // Construtor para receber um passageiro quando precisar edita-lo
  const PassageiroDialog({super.key, this.passageiro});

  @override
  _PassageiroDialogState createState() => _PassageiroDialogState();
}

class _PassageiroDialogState extends State<PassageiroDialog> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  Passageiro _correntePassageiro = Passageiro();

  @override
  void initState() {
    super.initState();

    // Verifica se foi enviado alguma tarefa para edição
    // Caso queira editar, copia-se essa tarefa
    if (widget.passageiro != null) {
      _correntePassageiro = Passageiro.fromMap(widget.passageiro.toMap());
    }

    _titleController.text = _correntePassageiro.id.toString();
    _descriptionController.text = _correntePassageiro.nome.toString();
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.clear();
    _descriptionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
          widget.passageiro == null ? 'Novo passageiro' : 'Editar passageiro'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Título'),
              autofocus: true),
          TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Descrição')),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          child: Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          child: Text('Salvar'),
          onPressed: () {
            _correntePassageiro.id = _titleController.value.text as int;
            _correntePassageiro.nome = _descriptionController.text;

            Navigator.of(context).pop(_correntePassageiro);
          },
        ),
      ],
    );
  }
}
