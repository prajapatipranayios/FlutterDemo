class StockUsageModel {
  int? id;
  String? idli;
  String? chatani;
  String? meduWada;
  String? appe;
  String? sambhar_full;
  String? sambhar_half;
  String? sambhar_one_fourth;
  String? water_bottle_20l;
  String? createdAt;

  StockUsageModel({
    this.id,
    this.idli,
    this.chatani,
    this.meduWada,
    this.appe,
    this.sambhar_full,
    this.sambhar_half,
    this.sambhar_one_fourth,
    this.water_bottle_20l,
    this.createdAt,
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
      'water_bottle_20l': water_bottle_20l,
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
      'water_bottle_20l': water_bottle_20l,
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
      water_bottle_20l: json['water_bottle_20l'],
      createdAt: json['createdAt'],
    );
  }
}
