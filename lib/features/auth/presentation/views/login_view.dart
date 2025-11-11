import 'package:flutter/material.dart';
import 'package:tartile/features/auth/presentation/widgets/google_login_widget.dart';
import 'package:tartile/features/auth/presentation/widgets/login_form_widget.dart';
import 'package:tartile/features/auth/presentation/widgets/login_header_widget.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 32),
              const LoginHeader(),
              const SizedBox(height: 32),
              LoginForm(),
              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 16),
              const GoogleLoginButton(),
            ],
          ),
        ),
      ),
    );
  }
}
