import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import '../providers/position_provider.dart';
import '../widgets/input_form.dart';
import '../widgets/position_table.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final positionProvider = Provider.of<PositionProvider>(context);

    return Scaffold(
      body: Column(
        children: [
          InputForm(),
          PositionTable(),
          Expanded(
            child: FlutterMap(
              options: MapOptions(
                center: LatLng(-15.8267, -47.9218),
                zoom: 12,
              ),
              children: [
                TileLayer(
                  urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: positionProvider.selectedPositions.map((pos) {
                    return Marker(
                      point: LatLng(pos.latitude, pos.longitude),
                      builder: (ctx) => Icon(Icons.location_on, color: Colors.red),
                    );
                  }).toList(),
                ),
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: positionProvider.selectedRoute.map((coords) => LatLng(coords[0], coords[1])).toList(),
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
