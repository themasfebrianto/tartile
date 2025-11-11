class AuthUser {
  final String uid;
  final String? email;
  final String? passwordHash;
  final String? displayName;
  final String? photoURL;

  AuthUser({
    required this.uid,
    this.email,
    this.passwordHash,
    this.displayName,
    this.photoURL,
  });
}
