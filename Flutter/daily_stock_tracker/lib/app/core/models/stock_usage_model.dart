class StockUsageModel {
  int? id;
  String idli;
  String chatani;
  String meduWada;
  String appe;
  String sambhar_full;
  String sambhar_half;
  String sambhar_one_fourth;
  String water_bottle_1l;
  String water_bottle_halfl;
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
    required this.water_bottle_1l,
    required this.water_bottle_halfl,
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
      'water_bottle_1l': water_bottle_1l,
      'water_bottle_halfl': water_bottle_halfl,
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
      'water_bottle_1l': water_bottle_1l,
      'water_bottle_halfl': water_bottle_halfl,
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
      water_bottle_1l: json['water_bottle_1l'],
      water_bottle_halfl: json['water_bottle_halfl'],
      createdAt: json['createdAt'],
    );
  }
}
