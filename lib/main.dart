import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // Import para localizações
import 'package:provider/provider.dart';
import 'providers/posicao_provider.dart';
import 'screens/mapa_screen.dart';

void main() {
  runApp(const HistoricoVeiculo());
}

class HistoricoVeiculo extends StatelessWidget {
  const HistoricoVeiculo({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PosicaoProvider(),
      child: MaterialApp(
        title: 'Histórico Posição',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // Configuração de localizações
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('pt', 'BR'), // Suporte ao português do Brasil
        ],
        locale: const Locale('pt', 'BR'), // Define a localidade padrão
        home: const MapScreen(),
      ),
    );
  }
}
