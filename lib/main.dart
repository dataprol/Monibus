import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:monibus/constantes.dart';
import 'package:monibus/view/home.dart';
import 'package:monibus/view/login.dart';
import 'service/autenticacao_service.dart';

void main() {
  runApp(const Principal());
}

class Principal extends StatelessWidget {
  const Principal({super.key});

  Future<bool> checarHome() async {
    AutenticacaoService apiLogin = AutenticacaoService();
    String token = await apiLogin.lerTokenMemLocal();
    if (kDebugMode) {
      print('*********** Acessou checarHome(). Token: $token');
    }
    return token.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Projeto Monibus',
      theme: ThemeData(
        primarySwatch: kCorPrimaria,
      ),
      home: FutureBuilder(
          future: checarHome(),
          builder: (context, snapshot) {
            try {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              return (snapshot.data ?? false) ? const home() : TelaLogin();
            } catch (e) {
              return const AlertDialog(title: Text("Erro Interno"), content: Text("O aplicativo teve um problema imprevisto! "));
            }
          }),
    );
  }
}
