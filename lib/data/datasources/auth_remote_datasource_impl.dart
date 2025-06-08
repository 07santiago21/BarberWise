import 'package:firebase_auth/firebase_auth.dart';
import 'auth_remote_datasource.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<UserCredential> signIn(String email, String pass) {
    return _auth.signInWithEmailAndPassword(email: email, password: pass);
  }

  @override
  Future<UserCredential> signUp(String email, String pass) {
    return _auth.createUserWithEmailAndPassword(email: email, password: pass);
  }

  @override
  Future<void> signOut() {
    return _auth.signOut();
  }
}
