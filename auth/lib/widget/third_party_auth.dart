import 'package:flutter/material.dart';

class ThirdPartyAuth extends StatelessWidget {
  final Function() onTap;
  final String iconUrl;
  final String title;

  const ThirdPartyAuth({
    super.key,
    required this.onTap,
    required this.iconUrl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onTap,
      icon: Image.asset(iconUrl),
      label: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Color(0xff61677D),
        ),
      ),
    );
  }
}
