import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:guffgaff/config/app_colors.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OtpScreen extends StatefulHookConsumerWidget {
  final String verificationId;
  static const String routeName = "/otp-screen";
  static GoRoute route() {
    return GoRoute(
      path: routeName,
      builder: (context, state) =>
          OtpScreen(verificationId: state.extra as String),
    );
  }

  const OtpScreen({required this.verificationId, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: const Text("Verifying your number"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text(
            "We have sent an SMS with a code",
            textAlign: TextAlign.center,
          ),
          SizedBox(
            width: size.width / 5,
            child: const TextField(
              decoration: InputDecoration(hintText: "------"),
            ),
          )
        ],
      ),
    );
  }
}
