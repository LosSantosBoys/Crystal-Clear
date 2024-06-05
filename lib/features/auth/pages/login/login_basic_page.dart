import 'package:flutter/material.dart';
import 'package:project/core/services/auth_service.dart';
import 'package:project/core/widgets/custom_button.dart';

class LoginBasicPage extends StatefulWidget {
  const LoginBasicPage({super.key});

  @override
  State<LoginBasicPage> createState() => _LoginBasicPageState();
}

class _LoginBasicPageState extends State<LoginBasicPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  
  bool showPassword = false;
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24.0),
        child: CustomButton(
          text: 'Login',
          onPressed: () async {
            bool isAuthenticated = await AuthService.login(
              emailController.text,
              passwordController.text,
            );
            if (isAuthenticated) {
              // Navegar para a próxima tela
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Login bem-sucedido!'),
                  ),
                );
              }
            } else {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Email ou senha incorretos!'),
                  ),
                );
              }
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Bem-vindo novamente!",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Por favor, insira seu e-mail e senha para entrar.",
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "E-mail",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'E-mail',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Senha",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      hintText: 'Senha',
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                        icon: Icon(
                          showPassword ? Icons.visibility_off : Icons.visibility,
                          color: const Color(0xFF7d7d7d),
                        ),
                      ),
                    ),
                    obscureText: !showPassword,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            CheckboxListTile(
              value: rememberMe,
              onChanged: (_) {
                setState(() {
                  rememberMe = !rememberMe;
                });
              },
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Lembrar-me"),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Esqueceu a senha?",
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              endIndent: 24,
              indent: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
            )
          ],
        ),
      ),
    );
  }
}
