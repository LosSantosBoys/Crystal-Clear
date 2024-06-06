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
        db.execute(
          'CREATE TABLE users(id INTEGER PRIMARY KEY, name TEXT, email TEXT, password TEXT)',
        );
        db.execute(
          'CREATE TABLE trash_reports(id INTEGER PRIMARY KEY, user_id INTEGER, description TEXT, category TEXT, image_path TEXT, location TEXT, quantity INTEGER, item TEXT)',
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

  static Future<int> insertTrashReport(int userId, String description, String category, String imagePath, String location, int quantity, String item) async {
    final db = await database;
    return await db.insert('trash_reports', {
      'user_id': userId,
      'description': description,
      'category': category,
      'image_path': imagePath,
      'location': location,
      'quantity': quantity,
      'item': item,
    });
  }

  static Future<List<Map<String, dynamic>>> getAllTrashReports() async {
    final db = await database;
    var res = await db.query('trash_reports');
    return res;
  }
}
