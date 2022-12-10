import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:string_validator/string_validator.dart' as validador;

import '../constantes.dart';
import '../model/empresas_model.dart';
import '../model/pessoas_model.dart';
import '../service/pessoas_service.dart';
import '../service/usuarios_service.dart';

class CadastrarPessoa extends StatefulWidget {
  final String pessoaComoUmUsuario;

  const CadastrarPessoa({super.key, required this.pessoaComoUmUsuario});
  @override
  _CadastrarPessoaState createState() => _CadastrarPessoaState();
}

class _CadastrarPessoaState extends State<CadastrarPessoa> {
  late final TextEditingController _cUsuario,
      _cSenha,
      _cSenha2,
      _cNome,
      _cEmail,
      _cTelefone,
      _cIdentidade,
      _cEmpresaNome,
      _cEmpresaIdentidade;

  @override
  void initState() {
    super.initState();
    _cUsuario = TextEditingController();
    _cSenha = TextEditingController();
    _cSenha2 = TextEditingController();
    _cNome = TextEditingController();
    _cEmail = TextEditingController();
    _cTelefone = TextEditingController();
    _cIdentidade = TextEditingController();
    _cEmpresaNome = TextEditingController();
    _cEmpresaIdentidade = TextEditingController();
  }

  @override
  void dispose() {
    _cUsuario.dispose();
    _cSenha.dispose();
    _cSenha2.dispose();
    _cNome.dispose();
    _cEmail.dispose();
    _cTelefone.dispose();
    _cIdentidade.dispose();
    _cEmpresaNome.dispose();
    _cEmpresaIdentidade.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 120.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        kAplicativoNome,
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Cadastro',
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      _bldEmpresaNome(),
                      _bldEmpresaIdentidade(),
                      _bldNome(),
                      _bldEmail(),
                      _bldTelefone(),
                      _bldIdentidade(),
                      _bldUsuario(),
                      _bldSenha(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _bldCadastrarBtn(context),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _bldEmpresaNome() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Empresa de Ônibus:',
          style: kEtiquetaCampoEstilo_1,
        ),
        Container(
          alignment: Alignment.centerLeft,
          height: 60.0,
          child: TextField(
            controller: _cEmpresaNome,
            keyboardType: TextInputType.name,
            style: TextStyle(
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.person,
                color: Colors.red,
              ),
              hintText: 'Informe nome da empresa',
              hintStyle: kDicaEstilo_1,
            ),
          ),
        ),
      ],
    );
  }

  Widget _bldEmpresaIdentidade() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          height: 60.0,
          child: TextField(
            controller: _cEmpresaIdentidade,
            keyboardType: TextInputType.number,
            maxLength: 20,
            style: TextStyle(
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.perm_identity,
                color: Colors.red,
              ),
              hintText: 'Informe o CNPJ da empresa',
              hintStyle: kDicaEstilo_1,
            ),
          ),
        ),
      ],
    );
  }

  Widget _bldNome() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Pessoa Monitora:',
          style: kEtiquetaCampoEstilo_1,
        ),
        Container(
          alignment: Alignment.centerLeft,
          height: 60.0,
          child: TextField(
            controller: _cNome,
            keyboardType: TextInputType.name,
            style: TextStyle(
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.person,
                color: Colors.red,
              ),
              hintText: 'Informe seu nome completo',
              hintStyle: kDicaEstilo_1,
            ),
          ),
        ),
      ],
    );
  }

  Widget _bldEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          height: 60.0,
          child: TextField(
            controller: _cEmail,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.red,
              ),
              hintText: 'Informe um e-Mail',
              hintStyle: kDicaEstilo_1,
            ),
          ),
        ),
      ],
    );
  }

  Widget _bldTelefone() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          height: 60.0,
          child: TextField(
            controller: _cTelefone,
            keyboardType: TextInputType.phone,
            maxLength: 11,
            style: TextStyle(
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.phone,
                color: Colors.red,
              ),
              hintText: 'Informe um telefone',
              hintStyle: kDicaEstilo_1,
            ),
          ),
        ),
      ],
    );
  }

  Widget _bldIdentidade() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          height: 60.0,
          child: TextField(
            controller: _cIdentidade,
            keyboardType: TextInputType.number,
            maxLength: 20,
            style: TextStyle(
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.perm_identity,
                color: Colors.red,
              ),
              hintText: 'Informe sua identidade(CPF)',
              hintStyle: kDicaEstilo_1,
            ),
          ),
        ),
      ],
    );
  }

  Widget _bldUsuario() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Usuário:',
          style: kEtiquetaCampoEstilo_1,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          height: 60.0,
          child: TextField(
            controller: _cUsuario,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock_person_outlined,
                color: Colors.red,
              ),
              hintText: 'Informe nome de usuário',
              hintStyle: kDicaEstilo_1,
            ),
          ),
        ),
      ],
    );
  }

  Widget _bldSenha() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Senha:',
          style: kEtiquetaCampoEstilo_1,
        ),
        Container(
          alignment: Alignment.centerLeft,
          height: 60.0,
          child: TextField(
            controller: _cSenha,
            keyboardType: TextInputType.text,
            obscureText: true,
            style: TextStyle(
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.password,
                color: Colors.red,
              ),
              hintText: 'Informe uma senha',
              hintStyle: kDicaEstilo_1,
            ),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          height: 60.0,
          child: TextField(
            controller: _cSenha2,
            obscureText: true,
            style: TextStyle(
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.password,
                color: Colors.red,
              ),
              hintText: 'Repita a senha',
              hintStyle: kDicaEstilo_1,
            ),
          ),
        ),
      ],
    );
  }

  Widget _bldCadastrarBtn(context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          var lValido = bldValidacao();
          if (lValido) {
            // cadastrar usuário e retornar à tela de login
            bldFinalizaCadastro(context, widget.pessoaComoUmUsuario);
            //.then((value) => Navigator.pop(context));
          }
        },
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        child: Text(
          'Cadastrar',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  bool bldValidacao() {
    var lValido = true;
    if (_cNome.text.isEmpty || _cNome.text.length < 5 || validador.isNumeric(_cNome.text)) {
      Flushbar(
        title: 'Nome inválido!',
        message: 'O nome precisa possuir letras e ter o mínimo de 5 caracteres!',
        duration: const Duration(seconds: 5),
      ).show(context);
      lValido = false;
    } else if (_cEmail.text.isEmpty || !validador.isEmail(_cEmail.text)) {
      Flushbar(
        title: 'E-mail inválido!',
        message: 'Informe, corretamente, um endereço de correio eletrônico(e-mail)!',
        duration: const Duration(seconds: 5),
      ).show(context);
      lValido = false;
    } else if (_cTelefone.text.isEmpty || _cTelefone.text.length < 10 || !validador.isNumeric(_cTelefone.text)) {
      Flushbar(
        title: 'Telefone inválido!',
        message: 'Informe, corretamente, um telefone!',
        duration: const Duration(seconds: 5),
      ).show(context);
      lValido = false;
    } else if (_cIdentidade.text.isEmpty || _cIdentidade.text.length < 11 || !validador.isNumeric(_cIdentidade.text)) {
      Flushbar(
        title: 'Identidade inválida!',
        message: 'Informe, corretamente, a identidade!',
        duration: const Duration(seconds: 5),
      ).show(context);
      lValido = false;
    } else if (_cUsuario.text.isEmpty || _cUsuario.text.length < 4 || validador.isNumeric(_cUsuario.text)) {
      Flushbar(
        title: 'Usuário inválido!',
        message: 'Informe, corretamente, um nome de usuário de acesso ao sistema!',
        duration: const Duration(seconds: 5),
      ).show(context);
      lValido = false;
    } else if (_cSenha.text.isEmpty ||
        _cSenha.text.length < 8 ||
        validador.isNumeric(_cSenha.text) ||
        validador.isAlpha(_cSenha.text) ||
        validador.isAlphanumeric(_cSenha.text)) {
      Flushbar(
        title: 'Senha não permitida!',
        message:
            'A senha precisa ter o mínimo de 8 caracteres contendo letras e números e pelo menos um caracter diferente de letra e número!',
        duration: const Duration(seconds: 5),
      ).show(context);
      lValido = false;
    } else if (_cSenha2.text != _cSenha.text) {
      Flushbar(
        title: 'Senha não confere!',
        message: 'A segunda senha está diferente da primeira informada!',
        duration: const Duration(seconds: 5),
      ).show(context);
      lValido = false;
    } else if (_cEmpresaIdentidade.text.isEmpty || _cEmpresaIdentidade.text.length < 11 || !validador.isNumeric(_cEmpresaIdentidade.text)) {
      Flushbar(
        title: 'Identidade inválida!',
        message: 'Informe, corretamente, a identidade!',
        duration: const Duration(seconds: 5),
      ).show(context);
      lValido = false;
    } else if (_cEmpresaNome.text.isEmpty || _cEmpresaNome.text.length < 4 || validador.isNumeric(_cEmpresaNome.text)) {
      Flushbar(
        title: 'Nome da empresa inválido!',
        message: 'O nome da empresa precisa possuir letras e ter o mínimo de 4 caracteres!',
        duration: const Duration(seconds: 5),
      ).show(context);
      lValido = false;
    }
    return lValido;
  }

  Future<Result> bldFinalizaCadastro(context, tipoCadastro) async {
    var resultado;
    var empresaVinculo = Empresas(idEmpresa: 0, nomeEmpresa: _cEmpresaNome.text, identidadeEmpresa: _cEmpresaIdentidade.text);

    // Se o cadastro é de um usuário, acessar endpoint usuarios
    if (tipoCadastro == 'usuário') {
      var pes = Pessoas(
          idPessoa: 0,
          nomePessoa: _cNome.text,
          emailPessoa: _cEmail.text,
          telefone1Pessoa: _cTelefone.text,
          identidadePessoa: _cIdentidade.text,
          usuarioPessoa: _cUsuario.text,
          senhaPessoa: _cSenha.text,
          tipoPessoa: 'A',
          empresa: empresaVinculo);
      try {
        resultado = await UsuariosService.inserirUsuario(pessoa: pes);
      } catch (e) {
        if (kDebugMode) {
          print('Erro cadastro endpoint usuarios: $e');
        }
      }
    }

    // Se o cadastro é de uma pesssoa assunto geral, acessar endpoint pessoas
    if (tipoCadastro == '') {
      var api = PessoasService();
      var pes = Pessoas(
          idPessoa: 0,
          nomePessoa: _cNome.text,
          emailPessoa: _cEmail.text,
          telefone1Pessoa: _cTelefone.text,
          identidadePessoa: _cIdentidade.text,
          usuarioPessoa: _cUsuario.text,
          senhaPessoa: _cSenha.text,
          tipoPessoa: 'P',
          empresa: empresaVinculo);
      try {
        resultado = await api.inserirPessoa(pessoa: pes);
      } catch (e) {
        if (kDebugMode) {
          print('Erro cadastro endpoint pessoas: $e');
        }
      }
    }

    if (resultado == null || resultado.isError()) {
      String erro;
      if (resultado == null) {
        erro = 'Erro cadastro do endpoint usuarios! ';
      } else {
        erro = resultado.getError().toString();
      }
      Flushbar(
        title: 'Falha na inserção!',
        message: erro,
        duration: const Duration(seconds: 5),
      ).show(context);
      return resultado;
    } else {
      if (kDebugMode) {
        print('retorno: ${resultado.getSuccess()}');
      }
      Flushbar(
        title: 'Sucesso!',
        message: 'Cadastro realizado com sucesso!',
        duration: const Duration(seconds: 5),
      ).show(context);
    }
    return resultado;
  }
}
