import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:date_field/date_field.dart';
import '../providers/posicao_provider.dart';

class InputForm extends StatelessWidget {
  final TextEditingController prefixoController = TextEditingController();
  final TextEditingController numeroLinhaController = TextEditingController();
  final TextEditingController dataInicioController = TextEditingController();
  final TextEditingController dataFimController = TextEditingController();

  InputForm({super.key});

  @override
  Widget build(BuildContext context) {
    final posicaoProvider = Provider.of<PosicaoProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Campo de Prefixo do Veículo
          Flexible(
            flex: 2,
            child: TextField(
              controller: prefixoController,
              decoration: const InputDecoration(
                labelText: 'Prefixo do veículo',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              ),
            ),
          ),
          const SizedBox(width: 8), // Espaçamento horizontal

          // Campo de Número da Linha
          Flexible(
            flex: 2,
            child: TextField(
              controller: numeroLinhaController,
              decoration: const InputDecoration(
                labelText: 'Número da linha de ônibus',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              ),
            ),
          ),
          const SizedBox(width: 8), // Espaçamento horizontal

          // Campo de Data e Hora Inicial
          Flexible(
            flex: 3,
            child: DateTimeFormField(
              decoration: const InputDecoration(
                labelText: 'Data e Hora Inicial',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.event),
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              ),
              mode: DateTimeFieldPickerMode.dateAndTime, // Data e Hora
              onChanged: (DateTime? value) {
                if (value != null) {
                  dataInicioController.text = value.toIso8601String();
                }
              },
            ),
          ),
          const SizedBox(width: 8), // Espaçamento horizontal

          // Campo de Data e Hora Final
          Flexible(
            flex: 3,
            child: DateTimeFormField(
              decoration: const InputDecoration(
                labelText: 'Data e Hora Final',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.event),
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              ),
              mode: DateTimeFieldPickerMode.dateAndTime, // Data e Hora
              onChanged: (DateTime? value) {
                if (value != null) {
                  dataFimController.text = value.toIso8601String();
                }
              },
            ),
          ),
          const SizedBox(width: 8), // Espaçamento horizontal

          // Botão "Buscar Dados Detalhados"
          ElevatedButton(
            onPressed: () {
              posicaoProvider.buscarInformacoesDetalhadas(
                prefixoController.text,
                numeroLinhaController.text,
                dataInicioController.text,
                dataFimController.text,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, // Cor de fundo
              foregroundColor: Colors.white, // Cor do texto
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Espaçamento interno
              textStyle: const TextStyle(
                fontSize: 14, // Tamanho da fonte
                fontWeight: FontWeight.bold, // Peso da fonte
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4), // Borda arredondada
              ),
            ),
            child: const Text(
              'Buscar Dados Detalhados',
              style: TextStyle(fontSize: 18),
            ),
          ),
          const SizedBox(width: 8), // Espaçamento horizontal

          // Botão "Exibir Rota no Mapa"
          ElevatedButton(
            onPressed: () {
              posicaoProvider.buscarPlotarRota();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue, // Cor de fundo
              foregroundColor: Colors.white, // Cor do texto
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Espaçamento interno
              textStyle: const TextStyle(
                fontSize: 14, // Tamanho da fonte
                fontWeight: FontWeight.bold, // Peso da fonte
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4), // Borda arredondada
              ),
            ),
            child: const Text(
              'Exibir Rota no Mapa',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
