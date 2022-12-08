import 'package:flutter/material.dart';
import 'package:monibus/constantes.dart';
import 'package:monibus/view/listaPessoas.dart';
import 'package:monibus/view/login.dart';
import 'service/autenticacaoService.dart';

void main() {
  runApp(const Principal());
}

class Principal extends StatelessWidget {
  const Principal({super.key});

  Future<bool> checkHome() async {
    AutenticacaoService apiLogin = AutenticacaoService();
    String token = await apiLogin.lerTokenMemLocal();
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
          future: checkHome(),
          builder: (context, snapshot) {
            try {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              return (snapshot.data ?? false) ? const ListaPessoas() : TelaLogin();
            } catch (e) {
              return const AlertDialog(title: Text("Erro Interno"), content: Text("O aplicativo teve um problema imprevisto! "));
            }
          }),
    );
  }
}
