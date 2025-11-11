import 'package:flutter/material.dart';

class RegisterForm extends StatelessWidget {
  final TextEditingController email;
  final TextEditingController pass;
  final TextEditingController confirm;

  const RegisterForm({
    super.key,
    required this.email,
    required this.pass,
    required this.confirm,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Email
        TextField(
          controller: email,
          decoration: InputDecoration(
            labelText: 'Email',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            prefixIcon: const Icon(Icons.email_outlined),
          ),
        ),
        // Password
        const SizedBox(height: 16),
        TextField(
          controller: pass,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            prefixIcon: const Icon(Icons.lock_outline),
          ),
        ),

        // Confirm Password
        const SizedBox(height: 16),
        TextField(
          controller: confirm,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Confirm Password',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            prefixIcon: const Icon(Icons.lock_clock_rounded),
          ),
        ),
      ],
    );
  }
}
