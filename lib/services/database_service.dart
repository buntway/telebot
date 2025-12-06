import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static Database? _database;

  static Future<void> initialize() async {
    _database = await _initDB('birdcherryprint.db');
    await _createTables(_database!);
  }

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('birdcherryprint.db');
    return _database!;
  }

  static Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1);
  }

  static Future<void> _createTables(Database db) async {
    // Создание таблиц (аналогично исходному коду)
    await db.execute('''
    CREATE TABLE IF NOT EXISTS users(
      id INTEGER PRIMARY KEY,
      name TEXT NOT NULL,
      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    )
    ''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS orders(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      user_id INTEGER NOT NULL,
      product_id INTEGER NOT NULL,
      product_name TEXT NOT NULL,
      color TEXT NOT NULL,
      material TEXT NOT NULL,
      quantity INTEGER NOT NULL,
      total_price REAL NOT NULL,
      status TEXT NOT NULL DEFAULT 'created',
      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (user_id) REFERENCES users(id)
    )
    ''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS current_orders(
      user_id INTEGER PRIMARY KEY,
      product_id INTEGER NOT NULL,
      product_name TEXT NOT NULL,
      price REAL NOT NULL,
      color TEXT,
      material TEXT,
      quantity INTEGER DEFAULT 1
    )
    ''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS user_states(
      user_id INTEGER PRIMARY KEY,
      state TEXT NOT NULL DEFAULT ''
    )
    ''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS reviews(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      user_id INTEGER NOT NULL,
      text TEXT NOT NULL,
      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (user_id) REFERENCES users(id)
    )
    ''');
  }

  // Методы работы с БД (аналогично исходному коду)
  static Future<void> createUser(int userId, String name) async {
    final db = await database;
    final existingUser = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [userId],
    );

    if (existingUser.isEmpty) {
      await db.insert('users', {'id': userId, 'name': name});
    }
  }

  // Другие методы (setCurrentOrder, getCurrentOrder, updateOrderColor и т.д.)
  // ... (аналогично исходному коду)
}
