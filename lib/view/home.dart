import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:string_validator/string_validator.dart';
import '../constantes.dart';
import '../model/pessoas_model2.dart';
import '../service/autenticacao_service.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  late var cUsuarioId = '';
  late var cUsuarioNome = '';
  late var cUsuarioLogin = '';
  late var cUsuarioTipo = '';
  late var cUsuarioIdentidade = '';
  late var cUsuarioEmail = '';
  late var cUsuarioTelefone = '';
  late var cUsuarioEmpresaId = '';
  late var cUsuarioEmpresaNome = '';
  late var cUsuarioEmpresaIdentidad = '';

  AutenticacaoService apiLogin = AutenticacaoService();

  @override
  void initState() {
    super.initState();
    setState(() {
      lerUsuarioMemLocal();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Painel Inicial'),
        ),
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: retornarItensMenu(),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: Container(
            alignment: AlignmentDirectional.center,
            child: Text('Bem vindo(a), $cUsuarioNome!'),
          ),
        ));
  }

  Widget retornarItensMenu() {
    return Column(
      children: [
        Container(
            decoration: BoxDecoration(color: Colors.blue, border: Border.all(width: 0.0, color: Color.fromARGB(206, 255, 255, 255))),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.fromLTRB(15, 50, 15, 15),
            child: Column(
              children: [
                Text(cUsuarioNome, style: Theme.of(context).textTheme.titleLarge),
                Text("($cUsuarioLogin)", style: Theme.of(context).textTheme.titleLarge),
                Text(cUsuarioEmail, style: Theme.of(context).textTheme.bodyMedium),
                Text("Tipo: $cUsuarioTipo", style: Theme.of(context).textTheme.bodyMedium),
              ],
            )),
        Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
            alignment: Alignment.centerLeft,
            height: 50.0,
            child: TextButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              onPressed: () => apiLogin.desconectarUsuario(context),
              child: Row(children: [
                const Icon(Icons.exit_to_app, color: Colors.black),
                Text(" Sair", style: Theme.of(context).textTheme.titleMedium),
              ]),
            )),
      ],
    );
  }

  lerUsuarioMemLocal() async {
    final prefs = await SharedPreferences.getInstance();
    cUsuarioId = prefs.getString(kAPI_Chave_UsuarioId) ?? '';
    cUsuarioNome = prefs.getString(kAPI_Chave_UsuarioNome) ?? '';
    cUsuarioLogin = prefs.getString(kAPI_Chave_UsuarioLogin) ?? '';
    cUsuarioTipo = prefs.getString(kAPI_Chave_UsuarioTipo) ?? '';
    cUsuarioIdentidade = prefs.getString(kAPI_Chave_UsuarioIdentidade) ?? '';
    cUsuarioEmail = prefs.getString(kAPI_Chave_UsuarioEmail) ?? '';
    cUsuarioTelefone = prefs.getString(kAPI_Chave_UsuarioTelefone) ?? '';
    cUsuarioEmpresaId = prefs.getString(kAPI_Chave_EmpresaId) ?? '';
    cUsuarioEmpresaNome = prefs.getString(kAPI_Chave_EmpresaNome) ?? '';
    cUsuarioEmpresaIdentidad = prefs.getString(kAPI_Chave_EmpresaNomeIdentidade) ?? '';
  }
}
