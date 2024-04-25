import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:guffgaff/common/widgets/error_screen.dart';
import 'package:guffgaff/features/auth/screens.dart/login_screen.dart';
import 'package:guffgaff/features/landing/landing_screen.dart';
import 'package:guffgaff/splash_screen.dart';

class AppRoutes {
  static final router = GoRouter(
    initialLocation: LandingScreen.routeName,
    routes: [
      SplashScreen.route(),
      LandingScreen.route(),
      LoginScreen.route(),
    ],
    errorBuilder: (context, state) {
      return const Scaffold(
          body: ErrorScreen(error: "HahhahaYou lost Buddy..."));
    },
  );
}
