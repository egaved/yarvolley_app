import 'package:flutter/material.dart';
import 'package:yarvolley_app/presentation/theme/colors.dart';

class SubscribeButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool condition;

  const SubscribeButton({
    super.key,
    required this.onPressed,
    required this.condition,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: condition ? secondaryColor : primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
        minimumSize: condition ? Size(80, 30) : Size(60, 30),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        fixedSize: const Size.fromHeight(30),
      ),
      child: Text(
        condition ? '✓ Подписаны' : 'Подписаться',
        style: const TextStyle(
          fontFamily: 'AppCommonFont',
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
