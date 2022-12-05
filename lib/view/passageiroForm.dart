import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../model/passageiroModel.dart';

class PassageiroForm extends StatefulWidget {
  final Passageiro? passageiro;
  const PassageiroForm({super.key, this.passageiro});

  @override
  State<PassageiroForm> createState() => _PassageiroFormState();
}

class _PassageiroFormState extends State<PassageiroForm> {
  final GlobalKey<FormState> _key = GlobalKey();
  final _id = TextEditingController();
  final _nome = TextEditingController();
  final _email = TextEditingController();
  final _telefone = TextEditingController();
  final _enderecoLogradouro = TextEditingController();
  final _enderecoNumero = TextEditingController();
  final _enderecoBairro = TextEditingController();
  final _enderecoMunicipio = TextEditingController();
  final _enderecoUF = TextEditingController();
  final _enderecoCEP = TextEditingController();

  Passageiro _atualPassageiro = Passageiro();

  @override
  void initState() {
    super.initState();

    // Verifica se foi enviado algum passageiro para edição
    // Caso queira editar, copia-se o passageiro
    if (widget.passageiro != null) {
      _atualPassageiro = Passageiro.fromJson(widget.passageiro!.toJson());
      _id.text = _atualPassageiro.id.toString();
      _nome.text = _atualPassageiro.nome!;
      _email.text = _atualPassageiro.email!;
      _telefone.text = _atualPassageiro.telefone!;
      _enderecoLogradouro.text = _atualPassageiro.enderecoLogradouro!;
      _enderecoNumero.text = _atualPassageiro.enderecoNumero!;
      _enderecoBairro.text = _atualPassageiro.enderecoBairro!;
      _enderecoMunicipio.text = _atualPassageiro.enderecoMunicipio!;
      _enderecoUF.text = _atualPassageiro.enderecoUF!;
      _enderecoCEP.text = _atualPassageiro.enderecoCEP!;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _id.clear();
    _nome.clear();
    _email.clear();
    _telefone.clear();
    _enderecoLogradouro.clear();
    _enderecoNumero.clear();
    _enderecoBairro.clear();
    _enderecoMunicipio.clear();
    _enderecoUF.clear();
    _enderecoCEP.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
                '${widget.passageiro != null ? 'Editar' : 'Adicionar'} um Passageiro')),
        body: Material(
            child: SingleChildScrollView(
          child: Center(
            heightFactor: 1,
            child: Shortcuts(
              shortcuts: const <ShortcutActivator, Intent>{
                SingleActivator(LogicalKeyboardKey.enter): NextFocusIntent(),
              },
              child: FocusTraversalGroup(
                child: Form(
                  key: _key,
                  autovalidateMode: AutovalidateMode.always,
                  onChanged: () {
                    Form.of(primaryFocus!.context!)!.save();
                  },
                  child: _formUI(),
                ),
              ),
            ),
          ),
        )));
  }

  Widget _formUI() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (_id.text.isNotEmpty)
          TextFormField(
            controller: _id,
            decoration: InputDecoration(labelText: 'Código'),
            enabled: false,
          ),
        TextFormField(
          controller: _nome,
          decoration: InputDecoration(
              hintText: 'Informe nome completo', labelText: 'Nome'),
          maxLength: 45,
          validator: _validarNome,
        ),
        TextFormField(
          controller: _telefone,
          decoration: InputDecoration(
              hintText: 'Informe seu telefone celular',
              labelText: 'Telefone celular'),
          keyboardType: TextInputType.phone,
          maxLength: 11,
          validator: _validarTelefone,
        ),
        TextFormField(
          controller: _email,
          decoration: InputDecoration(labelText: 'E-mail'),
          keyboardType: TextInputType.emailAddress,
          maxLength: 45,
          validator: _validarEmail,
        ),
        TextFormField(
          controller: _enderecoCEP,
          decoration: InputDecoration(labelText: 'CEP'),
          keyboardType: TextInputType.number,
          maxLength: 8,
        ),
        TextFormField(
          controller: _enderecoLogradouro,
          decoration: InputDecoration(labelText: 'Endereço'),
          maxLength: 45,
        ),
        TextFormField(
          controller: _enderecoNumero,
          decoration: InputDecoration(
              hintText: 'Informe o número do endereço', labelText: 'Número'),
          keyboardType: TextInputType.number,
          maxLength: 10,
        ),
        TextFormField(
          controller: _enderecoBairro,
          decoration: InputDecoration(labelText: 'Bairro'),
          maxLength: 45,
        ),
        TextFormField(
          controller: _enderecoMunicipio,
          decoration: InputDecoration(
              hintText: 'Informe o nome do seu município/cidade',
              labelText: 'Município'),
          maxLength: 45,
        ),
        TextFormField(
          controller: _enderecoUF,
          decoration: InputDecoration(labelText: 'Estado'),
          maxLength: 2,
        ),
        SizedBox(height: 15.0),
        ElevatedButton(
          onPressed: _sendForm,
          child: Text('Salvar'),
        )
      ],
    );
  }

  String? _validarNome(String? value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = RegExp(patttern);
    if (value?.length == 0) {
      return "Informe o nome";
    } else if (!regExp.hasMatch(value!)) {
      return "O nome deve conter caracteres de a-z ou A-Z";
    }
    return null;
  }

  String? _validarTelefone(String? value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = RegExp(patttern);
    if (value?.length == 0) {
      return "Informe o telefone celular";
    } else if (value?.length != 11) {
      return "O telefone deve ter 11 dígitos";
    } else if (!regExp.hasMatch(value!)) {
      return "O número do telefone só deve conter dígitos";
    }
    return null;
  }

  String? _validarEmail(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (value?.length == 0) {
      return "Informe o Email";
    } else if (!regExp.hasMatch(value!)) {
      return "Email inválido";
    } else {
      return null;
    }
  }

  _sendForm() {
    if (_key.currentState!.validate()) {
      // Sem erros na validação
      _key.currentState!.save();
      _atualPassageiro.nome = _nome.text;
      _atualPassageiro.telefone = _telefone.text;
      _atualPassageiro.email = _email.text;
      _atualPassageiro.enderecoCEP = _enderecoCEP.text;
      _atualPassageiro.enderecoLogradouro = _enderecoLogradouro.text;
      _atualPassageiro.enderecoNumero = _enderecoNumero.text;
      _atualPassageiro.enderecoBairro = _enderecoBairro.text;
      _atualPassageiro.enderecoMunicipio = _enderecoMunicipio.text;
      _atualPassageiro.enderecoUF = _enderecoUF.text;
      Navigator.of(context).pop(_atualPassageiro);
      return;
    }
  }
}
