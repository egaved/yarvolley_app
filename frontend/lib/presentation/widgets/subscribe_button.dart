import 'package:flutter/material.dart';
import 'package:yarvolley_app/presentation/theme/colors.dart';

class SubscribeButton extends StatefulWidget {
  final bool condition;
  final Future<void> future;

  const SubscribeButton({
    super.key,
    required this.future,
    required this.condition,
  });

  @override
  State<SubscribeButton> createState() => _SubscribeButtonState();
}

class _SubscribeButtonState extends State<SubscribeButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        widget.future;
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.condition ? secondaryColor : primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
        minimumSize: Size(60, 30),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        fixedSize: const Size.fromHeight(30),
      ),
      child: Text(
        widget.condition ? 'Отписаться' : 'Подписаться',
        style: const TextStyle(
          fontFamily: 'AppCommonFont',
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
