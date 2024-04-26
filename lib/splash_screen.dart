import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:guffgaff/config/app_colors.dart';
import 'package:guffgaff/features/chat/controller/user_data_provider.dart';
import 'package:guffgaff/features/landing/landing_screen.dart';
import 'package:guffgaff/screens/mobile_screen_layout.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SplashScreen extends StatefulHookConsumerWidget {
  static String routeName = "/splash-screen";
  const SplashScreen({super.key});

  static GoRoute route() =>
      GoRoute(path: routeName, builder: (_, state) => const SplashScreen());
  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();

    ref.read(userDataProvider.notifier).getUserData().then((value) {
      if (value == null) {
        context.go(LandingScreen.routeName);
      } else {
        context.go(MobileLayoutScreen.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                "assets/images/bg.png",
                color: tabColor,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
              "Welcome to Guff Gaff Guyss ",
              style: TextStyle(fontSize: 25),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
