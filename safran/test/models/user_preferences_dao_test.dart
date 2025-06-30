import 'package:flutter_test/flutter_test.dart';
import 'package:safran/models/user_preferences_dao.dart';
import 'package:safran/models/user_preferences_dto.dart';

void main() {
  final dao = UserPreferencesDao();

  test('CRUD UserPreferences', () async {
    final userId = 'test_user';
    final prefs = UserPreferencesDto(userId: userId, darkMode: true, language: 'fr');

    // Insert
    await dao.insertUserPreferences(prefs);
    var loaded = await dao.getUserPreferencesById(userId);
    expect(loaded?.darkMode, true);
    expect(loaded?.language, 'fr');

    // Update
    await dao.updateUserPreferences(UserPreferencesDto(userId: userId, darkMode: false, language: 'en'));
    loaded = await dao.getUserPreferencesById(userId);
    expect(loaded?.darkMode, false);
    expect(loaded?.language, 'en');

    // Delete
    await dao.deleteUserPreferences(userId);
    loaded = await dao.getUserPreferencesById(userId);
    expect(loaded, isNull);
  });
} 