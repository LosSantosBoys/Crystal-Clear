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
          'CREATE TABLE users(id INTEGER PRIMARY KEY, name TEXT, email TEXT, password TEXT, points INTEGER)',
        );
        db.execute(
          'CREATE TABLE trash_reports(id INTEGER PRIMARY KEY, id_issuer INTEGER, description TEXT, category TEXT, image_path TEXT, latitude TEXT, longitude TEXT, quantity INTEGER, item TEXT, points INTEGER, is_available INTEGER, is_done INTEGER, id_assignee INTEGER)',
        );
        db.execute(
          'CREATE TABLE trash_collect(id INTEGER PRIMARY KEY, id_report INTEGER, id_assignee INTEGER, created_at TEXT, is_done INTEGER, address TEXT, image_path TEXT)',
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

  static Future<int> insertTrashReport(
    int userId,
    String description,
    String category,
    String imagePath,
    String? latitude,
    String? longitude,
    int quantity,
    String item,
  ) async {
    final db = await database;
    return await db.insert('trash_reports', {
      'id_issuer': userId,
      'description': description,
      'category': category,
      'image_path': imagePath,
      'latitude': latitude,
      'longitude': longitude,
      'quantity': quantity,
      'item': item,
      'points': quantity,
      'is_available': 1,
      'is_done': 0
    });
  }

  static Future<List<Map<String, dynamic>>> getAllTrashReports() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query('trash_reports', where: 'is_available = ? AND is_done = ?', whereArgs: [1, 0]);
    return result;
  }

  static Future<Map<String, dynamic>> getTrashReportById(int id) async {
    final db = await database;
    var res = await db.query("trash_reports", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? res.first : throw Exception('Report not found');
  }

  static Future<void> updateTrashReportAssignee(int id, int assigneeId) async {
    final db = await database;
    await db.update(
      'trash_reports',
      {'id_assignee': assigneeId, 'is_available': 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<List<Map<String, dynamic>>> getActiveTrashReports(int userId) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query('trash_reports', where: 'id_assignee = ? AND is_done = ?', whereArgs: [userId, 0]);
    return result;
  }

  static Future<int> insertTrashCollect(int idReport, int idAssignee, String createdAt, int isDone, String address) async {
    final db = await database;
    return await db.insert('trash_collect', {'id_report': idReport, 'id_assignee': idAssignee, 'created_at': createdAt, 'is_done': isDone, 'address': address});
  }

  static Future<List<Map<String, dynamic>>> getActiveTrashCollect(int userId) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.rawQuery('''
      SELECT trash_collect.*, trash_reports.item, trash_reports.image_path
      FROM trash_collect
      INNER JOIN trash_reports ON trash_collect.id_report = trash_reports.id
      WHERE trash_collect.id_assignee = ? AND trash_collect.is_done = ?
    ''', [userId, 0]);
    return result;
  }

  static Future<List<Map<String, dynamic>>> getAllDoneTrashCollect(int userId) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.rawQuery('''
      SELECT trash_collect.*, trash_reports.item, trash_reports.image_path
      FROM trash_collect
      INNER JOIN trash_reports ON trash_collect.id_report = trash_reports.id
      WHERE trash_collect.id_assignee = ? AND trash_collect.is_done = ?
    ''', [userId, 1]);
    return result;
  }

  static Future<void> markTrashCollectionAsDone(int trashReportId, int trashCollectId, String imagePath) async {
    final db = await database;
    await db.rawUpdate('UPDATE trash_reports SET is_done = 1 WHERE id = ?', [trashReportId]);
    await db.rawUpdate('UPDATE trash_collect SET is_done = 1, image_path = ? where id = ?', [imagePath, trashCollectId]);
  }

  static Future<void> updateUserPoints(int userId, int points) async {
    final db = await database;
    await db.rawUpdate(
      'UPDATE users SET points = points + ? WHERE id = ?',
      [points, userId],
    );
  }

  static Future<List<Map<String, dynamic>>> getActiveTrashCollectWithDetails(int userId) async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.rawQuery('''
    SELECT trash_collect.*, trash_reports.item, trash_reports.image_path, trash_reports.latitude, trash_reports.longitude, trash_reports.created_at, trash_reports.points as report_points
    FROM trash_collect
    INNER JOIN trash_reports ON trash_collect.id_report = trash_reports.id
    WHERE trash_collect.id_assignee = ? AND trash_collect.is_done = ?
  ''', [userId, 0]);
    return result;
  }
}
