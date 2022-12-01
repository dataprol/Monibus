import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constantes.dart';
import 'package:string_validator/string_validator.dart' as validador;

class CadastrarPessoa extends StatefulWidget {
  @override
  _CadastrarPessoaState createState() => _CadastrarPessoaState();
}

class _CadastrarPessoaState extends State<CadastrarPessoa> {
  late final TextEditingController _cUsuario,
      _cSenha,
      _cSenha2,
      _cNome,
      _cEmail,
      _cTelefone;

  @override
  void initState() {
    super.initState();
    _cUsuario = TextEditingController();
    _cSenha = TextEditingController();
    _cSenha2 = TextEditingController();
    _cNome = TextEditingController();
    _cEmail = TextEditingController();
    _cTelefone = TextEditingController();
  }

  @override
  void dispose() {
    _cUsuario.dispose();
    _cSenha.dispose();
    _cSenha2.dispose();
    _cNome.dispose();
    _cEmail.dispose();
    _cTelefone.dispose();
    super.dispose();
  }

  Widget _bldNome() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
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
              hintText: 'Informe seu nome',
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

  Widget _bldCadastrarBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          var lValido = true;

          if (_cNome.text.isEmpty ||
              _cNome.text.length < 8 ||
              validador.isNumeric(_cNome.text)) {
            Flushbar(
              title: 'Nome inválido!',
              message:
                  'O nome precisa possuir letras e ter o mínimo de 8 caracteres!',
              duration: Duration(seconds: 5),
            ).show(context);
            lValido = false;
          } else if (_cEmail.text.isEmpty || !validador.isEmail(_cEmail.text)) {
            Flushbar(
              title: 'E-mail inválido!',
              message:
                  'Informe, corretamente, um endereço de correio eletrônico(e-mail)!',
              duration: Duration(seconds: 5),
            ).show(context);
            lValido = false;
          } else if (_cTelefone.text.isEmpty ||
              _cTelefone.text.length < 10 ||
              !validador.isNumeric(_cTelefone.text)) {
            Flushbar(
              title: 'Telefone inválido!',
              message: 'Informe, corretamente, um telefone!',
              duration: Duration(seconds: 5),
            ).show(context);
            lValido = false;
          } else if (_cUsuario.text.isEmpty ||
              _cUsuario.text.length < 4 ||
              validador.isNumeric(_cUsuario.text)) {
            Flushbar(
              title: 'Usuário inválido!',
              message:
                  'Informe, corretamente, um nome de usuário de acesso ao sistema!',
              duration: Duration(seconds: 5),
            ).show(context);
            lValido = false;
          } else if (_cSenha.text.isEmpty ||
              _cSenha.text.length < 8 ||
              validador.isNumeric(_cSenha.text) ||
              validador.isAlpha(_cSenha.text) ||
              validador.isAlphanumeric(_cSenha.text)) {
            Flushbar(
              title: 'Senha não permitida!',
              message: 'A senha precisa ter o mínimo de 8 caracteres' +
                  ' contendo letras e números e pelo menos um caracter ' +
                  'diferente de letra e número!',
              duration: Duration(seconds: 5),
            ).show(context);
            lValido = false;
          } else if (_cSenha2.text != _cSenha.text) {
            Flushbar(
              title: 'Senha não confere!',
              message: 'A segunda senha está diferente da primeira informada!',
              duration: Duration(seconds: 5),
            ).show(context);
            lValido = false;
          }

          if (lValido) {
            // cadastrar usuário e retornar à tela de login

            //Navigator.pop(context);
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
                      _bldNome(),
                      _bldEmail(),
                      _bldTelefone(),
                      _bldUsuario(),
                      _bldSenha(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _bldCadastrarBtn(),
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
}
