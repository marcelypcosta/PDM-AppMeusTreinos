import 'package:flutter/material.dart';
import '../data/treino_data.dart';
import '../models/treino.dart';
import '../main.dart';

class TreinosListaScreen extends StatefulWidget {
  const TreinosListaScreen({super.key});

  @override
  State<TreinosListaScreen> createState() => _TreinosListaScreenState();
}

class _TreinosListaScreenState extends State<TreinosListaScreen> {
  void _removerTreino(int index) async {
    final confirmar = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Remover treino'),
        content: Text('Deseja remover "${treinos[index].nome}"?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Remover')),
        ],
      ),
    );

    if (confirmar == true) {
      setState(() => treinos.removeAt(index));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Treino removido')),
      );
    }
  }

  void _navegarParaAdicionar() async {
    final novoTreino = await Navigator.pushNamed(context, '/adicionar');
    if (novoTreino is Treino) {
      setState(() => treinos.add(novoTreino));
    }
  }

  void _abrirDetalhes(Treino treino) {
    Navigator.pushNamed(context, '/detalhes', arguments: treino);
  }

  void _abrirHistorico() {
    Navigator.pushNamed(context, '/historico');
  }

  void _abrirAnotacoes() {
    Navigator.pushNamed(context, '/anotacoes');
  }

  void _alternarTema() {
    setState(() {
      if (themeNotifier.value == ThemeMode.light) {
        themeNotifier.value = ThemeMode.dark;
      } else if (themeNotifier.value == ThemeMode.dark) {
        themeNotifier.value = ThemeMode.system;
      } else {
        themeNotifier.value = ThemeMode.light;
      }
    });
  }

  IconData _iconeTemaAtual() {
    switch (themeNotifier.value) {
      case ThemeMode.light:
        return Icons.light_mode;
      case ThemeMode.dark:
        return Icons.dark_mode;
      default:
        return Icons.brightness_auto;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Treinos'),
        actions: [
          IconButton(
            icon: Icon(_iconeTemaAtual()),
            onPressed: _alternarTema,
            tooltip: 'Alternar tema',
          ),
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: _abrirHistorico,
            tooltip: 'Histórico',
          ),
          IconButton(
            icon: const Icon(Icons.note),
            onPressed: _abrirAnotacoes,
            tooltip: 'Anotações',
          ),
        ],
      ),
      body: treinos.isEmpty
          ? const Center(child: Text('Nenhum treino cadastrado ainda.'))
          : ListView.builder(
        itemCount: treinos.length,
        itemBuilder: (context, index) {
          final treino = treinos[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(treino.nome),
              subtitle: Text('${treino.descricao} - ${treino.tipoString()}'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () => _abrirDetalhes(treino),
              onLongPress: () => _removerTreino(index),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navegarParaAdicionar,
        child: const Icon(Icons.add),
      ),
    );
  }
}
