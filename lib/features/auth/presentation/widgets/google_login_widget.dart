import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tartile/features/auth/presentation/controllers/auth_controller.dart';
import 'package:tartile/features/dashboard/dashboard_feature.dart';

class GoogleLoginButton extends StatelessWidget {
  const GoogleLoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<AuthController>(context);

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: controller.isLoading
            ? null
            : () async {
                try {
                  final ok = await controller.loginWithGoogle();
                  if (ok && context.mounted) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const DashboardFeature(),
                      ),
                    );
                  }
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'account-exists-with-different-credential') {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text('Email sudah terdaftar'),
                        content: const Text(
                          'Coba login menggunakan email dan password yang terdaftar.',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e.message ?? 'Login gagal')),
                    );
                  }
                }
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          side: BorderSide(color: Colors.grey.shade300),
          padding: const EdgeInsets.symmetric(vertical: 14),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.login, color: Colors.red),
            const SizedBox(width: 12),
            const Text(
              'Masuk dengan Google',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
