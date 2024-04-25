import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SplashScreen extends ConsumerWidget {
  static String routeName = "/splash-screen";
  const SplashScreen({super.key});

  static GoRoute route() =>
      GoRoute(path: routeName, builder: (_, state) => const SplashScreen());
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text("Guff Gaff"),
            )
          ],
        ),
      ),
    );
  }
}
