import 'package:flutter/material.dart';
import 'package:tartile/features/auth/domain/repository/auth_user_repository.dart';

class AuthController extends ChangeNotifier {
  final AuthUserRepository repo;

  bool isLoading = false;
  String? errorMessage;

  AuthController(this.repo);

  Future<bool> login(String email, String password) async {
    _setLoading(true);
    try {
      final user = await repo.login(email: email, password: password);
      if (user == null) {
        errorMessage = "Email atau password salah";
      }
      return user != null;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> loginWithGoogle() async {
    _setLoading(true);
    try {
      final user = await repo.loginWithGoogle();
      if (user == null) {
        errorMessage = "Login Google dibatalkan";
      }
      return user != null;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> register(String email, String password) async {
    _setLoading(true);
    try {
      final user = await repo.register(email: email, password: password);
      if (user == null) {
        errorMessage = "Register gagal";
      }
      return user != null;
    } catch (e) {
      errorMessage = e.toString();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
