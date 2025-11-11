import 'package:firebase_auth/firebase_auth.dart';

class AuthFailure implements Exception {
  final String message;
  AuthFailure(this.message);

  @override
  String toString() => message;
}

class AuthExceptionParser {
  static AuthFailure parse(dynamic error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'invalid-email':
          return AuthFailure('Format email tidak valid');

        case 'user-not-found':
          return AuthFailure('Akun tidak ditemukan');

        case 'wrong-password':
        case 'invalid-password':
        case 'invalid-credential':
        case 'invalid-login-credentials':
          return AuthFailure('Email atau password salah');

        case 'email-already-in-use':
          return AuthFailure('Email sudah terdaftar');

        case 'weak-password':
          return AuthFailure('Password terlalu lemah (minimal 6 karakter)');

        case 'operation-not-allowed':
          return AuthFailure('Operasi tidak diperbolehkan, hubungi admin');

        case 'too-many-requests':
          return AuthFailure('Terlalu banyak percobaan, coba lagi nanti');

        default:
          return AuthFailure(error.message ?? 'Terjadi kesalahan autentikasi');
      }
    }

    // Fallback untuk error lain
    return AuthFailure(error.toString().replaceAll('Exception:', '').trim());
  }
}
