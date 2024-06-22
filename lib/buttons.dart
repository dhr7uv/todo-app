import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.text,
    required this.OnPressed
  });

  final String text;
  final VoidCallback OnPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: OnPressed,
      child: Text(text),
      color: Colors.yellow.shade400,
    );
  }
}
