import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/user_entity.dart';
import 'local_storage_datasource.dart';

class SharedPrefsLocalDataSource implements LocalStorageDataSource {
  static const _keyUid = 'USER_UID';
  static const _keyEmail = 'USER_EMAIL';
  static const _keyName = 'USER_NAME';
  static const _keyPhone = 'USER_PHONE';

  final SharedPreferences prefs;
  SharedPrefsLocalDataSource(this.prefs);

  @override
  Future<void> cacheUser(UserEntity user) async {
    await prefs.setString(_keyUid, user.uid);
    await prefs.setString(_keyEmail, user.email);
    await prefs.setString(_keyName, user.name);
    await prefs.setString(_keyPhone, user.phone);
  }

  @override
  Future<UserEntity?> getCachedUser() async {
    final uid = prefs.getString(_keyUid);
    final email = prefs.getString(_keyEmail);
    final name = prefs.getString(_keyName);
    final phone = prefs.getString(_keyPhone);
    if (uid != null && email != null && name != null && phone != null) {
      return UserEntity(
        uid: uid,
        email: email,
        name: name,
        phone: phone,
      );
    }
    return null;
  }

  @override
  Future<void> clearUser() async {
    await prefs.remove(_keyUid);
    await prefs.remove(_keyEmail);
    await prefs.remove(_keyName);
    await prefs.remove(_keyPhone);
  }
}
