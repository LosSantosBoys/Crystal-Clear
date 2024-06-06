import 'package:crystalclear/core/enum/service_status.dart';
import 'package:crystalclear/core/models/service_return.dart';
import 'package:crystalclear/core/services/auth_service.dart';
import 'package:crystalclear/core/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Configurações"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Wrap(
          runSpacing: 5,
          children: [
            ListTile(
              title: const Text("Conta"),
              leading: const Icon(Icons.account_circle_outlined),
              contentPadding: EdgeInsets.zero,
              onTap: () {},
            ),
            ListTile(
              title: const Text("Notificações"),
              leading: const Icon(Icons.notifications_outlined),
              contentPadding: EdgeInsets.zero,
              onTap: () {},
            ),
            ListTile(
              title: const Text("Privacidade"),
              leading: const Icon(Icons.privacy_tip_outlined),
              contentPadding: EdgeInsets.zero,
              onTap: () {},
            ),
            ListTile(
              title: const Text("Segurança"),
              leading: const Icon(Icons.security_outlined),
              contentPadding: EdgeInsets.zero,
              onTap: () {},
            ),
            const ListTile(
              title: Text("Idioma"),
              subtitle: Text("Português"),
              leading: Icon(Icons.language_outlined),
              contentPadding: EdgeInsets.zero,
            ),
            ListTile(
              title: const Text("Deletar conta"),
              leading: const Icon(
                Icons.delete_forever_outlined,
                color: Color(0xFFE30000),
              ),
              contentPadding: EdgeInsets.zero,
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Deletar conta"),
                      content: const Text("Tem certeza que deseja deletar sua conta?"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Cancelar"),
                        ),
                        TextButton(
                          onPressed: () async {
                            final ServiceReturn result = await AuthService().deleteAccount();

                            if (result.status == ServiceStatus.success) {
                              if (context.mounted) {
                                context.showSuccessSnackbar("Conta deletada com sucesso.");
                                Navigator.pushReplacementNamed(context, '/login');
                              }
                            } else {
                              if (kDebugMode) {
                                print("Error: ${result.message}");
                              }

                              if (context.mounted) {
                                Navigator.pop(context);
                                context.showErrorSnackbar(result.message ?? "Houve um erro ao deletar a conta. Tente novamente.");
                              }
                            }
                          },
                          child: const Text("Deletar"),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
