

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository{

  final auth = FirebaseAuth.instance;

  Stream<User?> authStateChanges() => auth.authStateChanges();

  Future<UserCredential> register({
    required String email,
    required String password,
  }) =>
      auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) =>
      auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

  Future<void> signOut() => auth.signOut();

  Future<UserCredential> signInWithGoogle() async {
    final googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      throw FirebaseAuthException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user',
      );
    }
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );
    return auth.signInWithCredential(credential);
  }


}



