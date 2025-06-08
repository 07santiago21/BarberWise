import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../datasources/local_storage_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;
  final LocalStorageDataSource local;

  AuthRepositoryImpl({required this.remote, required this.local});

  @override
  Future<UserEntity> signIn(String email, String pass) async {
    final cred = await remote.signIn(email, pass);
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(cred.user!.uid)
        .get();
    final data = doc.data()!;
    final user = UserEntity(
      uid: cred.user!.uid,
      email: data['email'],
      name: data['name'],
      phone: data['phone'],
    );
    await local.cacheUser(user);
    return user;
  }

  @override
  Future<UserEntity> signUp(
      String name, String phone, String email, String pass) async {
    final cred = await remote.signUp(name, phone, email, pass);
    final user = UserEntity(
      uid: cred.user!.uid,
      email: email,
      name: name,
      phone: phone,
    );
    await local.cacheUser(user);
    return user;
  }

  @override
  Future<void> signOut() async {
    await remote.signOut();
    await local.clearUser();
  }

  @override
  Future<UserEntity?> getCachedUser() {
    return local.getCachedUser();
  }

  @override
  Future<void> updateProfile(String name, String phone) async {
    final user = await local.getCachedUser();
    if (user == null) throw Exception('No user cached');
    await remote.updateProfile(user.uid, name, phone);
    final updated = UserEntity(
      uid: user.uid,
      email: user.email,
      name: name,
      phone: phone,
    );
    await local.cacheUser(updated);
  }

  @override
  Future<void> changePassword(String newPassword) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('No hay usuario autenticado');
    }
    await user.updatePassword(newPassword);
  }
}
