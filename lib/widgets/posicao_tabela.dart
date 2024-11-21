import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/posicao_provider.dart';

class PosicaoTabela extends StatelessWidget {
  const PosicaoTabela({super.key});

  @override
  Widget build(BuildContext context) {
    final posicaoProvider = Provider.of<PosicaoProvider>(context);

    return posicaoProvider.posicoes.isNotEmpty
        ? SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('')),
          DataColumn(label: Text('Operadora')),
          DataColumn(label: Text('Prefixo')),
          DataColumn(label: Text('Linha')),
          DataColumn(label: Text('Data Local')),
          DataColumn(label: Text('Localização')),
        ],
        rows: posicaoProvider.posicoes.map((pos) {
          return DataRow(
            selected: posicaoProvider.selecionarPosicoes.contains(pos),
            onSelectChanged: (bool? selected) {
              posicaoProvider.posicaoSelecionada(pos);
            },
            cells: [
              DataCell(Checkbox(
                value: posicaoProvider.selecionarPosicoes.contains(pos),
                onChanged: (bool? value) {
                  posicaoProvider.posicaoSelecionada(pos);
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
