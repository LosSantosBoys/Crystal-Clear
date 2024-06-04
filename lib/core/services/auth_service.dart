import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:sqflite/sqflite.dart';
import 'db_service.dart';

class AuthService {
  static String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  static Future<bool> login(String email, String password) async {
    final db = await DatabaseService.database;
    final hashedPassword = _hashPassword(password);
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, hashedPassword],
    );

    return maps.isNotEmpty;
  }

  static Future<void> register(String name, String email, String password) async {
    final db = await DatabaseService.database;
    final hashedPassword = _hashPassword(password);
    await db.insert(
      'users',
      {'name': name, 'email': email, 'password': hashedPassword},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
