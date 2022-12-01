import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monibus/constantes.dart';
import 'package:monibus/view/cadastrarPessoa.dart';
import 'package:monibus/view/recuperarLogin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:another_flushbar/flushbar.dart';

import '../model/autenticacaoModel.dart';
import '../service/autenticacaoService.dart';

class TelaLogin1 extends StatefulWidget {
  @override
  _TelaLogin1State createState() => _TelaLogin1State();
}

class _TelaLogin1State extends State<TelaLogin1> {
  late final TextEditingController _cUsuario, _cSenha;
  late String _cUsuarioAtual;
  late String _cToken;

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
      onTap: () => {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => TelaRecuperarSenha()))
      },
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
            _autenticarUsuario(login, context);
          }
        },
      ),
    );
  }

  Widget _bldSignupBtn() {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CadastrarPessoa()))
      },
      child: Text(
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
    _leiaUsuarioMemLocal();
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
                          _bldSignupBtn(),
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

  _leiaUsuarioMemLocal() async {
    final prefs = await SharedPreferences.getInstance();
    const chave = kAPI_Chave_Usuario;
    _cUsuarioAtual = prefs.getString(chave) ?? 'nenhum usuário';
    _cToken = prefs.getString(kAPI_Chave_Token) ?? 'nenhum token';
    if (_cUsuarioAtual != 'nenhum usuário' && _cToken != 'nenhum token') {
      print('Usuário e Token encontrados!');
    } else {
      print('Nenhum usuário salvo!');
    }

    _salveUsuarioMemLocal() async {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(kAPI_Chave_Usuario, _cUsuario.text);
      prefs.setString(kAPI_Chave_Token, _cToken);
    }
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

  Future<void> _autenticarUsuario(AutenticacaoModel login, context) async {
    AutenticacaoService apiLogin = AutenticacaoService();
    final resultado = await apiLogin.validarUsuario(login);

    if (resultado.isError()) {
      Flushbar(
        title: 'Falha de Autenticação!',
        message: resultado.getError().toString(),
        duration: const Duration(seconds: 5),
      ).show(context);
      return;
    } else {
      // obter o token e armazenar
      print('token: ' + resultado.getSuccess()?.data);
    }
  }
}
