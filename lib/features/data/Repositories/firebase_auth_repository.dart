import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_study_app/features/data/providers/firebase_auth_providers.dart';
import 'package:firebase_study_app/features/data/providers/google_signin_provider.dart';
import 'package:firebase_study_app/features/domain/models/auth_details_model.dart';

class RepositoryFirebaseAuthentication {
  final FirebaseAuthenticationProvider _authenticationFirebaseProvider;
  final GoogleSignInProvider _googleSignInProvider;
  RepositoryFirebaseAuthentication(
      {required FirebaseAuthenticationProvider authenticationFirebaseProvider,
      required GoogleSignInProvider googleSignInProvider})
      : _googleSignInProvider = googleSignInProvider,
        _authenticationFirebaseProvider = authenticationFirebaseProvider;

  Stream<AuthenticationDetailModel> getAuthDetailStream() {
    return _authenticationFirebaseProvider.getAuthStates().map((user) {
      return _getAuthDetailModelFromFirebaseUser(user: user);
    });
  }

  Future<AuthenticationDetailModel> authenticateWithGoogle() async {
    User? user = await _authenticationFirebaseProvider.login(
        credential: await _googleSignInProvider.login());
    return _getAuthDetailModelFromFirebaseUser(user: user);
  }

  Future<void> unAuthenticate() async {
    await _googleSignInProvider.logout();
    await _authenticationFirebaseProvider.logout();
  }

  AuthenticationDetailModel _getAuthDetailModelFromFirebaseUser(
      {required User? user}) {
    AuthenticationDetailModel authDetail;
    if (user != null) {
      authDetail = AuthenticationDetailModel(
        isValid: true,
        uid: user.uid,
        email: user.email,
        photoUrl: user.photoURL,
        name: user.displayName,
      );
    } else {
      authDetail = const AuthenticationDetailModel(isValid: false);
    }
    return authDetail;
  }
}