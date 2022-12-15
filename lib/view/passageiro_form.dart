import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constantes.dart';
import '../model/pessoas_model2.dart';

const baseUrl = "$kAPI_URI_Base/pessoas";

class API {
  static Future consultItem(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(kAPI_Chave_Token)!;
    var resposta = await http.get(Uri.parse('$baseUrl/$id'), headers: {'Authorization': token});
    if (kDebugMode) {
      print('===== consultItem =====');
      print('Status code: ${resposta.statusCode}');
      print('Body: ${resposta.body}');
      print('---------------------');
    }
    return resposta;
  }
}

class PassageiroForm extends StatefulWidget {
  final PessoaModel2? passageiro;
  const PassageiroForm({super.key, this.passageiro});

  @override
  State<PassageiroForm> createState() => _PassageiroFormState();
}

class _PassageiroFormState extends State<PassageiroForm> {
  final GlobalKey<FormState> _key = GlobalKey();
  final _idPessoa = TextEditingController();
  final _nomePessoa = TextEditingController();
  final _emailPessoa = TextEditingController();
  final _identidadePessoa = TextEditingController();
  final _telefone1Pessoa = TextEditingController();
  final _enderecoLogradouroPessoa = TextEditingController();
  final _enderecoNumeroPessoa = TextEditingController();
  final _enderecoBairroPessoa = TextEditingController();
  final _enderecoMunicipioPessoa = TextEditingController();
  final _enderecoUFPessoa = TextEditingController();
  final _enderecoCEPPessoa = TextEditingController();
  String _presencaPessoa = '0';

  PessoaModel2 pessoaRecebida = PessoaModel2();

  PessoaModel2 _atualPassageiro = PessoaModel2();

  @override
  void initState() {
    super.initState();
    // Verifica se foi enviado algum passageiro para edição
    // Caso queira editar, copia-se o passageiro
    if (widget.passageiro != null) {
      _atualPassageiro = PessoaModel2.fromJson(widget.passageiro!.toJson());
      _idPessoa.text = _atualPassageiro.idPessoa.toString();
      _nomePessoa.text = _atualPassageiro.nomePessoa ?? '';
      _emailPessoa.text = _atualPassageiro.emailPessoa ?? '';
      _telefone1Pessoa.text = _atualPassageiro.telefone1Pessoa ?? '';
      _identidadePessoa.text = _atualPassageiro.identidadePessoa ?? '';
      _enderecoLogradouroPessoa.text = _atualPassageiro.enderecoLogradouroPessoa ?? '';
      _enderecoNumeroPessoa.text = _atualPassageiro.enderecoNumeroPessoa ?? '';
      _enderecoBairroPessoa.text = _atualPassageiro.enderecoBairroPessoa ?? '';
      _enderecoMunicipioPessoa.text = _atualPassageiro.enderecoMunicipioPessoa ?? '';
      _enderecoUFPessoa.text = _atualPassageiro.enderecoUFPessoa ?? '';
      _enderecoCEPPessoa.text = _atualPassageiro.enderecoCEPPessoa ?? '';
      _presencaPessoa = _atualPassageiro.presencaPessoa ?? '0';
    }
  }

