import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/posicao.dart';

class PosicaoProvider with ChangeNotifier {
  List<Posicao> _posicoes = [];
  List<Posicao> _selecionarPosicoes = [];
  List<List<double>> _selecionarRota = [];

  List<Posicao> get posicoes => _posicoes;
  List<Posicao> get selecionarPosicoes => _selecionarPosicoes;
  List<List<double>> get selecionarRota => _selecionarRota;

  Future<void> buscarInformacoesDetalhadas(String prefix, String lineNumber, String startDate, String endDate) async {
    final response = await http.get(Uri.parse('http://localhost:3000/historico-onibus/detalhado?prefix=$prefix&lineNumber=$lineNumber&startDate=$startDate&endDate=$endDate'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _posicoes = (data['positionData'] as List).map((pos) => Posicao.fromJson(pos)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load data');
    }
  }

  void buscarPlotarRota() {
    if (_posicoes.isNotEmpty) {
      final routeData = _posicoes[0].routeData; // Supondo que o primeiro item tenha os dados da rota
      if (routeData != null) {
        // Converta a string JSON da rota em uma lista de coordenadas
        final rotaAnalisada = (json.decode(routeData) as List)
            .map<List<double>>((coords) => [coords[1], coords[0]]) // Inverte [longitude, latitude] para [latitude, longitude]
            .toList();
        definirRota(rotaAnalisada);
      }
    }
  }


  void posicaoSelecionada(Posicao position) {
    if (_selecionarPosicoes.contains(position)) {
      _selecionarPosicoes.remove(position);
    } else {
      _selecionarPosicoes.add(position);
    }
    notifyListeners();
  }

  void selecionarTodasPosicoes() {
    if (_selecionarPosicoes.length == _posicoes.length) {
      _selecionarPosicoes.clear();
    } else {
      _selecionarPosicoes = List.from(_posicoes);
    }
    notifyListeners();
  }

  void definirRota(List<List<double>> route) {
    _selecionarRota = route;
    notifyListeners();
  }
}

