import 'package:flutter/material.dart';
import 'view/login.dart';

void main() {
  runApp(const Principal());
}

class Principal extends StatelessWidget {
  const Principal({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Projeto Monibus',
      home: TelaLogin1(),
    );
  }
}
