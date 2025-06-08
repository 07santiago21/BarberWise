import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_remote_datasource.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<UserCredential> signIn(String email, String pass) {
    return _auth.signInWithEmailAndPassword(email: email, password: pass);
  }

  @override
  Future<UserCredential> signUp(
      String name, String phone, String email, String pass) async {
    final cred = await _auth.createUserWithEmailAndPassword(
        email: email, password: pass);
    await cred.user!.updateDisplayName(name);
    await _firestore.collection('users').doc(cred.user!.uid).set({
      'name': name,
      'phone': phone,
      'email': email,
      'createdAt': FieldValue.serverTimestamp(),
    });
    return cred;
  }

  @override
  Future<void> signOut() => _auth.signOut();

  @override
  Future<void> updateProfile(String uid, String name, String phone) {
    return _firestore.collection('users').doc(uid).update({
      'name': name,
      'phone': phone,
    });
  }

  @override
  Future<void> updatePassword(String newPassword) {
    return FirebaseAuth.instance.currentUser!.updatePassword(newPassword);
  }
}
