import 'package:sqflite/sqflite.dart';
import '../core/utils/database_helper.dart';
import 'user_preferences_dto.dart';

class UserPreferencesDao {
  Future<Database> get _db async => await DatabaseHelper().database;

  Future<UserPreferencesDto?> getUserPreferencesById(String userId) async {
    final db = await _db;
    final List<Map<String, dynamic>> maps = await db.query(
      'user_preferences',
      where: 'userId = ?',
      whereArgs: [userId],
    );
    if (maps.isNotEmpty) {
      return UserPreferencesDto.fromJson(maps.first);
    }
    return null;
  }

  Future<void> insertUserPreferences(UserPreferencesDto prefs) async {
    final db = await _db;
    await db.insert(
      'user_preferences',
      prefs.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateUserPreferences(UserPreferencesDto prefs) async {
    final db = await _db;
    await db.update(
      'user_preferences',
      prefs.toJson(),
      where: 'userId = ?',
      whereArgs: [prefs.userId],
    );
  }

  Future<void> deleteUserPreferences(String userId) async {
    final db = await _db;
    await db.delete(
      'user_preferences',
      where: 'userId = ?',
      whereArgs: [userId],
    );
  }
} 