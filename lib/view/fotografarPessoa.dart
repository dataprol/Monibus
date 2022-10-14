import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FotografarPessoa extends StatefulWidget {
  @override
  _FotografarPessoaState createState() => _FotografarPessoaState();
}

class _FotografarPessoaState extends State<FotografarPessoa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () => print('Teste 1'),
              icon: const Icon(Icons.camera),
              label: const Text('Validar rosto'),
            ),
          ],
        ),
      ),
    );
  }
}
