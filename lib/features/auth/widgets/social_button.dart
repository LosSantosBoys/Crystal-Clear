import 'package:flutter/material.dart';
import 'package:project/core/utils/utils.dart';
import 'package:project/features/auth/enum/social_enum.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({super.key, required this.type});

  final SocialEnum type;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        switch (type) {
          case SocialEnum.google:
            // todo: add login with google
            return;
          case SocialEnum.meta:
            // todo: add login with meta
            return;
          default:
            return;
        }
      },
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
            semanticLabel: "Ícone da empresa ${type.name.capitalize()}",
          ),
          const Spacer(),
          Text(
            "Login com ${type.name.capitalize()}",
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
