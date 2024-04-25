import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../config/config.dart';

class CustomButton extends ConsumerWidget {
  final String text;
  final VoidCallback onPressed;
  const CustomButton({required this.text, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: tabColor,
          minimumSize: const Size(double.infinity, 50)),
      onPressed: onPressed,
      child: Center(
        child: Text(
          text,
          style: const TextStyle(color: blackColors),
        ),
      ),
    );
  }
}