  @override
  void dispose() {
    super.dispose();
    _idPessoa.clear();
    _nomePessoa.clear();
    _emailPessoa.clear();
    _telefone1Pessoa.clear();
    _identidadePessoa.clear();
    _enderecoLogradouroPessoa.clear();
    _enderecoNumeroPessoa.clear();
    _enderecoBairroPessoa.clear();
    _enderecoMunicipioPessoa.clear();
    _enderecoUFPessoa.clear();
    _enderecoCEPPessoa.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.passageiro != null ? 'Editar' : 'Adicionar'} um Passageiro')),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Material(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(25),
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _formUI() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (_idPessoa.text.isNotEmpty)
          TextFormField(
            controller: _idPessoa,
            decoration: const InputDecoration(labelText: 'Código'),
            enabled: false,
          ),
        TextFormField(
          controller: _nomePessoa,
          decoration: const InputDecoration(hintText: 'Informe nome completo', labelText: 'Nome'),
          maxLength: 45,
        ),
        TextFormField(
          controller: _identidadePessoa,
          decoration: const InputDecoration(hintText: 'Informe sua identidade', labelText: 'Identidade'),
          keyboardType: TextInputType.number,
          maxLength: 20,
          validator: _validarIdentidade,
        ),
        TextFormField(
          controller: _telefone1Pessoa,
          decoration: const InputDecoration(hintText: 'Informe seu telefone celular', labelText: 'Telefone celular'),
          keyboardType: TextInputType.phone,
          maxLength: 11,
          validator: _validarTelefone,
        ),
        TextFormField(
          controller: _emailPessoa,
          decoration: const InputDecoration(labelText: 'E-mail'),
          keyboardType: TextInputType.emailAddress,
          maxLength: 45,
          validator: _validarEmail,
        ),
        TextFormField(
          controller: _enderecoCEPPessoa,
          decoration: const InputDecoration(labelText: 'CEP'),
          keyboardType: TextInputType.number,
          maxLength: 8,
        ),
        TextFormField(
          controller: _enderecoLogradouroPessoa,
          decoration: const InputDecoration(labelText: 'Endereço'),
          maxLength: 45,
        ),
        TextFormField(
          controller: _enderecoNumeroPessoa,
          decoration: const InputDecoration(hintText: 'Informe o número do endereço', labelText: 'Número'),
          keyboardType: TextInputType.number,
          maxLength: 10,
        ),
        TextFormField(
          controller: _enderecoBairroPessoa,
          decoration: const InputDecoration(labelText: 'Bairro'),
          maxLength: 45,
        ),
        TextFormField(
          controller: _enderecoMunicipioPessoa,
          decoration: const InputDecoration(hintText: 'Informe o nome do seu município/cidade', labelText: 'Município'),
          maxLength: 45,
        ),
        TextFormField(
          controller: _enderecoUFPessoa,
          decoration: const InputDecoration(labelText: 'Estado'),
          maxLength: 2,
        ),
        const SizedBox(height: 15.0),
        ElevatedButton(
          onPressed: _sendForm,
          child: const Text('Salvar'),
        )
      ],
    );
  }

  String? _validarTelefone(String? value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = RegExp(patttern);
    if (value!.isEmpty) {
      return "Informe o telefone celular";
    } else if (value.length != 11) {
      return "O telefone deve ter 11 dígitos";
    } else if (!regExp.hasMatch(value)) {
      return "O número do telefone só deve conter dígitos";
    }
    return null;
  }

  String? _validarIdentidade(String? value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = RegExp(patttern);
    if (value!.isEmpty) {
      return "Informe sua identidade(CPF)";
    } else if (value.length < 11 && value.length > 20) {
      return "A identidade deve ter de 11 à 20 dígitos";
    } else if (!regExp.hasMatch(value)) {
      return "A identidade só deve conter dígitos numéricos";
    }
    return null;
  }

  String? _validarEmail(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (value!.isEmpty) {
      return "Informe o Email";
    } else if (!regExp.hasMatch(value)) {
      return "Email inválido";
    } else {
      return null;
    }
  }

  _sendForm() {
    if (_key.currentState!.validate()) {
      _key.currentState!.save();
      _atualPassageiro.nomePessoa = _nomePessoa.text;
      _atualPassageiro.identidadePessoa = _identidadePessoa.text;
      _atualPassageiro.telefone1Pessoa = _telefone1Pessoa.text;
      _atualPassageiro.emailPessoa = _emailPessoa.text;
      _atualPassageiro.enderecoCEPPessoa = _enderecoCEPPessoa.text;
      _atualPassageiro.enderecoLogradouroPessoa = _enderecoLogradouroPessoa.text;
      _atualPassageiro.enderecoNumeroPessoa = _enderecoNumeroPessoa.text;
      _atualPassageiro.enderecoBairroPessoa = _enderecoBairroPessoa.text;
      _atualPassageiro.enderecoMunicipioPessoa = _enderecoMunicipioPessoa.text;
      _atualPassageiro.enderecoUFPessoa = _enderecoUFPessoa.text;
      _atualPassageiro.presencaPessoa = _presencaPessoa;
      Navigator.of(context).pop(_atualPassageiro);
      return;
    }
  }
}
