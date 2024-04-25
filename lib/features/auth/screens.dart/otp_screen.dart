import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
    return Scaffold();
  }
}
