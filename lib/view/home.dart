import 'package:flutter/material.dart';

class PainelPrincipal extends StatefulWidget {
  const PainelPrincipal({Key? key}) : super(key: key);
  @override
  _PainelPrincipalState createState() => _PainelPrincipalState();
}

class _PainelPrincipalState extends State<PainelPrincipal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Painel Inicial')), body: Text('Olá!'));
  }
}
