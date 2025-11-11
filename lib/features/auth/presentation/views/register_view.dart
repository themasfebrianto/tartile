import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tartile/features/Dashboard/dashboard_feature.dart';
import 'package:tartile/features/auth/presentation/controllers/auth_controller.dart';
import 'package:tartile/features/auth/presentation/widgets/login_header_widget.dart';
import 'package:tartile/features/auth/presentation/widgets/register_form_widget.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final email = TextEditingController();
  final pass = TextEditingController();
  final confirm = TextEditingController();

  Future<void> _submit() async {
    if (pass.text != confirm.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Password tidak sama")));
      return;
    }

    final controller = context.read<AuthController>();
    final ok = await controller.register(email.text.trim(), pass.text.trim());

    if (!mounted) return;

    if (ok) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const DashboardFeature()),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Register gagal")));
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = context.watch<AuthController>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 32),

              const LoginHeader(),

              const SizedBox(height: 32),

              RegisterForm(email: email, pass: pass, confirm: confirm),

              const SizedBox(height: 24),

              c.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _submit,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Daftar',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
