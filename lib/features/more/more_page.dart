import 'package:crystalclear/core/enum/service_status.dart';
import 'package:crystalclear/core/models/service_return.dart';
import 'package:crystalclear/core/services/auth_service.dart';
import 'package:crystalclear/core/utils/utils.dart';
import 'package:crystalclear/core/widgets/avatar.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class MoreDrawer extends StatelessWidget {
  const MoreDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width,
      shape: const RoundedRectangleBorder(),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, top: 30, bottom: 15),
            child: Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    AuthService().getUser()?.displayName ?? "Usuário",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox.square(
                        dimension: 54,
                        child: Avatar(
                          name: AuthService().getUser()?.displayName ?? "Usuário",
                          photoURL: AuthService().getUser()?.photoURL,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      children: [
                        Icon(Icons.stars_outlined),
                        SizedBox(height: 5),
                        Text(
                          "0",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "pontos",
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                    const Column(
                      children: [
                        Icon(Icons.emoji_events_outlined),
                        SizedBox(height: 5),
                        Text(
                          "0",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "conquistas",
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Icon(Icons.event),
                        const SizedBox(height: 5),
                        Text(
                          timeago.format(AuthService().getUser()?.metadata.creationTime ?? DateTime.now(), locale: 'pt_BR_short'),
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Text(
                          "ativo",
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.notifications_outlined),
            title: const Text("Notificações"),
            contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.discount_outlined),
            title: const Text("Recompensas"),
            contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.store_outlined),
            title: const Text("Loja"),
            contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.school_outlined),
            title: const Text("Educação"),
            contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.calendar_month_outlined),
            title: const Text("Eventos da Comunidade"),
            contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
            onTap: () {},
          ),
          const Divider(
            indent: 54,
            endIndent: 54,
          ),
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text("Configurações"),
            contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
            onTap: () => Navigator.pushNamed(context, '/settings'),
          ),
          ListTile(
            leading: const Icon(Icons.help_outline),
            title: const Text("Ajuda"),
            contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app_outlined),
            title: const Text("Sair"),
            contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
            onTap: () async {
              final ServiceReturn result = await AuthService().logout();

              if (result.status == ServiceStatus.success) {
                if (context.mounted) {
                  Navigator.pushReplacementNamed(context, '/login');
                }
              } else {
                if (context.mounted) {
                  context.showErrorSnackbar("Erro ao sair. Tente novamente.");
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
