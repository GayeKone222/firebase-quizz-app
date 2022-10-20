import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthenticationProvider {
  final FirebaseAuth _firebaseAuth;
  FirebaseAuthenticationProvider({
    required FirebaseAuth firebaseAuth,
  }) : _firebaseAuth = firebaseAuth;

  Stream<User?> getAuthStates() {
    return _firebaseAuth.authStateChanges();
  }

  Future<User?> login({
    required AuthCredential credential,
  }) async {
    UserCredential userCredential =
        await _firebaseAuth.signInWithCredential(credential);
    return userCredential.user;
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}