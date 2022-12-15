import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:monibus/view/cadastrar_pessoa.dart';
import '../constantes.dart';
import '../model/pessoas_model2.dart';

const cURL = "$kAPI_URI_Base/usuarios/solicitarrecuperaracesso";

class API {
  static Future recuperarAcesso(String email) async {
    var resposta = await http.post(Uri.parse(cURL), body: '{"email":"$email"}');
    if (kDebugMode) {
      print('===== recuperarAcesso =====');
      print('Status code: ${resposta.statusCode}');
      print('Body: ${resposta.body}');
      print('---------------------');
    }
    return resposta;
  }
}

class TelaRecuperarSenha extends StatefulWidget {
  @override
  _TelaRecuperarSenhaState createState() => _TelaRecuperarSenhaState();
}

class _TelaRecuperarSenhaState extends State<TelaRecuperarSenha> {
  late final TextEditingController _cEmail;
  @override
  void initState() {
    super.initState();
    _cEmail = TextEditingController();
  }

  @override
  void dispose() {
    _cEmail.dispose();
    super.dispose();
  }

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          height: 60.0,
          child: TextField(
            controller: _cEmail,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(top: 14.0),
              prefixIcon: const Icon(
                Icons.email,
                color: Colors.red,
              ),
              hintText: 'Informe seu e-Mail',
              hintStyle: kDicaEstilo_1,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          solicitaRecuperacaoAcesso();
        },
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        child: const Text(
          'Enviar',
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

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const CadastrarPessoa(
                      pessoaComoUmUsuario: 'usuário',
                    ))),
        Navigator.pop(context)
      },
      child: const Text(
        'Se preferir, faça novo cadastro.',
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
              Container(
                height: double.infinity,
                width: double.infinity,
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 120.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        kAplicativoNome,
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'Recuperar Senha',
                        style: TextStyle(
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      _buildEmailTF(),
                      const SizedBox(
                        height: 30.0,
                      ),
                      _buildLoginBtn(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildSignupBtn(),
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

  void solicitaRecuperacaoAcesso() {
    var sucesso = false;
    var erroOcorrido = false;
    API.recuperarAcesso(_cEmail.text).then((response) {
      setState(() {
        var retorno = jsonDecode(response.body);
        if (kDebugMode) {
          print(retorno['message']);
        }
        if (retorno['success'] == 'true') {
          sucesso = true;
        } else {
          sucesso = false;
        }
      });
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
      sucesso = false;
      erroOcorrido = true;
    });
    if (sucesso == true) {
      AlertDialog(
        title: const Text("Sucesso!"),
        content: const Text('Você deve ter recebido uma mensagem, por e-mail, se tudo deu certo. Verifiquei, por favor.'),
        actions: [
          TextButton(
            onPressed: () => voltarTelaAnterior,
            child: const Text('Ok'),
          ),
        ],
      );
    } else {
      AlertDialog(
        title: const Text("Falha!"),
        content: const Text('Tentamos enviar uma mensagem, por e-mail. Mas, algo deu errado. Tente outra vez.'),
        actions: [
          TextButton(
            onPressed: () => voltarTelaAnterior,
            child: const Text('Ok'),
          ),
        ],
      );
    }
    if (erroOcorrido == true) {
      AlertDialog(
        title: Text("Erro!"),
        content: Text('Ocorreu uma falha! Tente outra vez.'),
        actions: [
          TextButton(
            onPressed: voltarTelaAnterior,
            child: Text('Ok'),
          ),
        ],
      );
    }
  }

  void voltarTelaAnterior() {
    Navigator.pop(context);
  }
}
