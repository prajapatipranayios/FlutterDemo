class StockUsageModel {
  int? id;
  String idli;
  String chatani;
  String meduWada;
  String appe;
  String sambhar_full;
  String sambhar_half;
  String sambhar_one_fourth;
  String createdAt;

  StockUsageModel({
    this.id,
    required this.idli,
    required this.chatani,
    required this.meduWada,
    required this.appe,
    required this.sambhar_full,
    required this.sambhar_half,
    required this.sambhar_one_fourth,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idli': idli,
      'chatani': chatani,
      'meduWada': meduWada,
      'appe': appe,
      'sambhar_full': sambhar_full,
      'sambhar_half': sambhar_half,
      'sambhar_one_fourth': sambhar_one_fourth,
      'createdAt': createdAt,
    };
  }

  Map<String, dynamic> toUpdateMap() {
    return {
      'idli': idli,
      'chatani': chatani,
      'meduWada': meduWada,
      'appe': appe,
      'sambhar_full': sambhar_full,
      'sambhar_half': sambhar_half,
      'sambhar_one_fourth': sambhar_one_fourth,
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
      sambhar_full: json['sambhar_full'],
      sambhar_half: json['sambhar_half'],
      sambhar_one_fourth: json['sambhar_one_fourth'],
      createdAt: json['createdAt'],
    );
  }
}
