import 'package:flutter/material.dart';
import '../model/passageiro.dart';

class PassageiroDialog extends StatefulWidget {
  final Passageiro? passageiro;

  // Construtor para receber um passageiro quando precisar edita-lo
  const PassageiroDialog({super.key, this.passageiro});

  @override
  _PassageiroDialogState createState() => _PassageiroDialogState();
}

class _PassageiroDialogState extends State<PassageiroDialog> {
  final _idPassageiro = TextEditingController();
  final _nomePassageiro = TextEditingController();

  Passageiro _atualPassageiro = Passageiro();

  @override
  void initState() {
    super.initState();

    // Verifica se foi enviado algum passageiro para edição
    // Caso queira editar, copia-se o passageiro
    if (widget.passageiro != null) {
      print(widget.passageiro!.toMap());
      _atualPassageiro = Passageiro.fromMap(widget.passageiro!.toMap());
      _idPassageiro.text = _atualPassageiro.id.toString();
      _nomePassageiro.text = _atualPassageiro.nome!;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _idPassageiro.clear();
    _nomePassageiro.clear();
  }

  @override
  Widget build(BuildContext context) {
    ;
    return AlertDialog(
      title: Text(widget.passageiro == null
          ? 'Adicionar passageiro'
          : 'Editar passageiro'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (widget.passageiro != null)
            TextField(
              controller: _idPassageiro,
              decoration: InputDecoration(labelText: 'Código'),
              enabled: false,
            ),
          TextField(
              controller: _nomePassageiro,
              decoration: InputDecoration(labelText: 'Nome'),
              autofocus: true),
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
            _atualPassageiro.nome = _nomePassageiro.text;
            Navigator.of(context).pop(_atualPassageiro);
          },
        ),
      ],
    );
  }
}
