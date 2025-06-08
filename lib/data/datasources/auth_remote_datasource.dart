import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRemoteDataSource {
  Future<UserCredential> signIn(String email, String pass);
  Future<UserCredential> signUp(String email, String pass);
  Future<void> signOut();
}
