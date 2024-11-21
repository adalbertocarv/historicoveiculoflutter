import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart'; // Import para localizações
import 'package:provider/provider.dart';
import 'providers/position_provider.dart';
import 'screens/map_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PositionProvider(),
      child: MaterialApp(
        title: 'Map App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // Configuração de localizações
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('pt', 'BR'), // Suporte ao português do Brasil
        ],
        locale: const Locale('pt', 'BR'), // Define a localidade padrão
        home: MapScreen(),
      ),
    );
  }
}
