import 'package:crystalclear/core/enum/service_status.dart';
import 'package:crystalclear/core/models/service_return.dart';
import 'package:crystalclear/core/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:crystalclear/core/utils/utils.dart';
import 'package:crystalclear/features/auth/enum/social_enum.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
    required this.type,
    this.enabled = true,
  });

  final SocialEnum type;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: enabled ? () async {
        switch (type) {
          case SocialEnum.google:
            final ServiceReturn result = await AuthService().loginWithGoogle();

            if (result.status == ServiceStatus.success) {
              if (context.mounted) {
                Navigator.pushNamed(context, '/home');
              }
            }
            return;
          case SocialEnum.meta:
            // todo: add login with meta
            return;
          default:
            return;
        }
      } : null,

      style: TextButton.styleFrom(
        minimumSize: const Size(double.infinity, 44),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(
            color: Color(0xFFD9D9D9),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Image(
            image: AssetImage(
              "assets/icons/${type.name}.png",
            ),
            color: enabled ? null : Colors.grey,
            semanticLabel: "Ícone da empresa ${type.name.capitalize()}",
          ),
          const Spacer(),
          Text(
            "Login com ${type.name.capitalize()}",
            style: TextStyle(
              fontSize: 16,
              color: enabled ? Colors.black : Colors.grey,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
