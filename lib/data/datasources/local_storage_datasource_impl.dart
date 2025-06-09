import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/user_entity.dart';

class SharedPrefsLocalDataSource {
  static const _keyUser = 'cached_user';
  final SharedPreferences _prefs;
  SharedPrefsLocalDataSource(this._prefs);

  Future<void> cacheUser(UserEntity user) async {
    final json = jsonEncode(user.toMap());
    await _prefs.setString(_keyUser, json);
  }

  Future<UserEntity?> getCachedUser() async {
    final str = _prefs.getString(_keyUser);
    if (str == null) return null;
    final map = jsonDecode(str) as Map<String, dynamic>;
    return UserEntity.fromMap(map);
  }

  Future<void> clearUser() async {
    await _prefs.remove(_keyUser);
  }
}
