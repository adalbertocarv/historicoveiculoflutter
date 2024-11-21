class Position {
  final double latitude;
  final double longitude;
  final String datalocal;
  final String nmOperadora;
  final String prefixo;
  final String cdLinha;
  final String? routeData; // Novo campo para armazenar a rota (opcional)

  Position({
    required this.latitude,
    required this.longitude,
    required this.datalocal,
    required this.nmOperadora,
    required this.prefixo,
    required this.cdLinha,
    this.routeData, // Inicialize como opcional
  });

  factory Position.fromJson(Map<String, dynamic> json) {
    return Position(
      latitude: json['latitude'],
      longitude: json['longitude'],
      datalocal: json['datalocal'],
      nmOperadora: json['nm_operadora'],
      prefixo: json['prefixo'],
      cdLinha: json['cd_linha'],
      routeData: json['routeData'], // Mapear para a rota, se presente na API
    );
  }
}
