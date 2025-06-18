import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/treino.dart';
import '../data/treino_data.dart';

class HistoricoScreen extends StatefulWidget {
  const HistoricoScreen({super.key});

  @override
  State<HistoricoScreen> createState() => _HistoricoScreenState();
}

class _HistoricoScreenState extends State<HistoricoScreen> {
  TipoTreino? filtroSelecionado;

  Treino? getTreinoById(String id) {
    try {
      return treinos.firstWhere((t) => t.id == id);
    } catch (_) {
      return null;
    }
  }

  String getTipoNome(TipoTreino tipo) {
    switch (tipo) {
      case TipoTreino.cardio:
        return 'Cardio';
      case TipoTreino.forca:
        return 'Força';
      case TipoTreino.alongamento:
        return 'Alongamento';
    }
  }

  @override
  Widget build(BuildContext context) {
    final historicoOrdenado = List.of(historico)
      ..sort((a, b) => b.data.compareTo(a.data));

    final historicoFiltrado = historicoOrdenado.where((registro) {
      final treino = getTreinoById(registro.treinoId);
      if (treino == null) return false;
      if (filtroSelecionado == null) return true;
      return treino.tipo == filtroSelecionado;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico de Treinos'),
        actions: [
          DropdownButton<TipoTreino?>(
            value: filtroSelecionado,
            hint: const Text('Filtro'),
            onChanged: (value) {
              setState(() => filtroSelecionado = value);
            },
            items: [
              const DropdownMenuItem(
                value: null,
                child: Text('Todos'),
              ),
              ...TipoTreino.values.map((tipo) {
                return DropdownMenuItem(
                  value: tipo,
                  child: Text(getTipoNome(tipo)),
                );
              }).toList(),
            ],
          ),
        ],
      ),
      body: historicoFiltrado.isEmpty
          ? const Center(child: Text('Nenhum treino registrado.'))
          : ListView.builder(
        itemCount: historicoFiltrado.length,
        itemBuilder: (context, index) {
          final registro = historicoFiltrado[index];
          final treino = getTreinoById(registro.treinoId);
          final tipoTexto = treino != null ? getTipoNome(treino.tipo) : 'Desconhecido';

          return ListTile(
            title: Text('${treino?.nome ?? 'Treino não encontrado'} ($tipoTexto)'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(DateFormat('dd/MM/yyyy HH:mm').format(registro.data)),
                if (registro.observacoes.isNotEmpty)
                  Text(
                    'Nota: ${registro.observacoes}',
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
              ],
            ),
            onTap: treino != null
                ? () => Navigator.pushNamed(context, '/detalhes', arguments: treino)
                : null,
          );
        },
      ),
    );
  }
}
