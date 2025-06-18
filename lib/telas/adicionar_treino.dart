import 'package:flutter/material.dart';
import '../models/treino.dart';

class AdicionarTreinoScreen extends StatefulWidget {
  final TipoTreino tipo;
  final Treino? treinoExistente;

  const AdicionarTreinoScreen({
    super.key,
    required this.tipo,
    this.treinoExistente,
  });

  @override
  State<AdicionarTreinoScreen> createState() => _AdicionarTreinoScreenState();
}

class _AdicionarTreinoScreenState extends State<AdicionarTreinoScreen> {
  final nomeController = TextEditingController();
  final descricaoController = TextEditingController();
  TipoTreino? _tipoSelecionado;
  final List<ExercicioForm> exercicios = [];

  @override
  void initState() {
    super.initState();

    if (widget.treinoExistente != null) {
      final treino = widget.treinoExistente!;
      nomeController.text = treino.nome;
      descricaoController.text = treino.descricao;
      _tipoSelecionado = treino.tipo;
      exercicios.addAll(treino.exercicios.map((ex) {
        final form = ExercicioForm();
        form.nomeController.text = ex.nome;
        form.seriesController.text = ex.series.toString();
        form.repeticoesController.text = ex.repeticoes.toString();
        form.observacoesController.text = ex.observacoes;
        return form;
      }));
    } else {
      _tipoSelecionado = widget.tipo;
      exercicios.add(ExercicioForm());
    }
  }

  void _adicionarExercicio() {
    setState(() => exercicios.add(ExercicioForm()));
  }

  void _removerExercicio(int index) {
    setState(() => exercicios.removeAt(index));
  }

  void _salvarTreino() {
    if (nomeController.text.trim().isEmpty || _tipoSelecionado == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nome do treino e tipo são obrigatórios')),
      );
      return;
    }

    final novoTreino = Treino(
      id: widget.treinoExistente?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
      nome: nomeController.text.trim(),
      descricao: descricaoController.text.trim(),
      tipo: _tipoSelecionado!,
      exercicios: exercicios.map((form) => form.toExercicio()).toList(),
    );

    Navigator.pop(context, novoTreino);
  }

  @override
  void dispose() {
    nomeController.dispose();
    descricaoController.dispose();
    for (var exercicio in exercicios) {
      exercicio.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final titulo = widget.treinoExistente == null ? 'Novo Treino' : 'Editar Treino';

    return Scaffold(
      appBar: AppBar(title: Text(titulo)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: nomeController, decoration: const InputDecoration(labelText: 'Nome')),
            TextField(controller: descricaoController, decoration: const InputDecoration(labelText: 'Descrição')),
            const SizedBox(height: 16),
            const Text('Tipo de Treino', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            DropdownButton<TipoTreino>(
              value: _tipoSelecionado,
              onChanged: (TipoTreino? tipo) {
                setState(() {
                  _tipoSelecionado = tipo;
                });
              },
              items: TipoTreino.values.map((tipo) {
                return DropdownMenuItem<TipoTreino>(
                  value: tipo,
                  child: Text(_getTipoNome(tipo)),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            const Text('Exercícios', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            for (int i = 0; i < exercicios.length; i++)
              exercicios[i].build(context, onRemove: () => _removerExercicio(i)),
            TextButton.icon(
              onPressed: exercicios.length < 10 ? _adicionarExercicio : null,
              icon: const Icon(Icons.add),
              label: const Text('Adicionar Exercício'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _salvarTreino,
              child: Text(widget.treinoExistente == null ? 'Salvar Treino' : 'Salvar Alterações'),
            ),
          ],
        ),
      ),
    );
  }

  String _getTipoNome(TipoTreino tipo) {
    switch (tipo) {
      case TipoTreino.cardio:
        return '🏃 Cardio';
      case TipoTreino.forca:
        return '💪 Força';
      case TipoTreino.alongamento:
        return '🧘 Alongamento';
    }
  }
}

class ExercicioForm {
  final nomeController = TextEditingController();
  final seriesController = TextEditingController();
  final repeticoesController = TextEditingController();
  final observacoesController = TextEditingController();

  Exercicio toExercicio() {
    final series = int.tryParse(seriesController.text);
    final repeticoes = int.tryParse(repeticoesController.text);

    return Exercicio(
      nome: nomeController.text.trim(),
      series: (series != null && series > 0) ? series : 0,
      repeticoes: (repeticoes != null && repeticoes > 0) ? repeticoes : 0,
      observacoes: observacoesController.text.trim(),
    );
  }

  Widget build(BuildContext context, {required VoidCallback onRemove}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(controller: nomeController, decoration: const InputDecoration(labelText: 'Exercício')),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: seriesController,
                    decoration: InputDecoration(
                      labelText: 'Séries',
                      errorText: _isNotInt(seriesController.text) ? 'Séries deve ser um número' : null,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: repeticoesController,
                    decoration: InputDecoration(
                      labelText: 'Repetições',
                      errorText: _isNotInt(repeticoesController.text) ? 'Repetições deve ser um número' : null,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            TextField(controller: observacoesController, decoration: const InputDecoration(labelText: 'Observações')),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: onRemove,
                icon: const Icon(Icons.delete, color: Colors.red),
                label: const Text('Remover', style: TextStyle(color: Colors.red)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isNotInt(String value) {
    return value.isNotEmpty && int.tryParse(value) == null;
  }

  void dispose() {
    nomeController.dispose();
    seriesController.dispose();
    repeticoesController.dispose();
    observacoesController.dispose();
  }
}
