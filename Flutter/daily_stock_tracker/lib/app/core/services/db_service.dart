import 'package:daily_stock_tracker/app/core/models/stock_usage_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// import '../models/stock_usage_model.dart';

class DBService {
  static final DBService _instance = DBService._internal();
  factory DBService() => _instance;
  DBService._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), "stock_usage.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE stock_usage(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          idli TEXT,
          chatani TEXT,
          meduWada TEXT,
          appe TEXT,
          sambhar_full TEXT,
          sambhar_half TEXT,
          sambhar_one_fourth TEXT,
          createdAt TEXT
        )
        ''');
      },
    );
  }

  /// CHECK IF ENTRY EXISTS FOR A DATE
  Future<bool> isEntryExistsForDate(String date) async {
    final db = await database;

    final List<Map<String, dynamic>> res = await db.query(
      'stock_usage',
      where: "createdAt LIKE ?",
      whereArgs: ['%$date%'], // matches YYYY-MM-DD
    );

    return res.isNotEmpty;
  }

  /// INSERT
  Future<int> insertUsage(StockUsageModel model) async {
    final db = await database;
    return await db.insert('stock_usage', model.toMap());
  }

  /// UPDATE
  Future<int> updateUsageForDate(String date, StockUsageModel model) async {
    final db = await database;

    return await db.update(
      'stock_usage',
      model.toUpdateMap(),
      where: "createdAt LIKE ?",
      whereArgs: ['%$date%'], // match day
    );
  }

  /// GET ALL
  Future<List<StockUsageModel>> getAllUsage() async {
    final db = await database;
    final List<Map<String, dynamic>> res = await db.query(
      'stock_usage',
      orderBy: "id DESC",
    );
    return res.map((e) => StockUsageModel.fromMap(e)).toList();
  }

  Future<List<StockUsageModel>> getUsageByMonthYear(String yearMonth) async {
    final db = await database;

    final res = await db.query(
      'stock_usage',
      where: "createdAt LIKE ?",
      whereArgs: ["$yearMonth%"], // e.g. 2025-03%
    );

    return res.map((e) => StockUsageModel.fromMap(e)).toList();
  }

  /// DELETE IF NEEDED
  Future<int> deleteUsage(int id) async {
    final db = await database;
    return await db.delete('stock_usage', where: "id = ?", whereArgs: [id]);
  }

  Future<int> deleteUsageById(int id) async {
    final db = await database;
    return await db.delete('stock_usage', where: "id = ?", whereArgs: [id]);
  }
}
