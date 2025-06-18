import 'package:flutter/material.dart';
import 'models/treino.dart';
import 'telas/treinos_lista.dart';
import 'telas/historico.dart';
import 'telas/anotacoes.dart'; // ✅ Importação da tela de anotações
import 'telas/adicionar_treino.dart' as adicionar;
import 'telas/treino_detalhes.dart' as detalhes;

// Gerenciador de tema global simples
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.system);

void main() {
  runApp(const MeuTreinoApp());
}

class MeuTreinoApp extends StatelessWidget {
  const MeuTreinoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentMode, _) {
        return MaterialApp(
          title: 'Meu Treino',
          theme: ThemeData(
            brightness: Brightness.light,
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue,
              brightness: Brightness.dark,
            ),
          ),
          themeMode: currentMode,
          initialRoute: '/',
          routes: {
            '/': (context) => const TreinosListaScreen(),
            '/adicionar': (context) =>
                adicionar.AdicionarTreinoScreen(tipo: TipoTreino.forca),
            '/historico': (context) => const HistoricoScreen(),
            '/anotacoes': (context) => const AnotacoesScreen(), // ✅ Rota funcionando
          },
          onGenerateRoute: (settings) {
            if (settings.name == '/detalhes') {
              final treino = settings.arguments as Treino?;
              if (treino == null) {
                return MaterialPageRoute(
                  builder: (context) => const ErrorScreen(),
                );
              }
              return MaterialPageRoute(
                builder: (context) =>
                    detalhes.TreinoDetalhesScreen(treino: treino),
              );
            }
            return null;
          },
        );
      },
    );
  }
}

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Erro')),
      body: const Center(child: Text('Erro ao carregar os detalhes do treino')),
    );
  }
}
