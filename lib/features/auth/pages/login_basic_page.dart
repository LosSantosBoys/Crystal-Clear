import 'package:crystalclear/core/enum/service_status.dart';
import 'package:crystalclear/core/models/service_return.dart';
import 'package:crystalclear/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:crystalclear/core/services/auth_service.dart';
import 'package:crystalclear/core/widgets/custom_button.dart';

class LoginBasicPage extends StatefulWidget {
  const LoginBasicPage({super.key});

  @override
  State<LoginBasicPage> createState() => _LoginBasicPageState();
}

class _LoginBasicPageState extends State<LoginBasicPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
            if (_formKey.currentState!.validate()) {
              final String email = emailController.text.trim();
              final String password = passwordController.text.trim();

              final ServiceReturn result = await AuthService().login(email: email, password: password);

              if (result.status == ServiceStatus.success) {
                if (context.mounted) {
                  Navigator.pushNamed(context, '/home');
                }
              } else {
                if (context.mounted) {
                  context.showErrorSnackbar("E-mail ou senha incorretos.");
                }
              }
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
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
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: 'E-mail',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira um e-mail.';
                            }

                            return null;
                          },
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
                        TextFormField(
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira uma senha.';
                            }

                            return null;
                          },
                          obscureText: !showPassword,
                        ),
                      ],
                    ),
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
                    onPressed: () => Navigator.pushNamed(context, '/forgot-password'),
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
