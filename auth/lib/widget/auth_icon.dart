import 'package:flutter/material.dart';

class AuthIcon extends StatelessWidget {
  final String iconUrl;

  const AuthIcon({super.key, required this.iconUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: const Color(0xffD6DFFF),
      ),
      child: Image.asset(iconUrl),
    );
  }
}
