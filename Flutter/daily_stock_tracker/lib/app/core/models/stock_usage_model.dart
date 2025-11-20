class StockUsageModel {
  int? id;
  String idli;
  String chatani;
  String meduWada;
  String appe;
  String createdAt;

  StockUsageModel({
    this.id,
    required this.idli,
    required this.chatani,
    required this.meduWada,
    required this.appe,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idli': idli,
      'chatani': chatani,
      'meduWada': meduWada,
      'appe': appe,
      'createdAt': createdAt,
    };
  }

  Map<String, dynamic> toUpdateMap() {
    return {
      'idli': idli,
      'chatani': chatani,
      'meduWada': meduWada,
      'appe': appe,
      'createdAt': createdAt,
    };
  }

  factory StockUsageModel.fromMap(Map<String, dynamic> json) {
    return StockUsageModel(
      id: json['id'],
      idli: json['idli'],
      chatani: json['chatani'],
      meduWada: json['meduWada'],
      appe: json['appe'],
      createdAt: json['createdAt'],
    );
  }
}
