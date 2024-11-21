import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:date_field/date_field.dart'; // Import do pacote
import '../providers/position_provider.dart';

class InputForm extends StatelessWidget {
  final TextEditingController prefixController = TextEditingController();
  final TextEditingController lineNumberController = TextEditingController();
  final TextEditingController startDateTimeController = TextEditingController();
  final TextEditingController endDateTimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final positionProvider = Provider.of<PositionProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Campo de Prefixo do Veículo
          Flexible(
            flex: 2,
            child: TextField(
              controller: prefixController,
              decoration: InputDecoration(
                labelText: 'Prefixo do veículo',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              ),
            ),
          ),
          SizedBox(width: 8), // Espaçamento horizontal

          // Campo de Número da Linha
          Flexible(
            flex: 2,
            child: TextField(
              controller: lineNumberController,
              decoration: InputDecoration(
                labelText: 'Número da linha de ônibus',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              ),
            ),
          ),
          SizedBox(width: 8), // Espaçamento horizontal

          // Campo de Data e Hora Inicial
          Flexible(
            flex: 3,
            child: DateTimeFormField(
              decoration: InputDecoration(
                labelText: 'Data e Hora Inicial',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.event),
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              ),
              mode: DateTimeFieldPickerMode.dateAndTime, // Data e Hora
              onChanged: (DateTime? value) {
                if (value != null) {
                  startDateTimeController.text = value.toIso8601String();
                }
              },
            ),
          ),
          SizedBox(width: 8), // Espaçamento horizontal

          // Campo de Data e Hora Final
          Flexible(
            flex: 3,
            child: DateTimeFormField(
              decoration: InputDecoration(
                labelText: 'Data e Hora Final',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.event),
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              ),
              mode: DateTimeFieldPickerMode.dateAndTime, // Data e Hora
              onChanged: (DateTime? value) {
                if (value != null) {
                  endDateTimeController.text = value.toIso8601String();
                }
              },
            ),
          ),
          SizedBox(width: 8), // Espaçamento horizontal

          // Botão "Buscar Dados Detalhados"
          ElevatedButton(
            onPressed: () {
              positionProvider.fetchDetailedData(
                prefixController.text,
                lineNumberController.text,
                startDateTimeController.text,
                endDateTimeController.text,
              );
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
            child: Text(
              'Buscar Dados Detalhados',
              style: TextStyle(fontSize: 12),
            ),
          ),
          SizedBox(width: 8), // Espaçamento horizontal

          // Botão "Exibir Rota no Mapa"
          ElevatedButton(
            onPressed: () {
              positionProvider.fetchAndSetRoute();
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
            child: Text(
              'Exibir Rota no Mapa',
              style: TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
