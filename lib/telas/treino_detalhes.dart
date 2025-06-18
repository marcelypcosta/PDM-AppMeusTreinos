import 'package:flutter/material.dart';
import '../models/treino.dart';
import '../data/treino_data.dart';
import 'adicionar_treino.dart'; // <- certifique-se de que o caminho está correto

class TreinoDetalhesScreen extends StatefulWidget {
  final Treino treino;

  const TreinoDetalhesScreen({super.key, required this.treino});

  @override
  State<TreinoDetalhesScreen> createState() => _TreinoDetalhesScreenState();
}

class _TreinoDetalhesScreenState extends State<TreinoDetalhesScreen> {
  void _salvarNoHistorico() {
    final treinoRealizado = TreinoRealizado(
      treinoId: widget.treino.id,
      data: DateTime.now(),
      observacoes: 'Treino concluído com sucesso!',
    );

    historico.add(treinoRealizado);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Treino salvo no histórico!')),
    );
  }

  Future<void> _editarTreino() async {
    final treinoEditado = await Navigator.push<Treino>(
      context,
      MaterialPageRoute(
        builder: (_) => AdicionarTreinoScreen(
          tipo: widget.treino.tipo,
          treinoExistente: widget.treino,
        ),
      ),
    );

    if (treinoEditado != null) {
      setState(() {
        final index = treinos.indexWhere((t) => t.id == treinoEditado.id);
        if (index != -1) {
          treinos[index] = treinoEditado;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Treino atualizado com sucesso!')),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final treino = treinos.firstWhere((t) => t.id == widget.treino.id, orElse: () => widget.treino);

    return Scaffold(
      appBar: AppBar(
        title: Text(treino.nome),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'Editar',
            onPressed: _editarTreino,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              treino.nome,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(treino.descricao),
            const SizedBox(height: 12),
            Text('Tipo: ${treino.tipoString()}'),
            const Divider(height: 32),
            Expanded(
              child: treino.exercicios.isNotEmpty
                  ? ListView.builder(
                itemCount: treino.exercicios.length,
                itemBuilder: (context, index) {
                  final ex = treino.exercicios[index];
                  return ListTile(
                    title: Text(ex.nome),
                    subtitle: Text(
                        '${ex.series}x${ex.repeticoes}${ex.observacoes.isNotEmpty ? ' - ${ex.observacoes}' : ''}'),
                  );
                },
              )
                  : const Center(child: Text('Nenhum exercício encontrado')),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _salvarNoHistorico,
              icon: const Icon(Icons.save),
              label: const Text('Salvar no Histórico'),
            ),
          ],
        ),
      ),
    );
  }
}
