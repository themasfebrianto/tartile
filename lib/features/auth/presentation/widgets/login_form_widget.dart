import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tartile/features/Dashboard/dashboard_feature.dart';
import 'package:tartile/features/auth/presentation/controllers/auth_controller.dart';
import 'package:tartile/features/auth/presentation/screens/register_screen.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select<AuthController, bool>((c) => c.isLoading);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: email,
          decoration: InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            prefixIcon: const Icon(Icons.email_outlined),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: password,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            prefixIcon: const Icon(Icons.lock_outline),
          ),
        ),
        const SizedBox(height: 24),
        isLoading
            ? const Center(child: CircularProgressIndicator())
            : ElevatedButton(
                onPressed: () async {
                  final controller = context.read<AuthController>();
                  final ok = await controller.login(
                    email.text.trim(),
                    password.text.trim(),
                  );

                  if (!context.mounted) return;

                  if (ok) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const DashboardFeature(),
                      ),
                    );
                  } else if (controller.errorMessage != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(controller.errorMessage!)),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
        const SizedBox(height: 16),
        OutlinedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => RegisterScreen()),
            );
          },
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 14),
            side: BorderSide(color: Colors.grey.shade300),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'Belum punya akun? Daftar',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
