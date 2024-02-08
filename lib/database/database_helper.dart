import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:plantilla_login_register/models/user.dart';

class DatabaseHelper {
  static Database? _database;
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'user_database.db');
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        email TEXT PRIMARY KEY,
        name TEXT,
        address TEXT,
        phone TEXT,
        photo TEXT
      )
    ''');
  }

  Future<List<User>> getAllUsers() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('users');
    return List.generate(maps.length, (i) {
      return User(
        name: maps[i]['name'],
        email: maps[i]['email'],
        address: maps[i]['address'],
        phone: maps[i]['phone'],
        photo: maps[i]['photo'],
      );
    });
  }

  Future<void> insertUser(User user) async {
    final Database db = await database;
    await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteUser(String email) async {
    final Database db = await database;
    await db.delete(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
  }

  void clearUsers() async {
    final Database db = await database;
    await db.delete('users');
  }
}
