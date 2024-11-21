import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import '../providers/posicao_provider.dart';
import '../widgets/input_form.dart';
import '../widgets/posicao_tabela.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final posicaoProvider = Provider.of<PosicaoProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("SECRETARIA DE TRANSPORTE E MOBILIDADE"),
              Image.asset(
                '/logo-gdf.png',
                height: 65,
                semanticLabel: 'logo GDF',
              ),
            ],
          ),
        ),
      body: Column(
        children: [
          InputForm(),
          const PositionTable(),
          Expanded(
            child: FlutterMap(
              options: MapOptions(
                center: LatLng(-15.8267, -47.9218),
                zoom: 12,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: const ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: posicaoProvider.selecionarPosicoes.map((pos) {
                    return Marker(
                      point: LatLng(pos.latitude, pos.longitude),
                      builder: (ctx) =>
                          const Icon(Icons.location_on, color: Colors.red),
                    );
                  }).toList(),
                ),
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: posicaoProvider.selecionarRota
                          .map((coords) => LatLng(coords[0], coords[1]))
                          .toList(),
                      strokeWidth: 4.0,
                      color: Colors.blue,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
