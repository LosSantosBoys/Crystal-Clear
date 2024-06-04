import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'app_database.db');
    return openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE users(id INTEGER PRIMARY KEY, name TEXT, email TEXT, password TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<bool> checkIfEmailExists(String email) async {
    final db = await database;
    var res = await db.query("users", where: "email = ?", whereArgs: [email]);
    return res.isNotEmpty;
  }

  static Future<int> insertUser(String name, String email, String password) async {
    final db = await database;
    return await db.insert('users', {'name': name, 'email': email, 'password': password});
  }
}
