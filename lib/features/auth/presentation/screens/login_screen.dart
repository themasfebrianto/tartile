import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tartile/features/auth/data/repositories/auth_user_repository_impl.dart';
import 'package:tartile/features/auth/presentation/controllers/auth_controller.dart';
import 'package:tartile/features/auth/presentation/views/login_view.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthController(AuthUserRepositoryImpl()),
      child: const LoginView(),
    );
  }
}
