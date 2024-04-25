import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:guffgaff/common/widgets/error_screen.dart';
import 'package:guffgaff/features/auth/screens.dart/login_screen.dart';
import 'package:guffgaff/features/auth/screens.dart/otp_screen.dart';
import 'package:guffgaff/features/landing/landing_screen.dart';
import 'package:guffgaff/splash_screen.dart';

import '../features/auth/screens.dart/user_info.dart';

class AppRoutes {
  static final router = GoRouter(
    observers: [BotToastNavigatorObserver()],
    initialLocation: LandingScreen.routeName,
    routes: [
      SplashScreen.route(),
      LandingScreen.route(),
      LoginScreen.route(),
      OtpScreen.route(),
      UserInfoScreen.route(),
    ],
    errorBuilder: (context, state) {
      return const Scaffold(
          body: ErrorScreen(error: "Hahhaha You lost Buddy..."));
    },
  );
}
