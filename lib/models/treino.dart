enum TipoTreino { cardio, forca, alongamento }

class Exercicio {
  final String nome;
  final int series;
  final int repeticoes;
  final String observacoes;

  Exercicio({
    required this.nome,
    required this.series,
    required this.repeticoes,
    this.observacoes = '',
  }) : assert(series > 0, 'Séries deve ser maior que 0'),
       assert(repeticoes > 0, 'Repetições deve ser maior que 0');
}

class Treino {
  final String id;
  final String nome;
  final String descricao;
  final TipoTreino tipo;
  final List<Exercicio> exercicios;

  Treino({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.tipo,
    required this.exercicios,
  });

  /// Retorna o nome do tipo de treino como string
  String tipoString() {
    switch (tipo) {
      case TipoTreino.cardio:
        return 'Cardio';
      case TipoTreino.forca:
        return 'Força';
      case TipoTreino.alongamento:
        return 'Alongamento';
    }
  }
}

class TreinoRealizado {
  final String treinoId; // Referência ao id do treino
  final DateTime data;
  final String observacoes;

  TreinoRealizado({
    required this.treinoId,
    required this.data,
    this.observacoes = '',
  });
}
