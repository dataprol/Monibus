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
        appBar: AppBar(title: Text('Painel Inicial')),
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: Column(
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      border: Border.all(
                          width: 0.0,
                          color: Color.fromARGB(206, 255, 255, 255))),
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(15, 50, 15, 15),
                  child: Text("Usuário X",
                      style: Theme.of(context).textTheme.titleLarge)),
              Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                alignment: Alignment.centerLeft,
                height: 50.0,
                child: Row(children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    width: 38.0,
                    height: 38.0,
                    child: IconButton(
                        icon: const Icon(Icons.exit_to_app),
                        color: Colors.red,
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Saindo...')));
                        }),
                  ),
                  Text("Sair", style: Theme.of(context).textTheme.titleMedium),
                ]),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.centerLeft,
            height: 50.0,
            color: Colors.lightBlueAccent,
            child: Row(children: [
              Text("Listar Passageiros",
                  style: Theme.of(context).textTheme.titleMedium),
            ]),
          ),
        ));
  }
}
