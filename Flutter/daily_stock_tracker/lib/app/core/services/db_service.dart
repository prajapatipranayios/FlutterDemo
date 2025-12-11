import 'dart:io';

import 'package:daily_stock_tracker/app/core/models/StockArrivalModel.dart';
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

  // ---------------------------------------------------------------------------
  // INIT DATABASE (FRESH STRUCTURE)
  // ---------------------------------------------------------------------------
  Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), _dbName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        // ------------------- STOCK USAGE TABLE -------------------
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
          water_bottle_20l TEXT,
          createdAt TEXT
        )
        ''');

        // ------------------- STOCK TABLE -------------------------
        await db.execute('''
        CREATE TABLE stock_table(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          idli TEXT,
          chatani TEXT,
          meduWada TEXT,
          appe TEXT,
          sambhar_full TEXT,
          sambhar_half TEXT,
          sambhar_one_fourth TEXT,
          water_bottle_20l TEXT,
          createdAt TEXT
        )
        ''');
      },
    );
  }

  // ---------------------------------------------------------------------------
  // CRUD OPERATIONS – STOCK USAGE
  // ---------------------------------------------------------------------------
  Future<bool> isEntryExistsForDate(String date) async {
    final db = await database;
    final res = await db.query(
      'stock_usage',
      where: "createdAt LIKE ?",
      whereArgs: ['%$date%'],
    );
    return res.isNotEmpty;
  }

  Future<int> insertUsage(StockUsageModel model) async {
    final db = await database;
    return await db.insert('stock_usage', model.toMap());
  }

  Future<int> updateUsageForDate(String date, StockUsageModel model) async {
    final db = await database;
    return await db.update(
      'stock_usage',
      model.toUpdateMap(),
      where: "createdAt LIKE ?",
      whereArgs: ['%$date%'],
    );
  }

  Future<List<StockUsageModel>> getAllUsage() async {
    final db = await database;
    final res = await db.query('stock_usage', orderBy: "id DESC");
    return res.map((e) => StockUsageModel.fromMap(e)).toList();
  }

  Future<List<StockUsageModel>> getUsageByMonthYear(String yearMonth) async {
    final db = await database;
    final res = await db.query(
      'stock_usage',
      where: "createdAt LIKE ?",
      whereArgs: ["$yearMonth%"],
    );
    return res.map((e) => StockUsageModel.fromMap(e)).toList();
  }

  Future<List<StockUsageModel>> getUsageBetweenDates(
    String start,
    String end,
  ) async {
    final db = await database;

    final res = await db.query(
      'stock_usage',
      where: "date(createdAt) BETWEEN date(?) AND date(?)",
      whereArgs: [start, end],
      orderBy: "createdAt DESC",
    );

    return res.map((e) => StockUsageModel.fromMap(e)).toList();
  }

  Future<int> deleteUsage(int id) async {
    final db = await database;
    return await db.delete("stock_usage", where: "id = ?", whereArgs: [id]);
  }

  Future<void> clearAllData() async {
    final db = await database;
    await db.delete("stock_usage");
  }

  // ---------------------------------------------------------------------------
  // EXPORT DATABASE
  // ---------------------------------------------------------------------------
  Future<String> exportDatabase() async {
    // Directory appDir = await getApplicationDocumentsDirectory();
    // String dbPath = join(appDir.path, _dbName);
    String dbDir = await getDatabasesPath();
    String dbPath = join(dbDir, _dbName);

    File originalDb = File(dbPath);
    if (!originalDb.existsSync()) {
      print("Database file not found!");
      throw Exception("Database file not found!");
    }

    Directory downloadDir = Directory(
      "/storage/emulated/0/Download/DailyUsage",
    );

    if (!downloadDir.existsSync()) {
      downloadDir.createSync(recursive: true);
    }

    final now = DateTime.now();
    final formatted =
        "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}_${now.hour}-${now.minute}-${now.second}";

    final backupName = "stock_usage_$formatted.db";
    final newPath = join(downloadDir.path, backupName);

    File copied = await originalDb.copy(newPath);
    return copied.path;
  }

  // ---------------------------------------------------------------------------
  // IMPORT DATABASE
  // ---------------------------------------------------------------------------
  Future<void> importDatabase() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["db"],
    );

    if (result == null) throw Exception("No file selected!");

    File picked = File(result.files.single.path!);

    // Check: must be a valid backup file
    if (!basename(picked.path).endsWith(".db")) {
      throw Exception("Invalid file type");
    }

    // Close existing DB
    await closeDb();

    // Path where your real DB lives
    String dbDir = await getDatabasesPath();
    String dbPath = join(dbDir, _dbName);

    // If old DB exists, delete before replacing
    if (File(dbPath).existsSync()) {
      await File(dbPath).delete();
    }

    // Copy with correct name
    await picked.copy(dbPath);

    print("Database imported successfully!");
    await _database;
  }

  static Future<void> closeDb() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }


  // ---------------------------------------------------------------------------
  // STOCK OPERATIONS
  // ---------------------------------------------------------------------------
  Future<int> insertStock(StockTableModel model) async {
    final db = await database;
    return await db.insert("stock_table", model.toMap());
  }

  Future<List<StockTableModel>> fetchAllStock() async {
    final db = await database;
    final res = await db.query("stock_table", orderBy: "id DESC");
    return res.map((e) => StockTableModel.fromMap(e)).toList();
  }

  Future<void> deleteStock(int id) async {
    final db = await database;
    print("object delete id: $id");
    await db.delete("stock_table", where: "id = ?", whereArgs: [id]);
  }

  Future<void> updateStock(StockTableModel model) async {
    final db = await database;
    await db.update(
      "stock_table",
      model.toMap(),
      where: "id = ?",
      whereArgs: [model.id],
    );
  }

  // ---------------------------------------------------------------------------
  // TOTAL STOCK ADDED
  // ---------------------------------------------------------------------------
  Future<Map<String, int>> getTotalStockAdded() async {
    final db = await database;
    final res = await db.query("stock_table");

    int sum(String key) =>
        res.fold(0, (a, b) => a + int.parse((b[key] ?? "0").toString()));

    return {
      "Idli batter": sum("idli"),
      "Chatani": sum("chatani"),
      "MeduWada": sum("meduWada"),
      "Appe": sum("appe"),
      "S Full": sum("sambhar_full"),
      "S Half": sum("sambhar_half"),
      "S 1/4": sum("sambhar_one_fourth"),
      "20 ltr": sum("water_bottle_20l"),
    };
  }

  // ---------------------------------------------------------------------------
  // TOTAL USAGE
  // ---------------------------------------------------------------------------
  Future<Map<String, int>> getTotalUsage() async {
    final db = await database;
    final res = await db.query("stock_usage");

    int sum(String key) =>
        res.fold(0, (a, b) => a + int.parse((b[key] ?? "0").toString()));

    return {
      "Idli batter": sum("idli"),
      "Chatani": sum("chatani"),
      "MeduWada": sum("meduWada"),
      "Appe": sum("appe"),
      "S Full": sum("sambhar_full"),
      "S Half": sum("sambhar_half"),
      "S 1/4": sum("sambhar_one_fourth"),
      "20 ltr": sum("water_bottle_20l"),
    };
  }

  // ---------------------------------------------------------------------------
  // BALANCE
  // ---------------------------------------------------------------------------
  Future<Map<String, int>> getStockBalance() async {
    final added = await getTotalStockAdded();
    final used = await getTotalUsage();

    Map<String, int> balance = {};

    added.forEach((key, value) {
      balance[key] = value - (used[key] ?? 0);
    });

    return balance;
  }
}
