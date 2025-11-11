import 'package:flutter/material.dart';
import 'package:tartile/features/auth/domain/repository/auth_user_repository.dart';
import 'package:tartile/features/auth/presentation/screens/login_screen.dart';

class SignOutDialog extends StatelessWidget {
  final AuthRepository repo;

  const SignOutDialog({super.key, required this.repo});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: const Text(
        'Sign out',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
      ),
      content: const Text('Are you sure you want to sign out?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel', style: TextStyle(color: Colors.grey.shade600)),
        ),
        TextButton(
          onPressed: () async {
            await repo.signOut();

            if (!context.mounted) return;

            Navigator.of(context).pop(); // close dialog
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const LoginScreen()),
            );
          },
          child: Text(
            'Sign out',
            style: TextStyle(color: Colors.blue.shade600),
          ),
        ),
      ],
    );
  }
}
