import 'dart:io';

import 'package:daily_stock_tracker/app/core/models/stock_usage_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBService {
  static final DBService _instance = DBService._internal();
  factory DBService() => _instance;
  DBService._internal();

  static Database? _database;
  final String _dbName = "stock_usage.db";

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    // String path = join(await getDatabasesPath(), "stock_usage.db");
    String path = join(await getDatabasesPath(), _dbName);

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
          water_bottle_1l TEXT,
          water_bottle_halfl TEXT,
          createdAt TEXT
        )
        ''');
      },
    );
  }

  // -----------------------------
  // CRUD OPERATIONS
  // -----------------------------

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

  Future<void> clearAllData() async {
    final db = await database;
    await db.delete('stock_usage'); // delete all rows
  }

  // -----------------------------
  // EXPORT DATABASE
  // -----------------------------
  Future<String> exportDatabase() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String dbPath = join(appDir.path, _dbName);

    File originalDb = File(dbPath);
    if (!originalDb.existsSync()) {
      throw Exception("Database file not found!");
    }

    // Target folder: Downloads
    Directory downloadDir = Directory(
      "/storage/emulated/0/Download/StockUsage",
    );

    // 🔥 Create folder if missing
    if (!downloadDir.existsSync()) {
      downloadDir.createSync(recursive: true);
    }

    // if (!downloadDir.existsSync()) {
    //   downloadDir = appDir; // fallback path
    // }

    // 🔥 Generate timestamp filename
    final now = DateTime.now();
    final formatted =
        "${now.year}"
        "-${now.month.toString().padLeft(2, '0')}"
        "-${now.day.toString().padLeft(2, '0')}"
        "_${now.hour.toString().padLeft(2, '0')}"
        "-${now.minute.toString().padLeft(2, '0')}"
        "-${now.second.toString().padLeft(2, '0')}";

    final fileName = "stock_usage_$formatted.db";

    // Full output path
    String newPath = join(downloadDir.path, fileName);
    // String newPath = join(downloadDir.path, "stock_usage_backup.db");

    File copiedFile = await originalDb.copy(newPath);

    return copiedFile.path;
  }

  // -----------------------------
  // IMPORT DATABASE
  // -----------------------------
  Future<void> importDatabase() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["db"],
    );

    if (result == null) throw Exception("No file selected!");

    File pickedFile = File(result.files.single.path!);

    Directory appDir = await getApplicationDocumentsDirectory();
    String dbPath = join(appDir.path, _dbName);

    // Replace old DB
    await pickedFile.copy(dbPath);
  }
}
