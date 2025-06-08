import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/user_entity.dart';
import 'local_storage_datasource.dart';

class SharedPrefsLocalDataSource implements LocalStorageDataSource {
  static const _keyUid = 'USER_UID';
  static const _keyEmail = 'USER_EMAIL';

  final SharedPreferences prefs;
  SharedPrefsLocalDataSource(this.prefs);

  @override
  Future<void> cacheUser(UserEntity user) async {
    await prefs.setString(_keyUid, user.uid);
    await prefs.setString(_keyEmail, user.email);
  }

  @override
  Future<UserEntity?> getCachedUser() async {
    final uid = prefs.getString(_keyUid);
    final email = prefs.getString(_keyEmail);
    if (uid != null && email != null) {
      return UserEntity(uid: uid, email: email);
    }
    return null;
  }

  @override
  Future<void> clearUser() async {
    await prefs.remove(_keyUid);
    await prefs.remove(_keyEmail);
  }
}
