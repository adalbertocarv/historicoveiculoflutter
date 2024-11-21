import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/position.dart';

class PositionProvider with ChangeNotifier {
  List<Position> _positions = [];
  List<Position> _selectedPositions = [];
  List<List<double>> _selectedRoute = [];

  List<Position> get positions => _positions;
  List<Position> get selectedPositions => _selectedPositions;
  List<List<double>> get selectedRoute => _selectedRoute;

  Future<void> fetchDetailedData(String prefix, String lineNumber, String startDate, String endDate) async {
    final response = await http.get(Uri.parse('http://localhost:3000/historico-onibus/detalhado?prefix=$prefix&lineNumber=$lineNumber&startDate=$startDate&endDate=$endDate'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _positions = (data['positionData'] as List).map((pos) => Position.fromJson(pos)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load data');
    }
  }

  void fetchAndSetRoute() {
    if (_positions.isNotEmpty) {
      final routeData = _positions[0].routeData; // Supondo que o primeiro item tenha os dados da rota
      if (routeData != null) {
        // Converta a string JSON da rota em uma lista de coordenadas
        final parsedRoute = (json.decode(routeData) as List)
            .map<List<double>>((coords) => [coords[1], coords[0]]) // Inverte [longitude, latitude] para [latitude, longitude]
            .toList();
        setRoute(parsedRoute);
      }
    }
  }


  void selectPosition(Position position) {
    if (_selectedPositions.contains(position)) {
      _selectedPositions.remove(position);
    } else {
      _selectedPositions.add(position);
    }
    notifyListeners();
  }

  void selectAllPositions() {
    if (_selectedPositions.length == _positions.length) {
      _selectedPositions.clear();
    } else {
      _selectedPositions = List.from(_positions);
    }
    notifyListeners();
  }

  void setRoute(List<List<double>> route) {
    _selectedRoute = route;
    notifyListeners();
  }
}

