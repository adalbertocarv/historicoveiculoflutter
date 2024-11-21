class Posicao {
  final double latitude;
  final double longitude;
  final String datalocal;
  final String nmOperadora;
  final String prefixo;
  final String cdLinha;
  final String? routeData;
  Posicao({
    required this.latitude,
    required this.longitude,
    required this.datalocal,
    required this.nmOperadora,
    required this.prefixo,
    required this.cdLinha,
    this.routeData, // Inicialize como opcional
  });

  factory Posicao.fromJson(Map<String, dynamic> json) {
    return Posicao(
      latitude: json['latitude'],
      longitude: json['longitude'],
      datalocal: json['datalocal'],
      nmOperadora: json['nm_operadora'],
      prefixo: json['prefixo'],
      cdLinha: json['cd_linha'],
      routeData: json['routeData'],
    );
  }
}
