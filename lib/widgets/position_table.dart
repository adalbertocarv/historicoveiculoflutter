import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/position_provider.dart';

class PositionTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final positionProvider = Provider.of<PositionProvider>(context);

    return positionProvider.positions.isNotEmpty
        ? SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          DataColumn(label: Text('')),
          DataColumn(label: Text('Operadora')),
          DataColumn(label: Text('Prefixo')),
          DataColumn(label: Text('Linha')),
          DataColumn(label: Text('Data Local')),
          DataColumn(label: Text('Localização')),
        ],
        rows: positionProvider.positions.map((pos) {
          return DataRow(
            selected: positionProvider.selectedPositions.contains(pos),
            onSelectChanged: (bool? selected) {
              positionProvider.selectPosition(pos);
            },
            cells: [
              DataCell(Checkbox(
                value: positionProvider.selectedPositions.contains(pos),
                onChanged: (bool? value) {
                  positionProvider.selectPosition(pos);
                },
              )),
              DataCell(Text(pos.nmOperadora)),
              DataCell(Text(pos.prefixo)),
              DataCell(Text(pos.cdLinha)),
              DataCell(Text(pos.datalocal)),
              DataCell(Text('POINT (${pos.longitude}, ${pos.latitude})')),
            ],
          );
        }).toList(),
      ),
    )
        : Container();
  }
}
