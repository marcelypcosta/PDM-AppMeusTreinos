import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Nota {
  final String texto;
  final DateTime data;

  Nota(this.texto, this.data);
}

class AnotacoesScreen extends StatefulWidget {
  const AnotacoesScreen({super.key});

  @override
  State<AnotacoesScreen> createState() => _AnotacoesScreenState();
}

class _AnotacoesScreenState extends State<AnotacoesScreen> {
  final _controller = TextEditingController();
  final List<Nota> _notas = [];
  DateTime _dataSelecionada = DateTime.now();

  void _salvarNota() {
    final texto = _controller.text.trim();
    if (texto.isEmpty) return;

    setState(() {
      _notas.add(Nota(texto, _dataSelecionada));
      _controller.clear();
    });
  }

  Future<void> _selecionarData() async {
    final novaData = await showDatePicker(
      context: context,
      initialDate: _dataSelecionada,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (novaData != null) {
      setState(() => _dataSelecionada = novaData);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('dd/MM/yyyy');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Anotações'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Escreva sua anotação',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Text('Data: ${formatter.format(_dataSelecionada)}'),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: _selecionarData,
                  child: const Text('Selecionar data'),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: _salvarNota,
                  child: const Text('Salvar'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            Expanded(
              child: _notas.isEmpty
                  ? const Center(child: Text('Nenhuma anotação ainda.'))
                  : ListView.builder(
                itemCount: _notas.length,
                itemBuilder: (context, index) {
                  final nota = _notas[index];
                  return ListTile(
                    title: Text(nota.texto),
                    subtitle: Text('Data: ${formatter.format(nota.data)}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
