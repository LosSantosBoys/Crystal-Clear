import 'package:flutter/material.dart';
import 'package:crystalclear/core/widgets/custom_button.dart';
import 'package:crystalclear/features/auth/enum/social_enum.dart';
import 'package:crystalclear/features/auth/widgets/social_button.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Container(
              width: 210,
              height: 210,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                  image: AssetImage('assets/images/logo.png'),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Crystal Clear',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Vamos entrar na sua conta!',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
            const Spacer(),
            Column(
              children: [
                const SocialButton(type: SocialEnum.google),
                const SizedBox(height: 10),
                const SocialButton(type: SocialEnum.meta, enabled: false,),
                const SizedBox(height: 10),
                CustomButton(
                  text: 'Login',
                  onPressed: () => Navigator.pushNamed(context, '/login/basic'),
                ),
              ],
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, "/signup");
              },
              child: const Text(
                'Não tem conta? Crie uma.',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
