import 'package:firebase_auth/firebase_auth.dart';
import 'package:tartile/features/auth/domain/entitites/auth_user_entitiy.dart';

abstract class AuthRepository {
  Future<AuthUser?> signInWithGoogle();
  Future<void> signOut();
  Stream<User?> get authStateChanges;
  User? get currentUser;
}
