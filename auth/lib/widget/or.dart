import 'package:flutter/material.dart';

class OrSeparate extends StatelessWidget {
  const OrSeparate({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: Divider(
            color: Color(0xffE0E5EC),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'OR',
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: Color(0xffE0E5EC),
          ),
        ),
      ],
    );
  }
}
