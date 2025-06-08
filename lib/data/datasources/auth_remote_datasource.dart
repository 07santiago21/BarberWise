import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRemoteDataSource {
  Future<UserCredential> signIn(String email, String pass);
  Future<UserCredential> signUp(
      String name, String phone, String email, String pass);
  Future<void> signOut();
  Future<void> updateProfile(String uid, String name, String phone);
  Future<void> updatePassword(String newPassword);
}
