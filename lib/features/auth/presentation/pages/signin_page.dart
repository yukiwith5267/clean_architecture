import 'package:app/features/auth/presentation/widgets/auth_button.dart';
import 'package:app/features/auth/presentation/widgets/auth_field.dart';
import 'package:flutter/material.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(height: 100),
              const Text('Sign In',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 80),
              AuthField(
                controller: emailController,
                hintText: 'Email',
              ),
              const SizedBox(height: 30),
              AuthField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),
              const SizedBox(height: 30),
              AuthButton(
                text: 'Sign In',
                onPressed: () {},
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
