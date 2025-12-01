class StockTableModel {
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

  StockTableModel({
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

  Map<String, dynamic> toMap() => {
    "id": id,
    "idli": idli,
    "chatani": chatani,
    "meduWada": meduWada,
    "appe": appe,
    "sambhar_full": sambhar_full,
    "sambhar_half": sambhar_half,
    "sambhar_one_fourth": sambhar_one_fourth,
    "water_bottle_1l": water_bottle_1l,
    "water_bottle_halfl": water_bottle_halfl,
    "createdAt": createdAt,
  };

  factory StockTableModel.fromMap(Map<String, dynamic> map) {
    return StockTableModel(
      id: map['id'],
      idli: map['idli'],
      chatani: map['chatani'],
      meduWada: map['meduWada'],
      appe: map['appe'],
      sambhar_full: map['sambhar_full'],
      sambhar_half: map['sambhar_half'],
      sambhar_one_fourth: map['sambhar_one_fourth'],
      water_bottle_1l: map['water_bottle_1l'],
      water_bottle_halfl: map['water_bottle_halfl'],
      createdAt: map['createdAt'],
    );
  }
}
