import 'dart:collection';
import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:monibus/constantes.dart';
import 'package:monibus/view/cadastrar_pessoa.dart';
import 'package:monibus/view/recuperar_login.dart';
import '../model/autenticacao_model.dart';
import '../service/autenticacao_service.dart';
import 'lista_pessoas.dart';

class TelaLogin extends StatefulWidget {
  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  AutenticacaoService apiLogin = AutenticacaoService();
  late final TextEditingController _cUsuario, _cSenha;
  late String _cToken, _cUsuarioId, _cUsuarioLogin, _cUsuarioNome;
  late String _cUsuarioTipo, _cUsuarioIdentidade, _cUsuarioEmail, _cUsuarioTelefone;
  var _cUsuarioEmpresa;

  @override
  void initState() {
    super.initState();
    _cUsuario = TextEditingController();
    _cSenha = TextEditingController();
  }

  @override
  void dispose() {
    _cUsuario.dispose();
    _cSenha.dispose();
    super.dispose();
  }

  Widget _bldUsuario() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Usuário',
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
                Icons.email,
                color: Colors.red,
              ),
              hintText: 'Informe seu nome de usuário',
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
          'Senha',
          style: kEtiquetaCampoEstilo_1,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          height: 60.0,
          child: TextField(
            controller: _cSenha,
            obscureText: true,
            style: TextStyle(
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.red,
              ),
              hintText: 'Informe sua senha',
              hintStyle: kDicaEstilo_1,
            ),
          ),
        ),
      ],
    );
  }

  Widget _bldForgotPasswordBtn() {
    return GestureDetector(
      onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => TelaRecuperarSenha()))},
      child: Text(
        'Esqueceu a senha.',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _bldLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        child: Text(
          'Acessar',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
        onPressed: () {
          var login = _validarUsuario(context);
          if (login != false) {
            _autenticarUsuario(context, login);
          }
        },
      ),
    );
  }

  Widget _bldCadastrarBtn() {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CadastrarPessoa(
                      pessoaComoUmUsuario: 'usuário',
                    )))
      },
      child: const Text(
        'Cadastrar-se.',
        style: TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
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
              SizedBox(
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
                        'Acesso',
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      _bldUsuario(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _bldSenha(),
                      SizedBox(
                        height: 15.0,
                      ),
                      _bldLoginBtn(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _bldForgotPasswordBtn(),
                          SizedBox(
                            width: 50.0,
                          ),
                          _bldCadastrarBtn(),
                        ],
                      )
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

/*   _lerUsuarioMemLocal() {
    var loginUser = apiLogin.lerUsuarioMemLocal();
    return loginUser;
  }
 */
  _salvarUsuarioMemLocal(resposta) async {
    final prefs = await SharedPreferences.getInstance();
    _cToken = resposta['token'];
    _cUsuarioId = resposta['id'];
    _cUsuarioNome = resposta['nome'];
    _cUsuarioLogin = _cUsuario.text;
    _cUsuarioTipo = resposta['tipo'];
    _cUsuarioIdentidade = resposta['identidade'];
    _cUsuarioEmail = resposta['email'];
    _cUsuarioTelefone = resposta['telefone'];
    _cUsuarioEmpresa = resposta['empresa'];
    prefs.setString(kAPI_Chave_Token, _cToken);
    prefs.setString(kAPI_Chave_UsuarioId, _cUsuarioId);
    prefs.setString(kAPI_Chave_UsuarioNome, _cUsuarioNome);
    prefs.setString(kAPI_Chave_UsuarioLogin, _cUsuarioLogin);
    prefs.setString(kAPI_Chave_UsuarioTipo, _cUsuarioTipo);
    prefs.setString(kAPI_Chave_UsuarioIdentidade, _cUsuarioIdentidade);
    prefs.setString(kAPI_Chave_UsuarioTelefone, _cUsuarioTelefone);
    prefs.setString(kAPI_Chave_UsuarioEmail, _cUsuarioEmail);
    prefs.setString(kAPI_Chave_EmpresaId, _cUsuarioEmpresa[0]['id']);
    prefs.setString(kAPI_Chave_EmpresaNome, _cUsuarioEmpresa[0]['nome']);
    prefs.setString(kAPI_Chave_EmpresaNomeIdentidade, _cUsuarioEmpresa[0]['identidade']);
  }

  _validarUsuario(context) {
    var login = AutenticacaoModel(usuario: _cUsuario.text, senha: _cSenha.text);
    var lValido = true;

    if (!login.validoUsuario) {
      Flushbar(
        title: 'Usuário inválido!',
        message: 'O nome de usuário não pode conter somente números!',
        duration: const Duration(seconds: 5),
      ).show(context);
      lValido = false;
    } else if (!login.validoSenha) {
      Flushbar(
        title: 'Senha inválida!',
        message:
            'A senha precisa ter o mínimo de 8 caracteres contendo letras e números e pelo menos um caracter que não seja nem letra nem número!',
        duration: const Duration(seconds: 5),
      ).show(context);
      lValido = false;
    }

    return lValido ? login : false;
  }

  Future<void> _autenticarUsuario(context, AutenticacaoModel login) async {
    final resultado = await apiLogin.validarUsuario(login);

    if (resultado.isError()) {
      Flushbar(
        title: 'Falha de Autenticação!',
        message: resultado.getError(),
        duration: const Duration(seconds: 5),
      ).show(context);
      return;
    } else {
      // obter o token e armazenar
      var resposta = resultado.getSuccess()!.data['data'];
      if (resposta.isNotEmpty && resposta['token'].isNotEmpty) {
        _salvarUsuarioMemLocal(resposta);
        Navigator.push(context, MaterialPageRoute(builder: (context) => const ListaPessoas()));
      }
    }
  }

/*   Future<void> _validarToken(context, String token, String usuario) async {
    final resultado = await apiLogin.validarToken(token);

    if (resultado.isError()) {
      // Permanece na tela de login
      var resposta = resultado.getError();
      if (kDebugMode) {
        print('Resposta negativa: $resposta');
      }
    } else {
      var resposta = resultado.getSuccess()!.data['message'];
      resposta ??= 'é nulo.';
      if (kDebugMode) {
        print('Resposta positiva: $resposta');
      }
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ListaPassageiros()));
    }
  } */
}
