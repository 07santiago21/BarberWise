import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/user_entity.dart';

abstract class AuthRemoteDataSource {
  Future<UserEntity> signUp(
      String name, String phone, String email, String pass);
  Future<UserEntity> signIn(String email, String pass);
  Future<void> signOut();
  Future<void> updateProfile(String name, String phone);
  Future<void> changePassword(String newPassword);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  @override
  Future<UserEntity> signUp(
      String name, String phone, String email, String pass) async {
    final cred = await _auth.createUserWithEmailAndPassword(
        email: email, password: pass);
    final user = cred.user!;
    // 1) Crea el documento en Firestore
    final doc = _firestore.collection('users').doc(user.uid);
    await doc.set({
      'uid': user.uid,
      'email': email,
      'name': name,
      'phone': phone,
    });
    return UserEntity(uid: user.uid, email: email, name: name, phone: phone);
  }

  @override
  Future<UserEntity> signIn(String email, String pass) async {
    final cred =
        await _auth.signInWithEmailAndPassword(email: email, password: pass);
    final user = cred.user!;
    // 2) Recupera el perfil desde Firestore
    final snap = await _firestore.collection('users').doc(user.uid).get();
    final data = snap.data()!;
    return UserEntity.fromMap(data);
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }

  @override
  Future<void> updateProfile(String name, String phone) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('No user');
    await _firestore.collection('users').doc(user.uid).update({
      'name': name,
      'phone': phone,
    });
  }

  @override
  Future<void> changePassword(String newPassword) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('No user');
    await user.updatePassword(newPassword);
  }
}
