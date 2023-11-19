import 'package:flutter/material.dart';

class CustomTextInput extends StatelessWidget {
  const CustomTextInput({
    super.key,
    required this.usernameController,
    required this.keyboardType,
    required this.textHint,
  });

  final TextEditingController usernameController;
  final TextInputType keyboardType;
  final String textHint;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: usernameController,
      keyboardType: keyboardType,
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(18),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: Color(0xffF5F9FE),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: Color(0xff2A4ECA),
          ),
        ),
        hintStyle: const TextStyle(
          color: Color(0xff7C8BA0),
        ),
        hintText: textHint,
      ),
    );
  }
}
