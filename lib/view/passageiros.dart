import 'package:flutter/material.dart';

class TelaListaPassageiros extends StatefulWidget {
  const TelaListaPassageiros({super.key});

  @override
  TelaListaPassageirosState createState() => TelaListaPassageirosState();
}

class TelaListaPassageirosState extends State<TelaListaPassageiros> {
  bool estaModoSelecao = true;
  final int listaQuantidade = 30;
  late List<bool> _listaSelecao;

  @override
  void initState() {
    super.initState();
    initializeSelection();
  }

  void initializeSelection() {
    _listaSelecao = List<bool>.generate(listaQuantidade, (_) => false);
  }

  @override
  void dispose() {
    _listaSelecao.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Passageiros',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _listaSelecao.add(false);
          });
        },
        tooltip: 'Adicionar',
        child: const Icon(Icons.add),
      ),
      body: ListBuilder(
        isSelectionMode: estaModoSelecao,
        listaSelecionada: _listaSelecao,
      ),
    );
  }
}

class ListBuilder extends StatefulWidget {
  const ListBuilder({
    super.key,
    required this.listaSelecionada,
    required this.isSelectionMode,
  });

  final bool isSelectionMode;
  final List<bool> listaSelecionada;

  @override
  State<ListBuilder> createState() => _ListBuilderState();
}

class _ListBuilderState extends State<ListBuilder> {
  void _alternaSelecao(int index) {
    if (widget.isSelectionMode) {
      setState(() {
        widget.listaSelecionada[index] = !widget.listaSelecionada[index];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.listaSelecionada.length,
        itemBuilder: (_, int indice) {
          return ListTile(
              onTap: () => _alternaSelecao(indice),
              trailing: widget.isSelectionMode
                  ? Checkbox(
                      value: widget.listaSelecionada[indice],
                      onChanged: (bool? x) => _alternaSelecao(indice),
                    )
                  : const SizedBox.shrink(),
              title: Text('Aluno $indice'));
        });
  }
}
