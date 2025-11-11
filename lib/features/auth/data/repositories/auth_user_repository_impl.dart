import 'package:google_sign_in/google_sign_in.dart';
import 'package:tartile/core/errors/auth_exception_parser.dart';
import 'package:tartile/features/auth/domain/entitites/auth_user_entitiy.dart';
import 'package:tartile/features/auth/domain/repository/auth_user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthUserRepositoryImpl implements AuthUserRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<AuthUser?> register({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (displayName != null && displayName.isNotEmpty) {
        await credential.user!.updateDisplayName(displayName);
      }

      final user = credential.user;
      if (user == null) return null;

      return AuthUser(
        uid: user.uid,
        email: user.email,
        displayName: user.displayName,
        photoURL: user.photoURL,
      );
    } catch (e) {
      throw AuthExceptionParser.parse(e);
    }
  }

  @override
  Future<AuthUser?> login({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = credential.user;
      if (user == null) return null;

      return AuthUser(
        uid: user.uid,
        email: user.email,
        displayName: user.displayName,
        photoURL: user.photoURL,
      );
    } catch (e) {
      throw AuthExceptionParser.parse(e);
    }
  }

  @override
  Future<void> logout() async {
    await _auth.signOut();
  }

  @override
  AuthUser? getCurrentUser() {
    final user = _auth.currentUser;
    if (user == null) return null;

    return AuthUser(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoURL: user.photoURL,
    );
  }

  @override
  Future<User?> loginWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) return null;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final result = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );

      return result.user;
    } catch (e) {
      throw Exception("Login Google gagal: $e");
    }
  }
}
