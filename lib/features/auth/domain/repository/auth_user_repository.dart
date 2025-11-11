import 'package:tartile/features/auth/domain/entitites/auth_user_entitiy.dart';

abstract class AuthUserRepository {
  Future<AuthUser?> register({
    required String email,
    required String password,
    String? displayName,
  });

  Future<AuthUser?> login({required String email, required String password});

  Future<void> logout();

  AuthUser? getCurrentUser();
}
