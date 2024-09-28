import 'package:app/core/common/widget/loader.dart';
import 'package:app/core/theme/app_pallete.dart';
import 'package:app/core/utils/show_snackbar.dart';
import 'package:app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:app/features/auth/presentation/pages/signin_page.dart';
import 'package:app/features/auth/presentation/widgets/auth_button.dart';
import 'package:app/features/auth/presentation/widgets/auth_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthFailure) {
                showSnackBar(context, state.message);
              } else if (state is AuthSuccess) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SigninPage()),
                );
              }
            },
            builder: (context, state) {
              if (state is AuthLoading) {
                return const Loader();
              }
              return Column(
                children: [
                  const SizedBox(height: 100),
                  const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 80),
                  AuthField(
                    controller: nameController,
                    hintText: 'Name',
                  ),
                  const SizedBox(height: 30),
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
                    text: 'Sign Up',
                    onPressed: () {
                      if (emailController.text.isEmpty ||
                          passwordController.text.isEmpty ||
                          nameController.text.isEmpty) {
                        showSnackBar(context, 'Please fill in all fields');
                        return;
                      }
                      if (!_isEmailValid(emailController.text)) {
                        showSnackBar(context, 'Please enter a valid email');
                        return;
                      }
                      if (passwordController.text.length < 6) {
                        showSnackBar(
                            context, 'Password must be at least 6 characters');
                        return;
                      }
                      context.read<AuthBloc>().add(AuthSignUp(
                            email: emailController.text,
                            password: passwordController.text,
                            name: nameController.text,
                          ));
                    },
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SigninPage()),
                      );
                    },
                    child: RichText(
                      text: const TextSpan(
                        text: 'Already have an account?',
                        style: TextStyle(color: AppPallete.greyColor),
                        children: [
                          TextSpan(
                            text: ' Sign In',
                            style: TextStyle(color: AppPallete.gradient1),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  // Simple email validation method
  bool _isEmailValid(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }
}
