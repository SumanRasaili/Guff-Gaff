import 'package:flutter/material.dart';
import 'package:guffgaff/common/widgets/custom_button.dart';
import 'package:guffgaff/config/config.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LandingScreen extends ConsumerWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 50,
        ),
        const Text(
          "Welcome to Guff Gaff",
          style: TextStyle(fontSize: 33, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: size.height / 9,
        ),
        Image.asset(
          'assets/images/bg.png',
          height: 340,
          width: 340,
          color: tabColor,
        ),
        SizedBox(
          height: size.height / 9,
        ),
        const Padding(
          padding: EdgeInsets.all(15.0),
          child: Text(
            'Read our Privacy Policy. Tap "Agree and continue" to accept the Terms of Service',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: greyColor,
            ),
          ),
        ),
        SizedBox(
            width: size.width * 0.80,
            child: CustomButton(
              text: "AGREE & CONTINUE",
              onPressed: () {},
            ))
      ],
    )));
  }
}
