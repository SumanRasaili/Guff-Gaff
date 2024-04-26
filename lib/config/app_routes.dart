import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:guffgaff/common/widgets/error_screen.dart';
import 'package:guffgaff/features/auth/screens.dart/login_screen.dart';
import 'package:guffgaff/features/auth/screens.dart/otp_screen.dart';
import 'package:guffgaff/features/landing/landing_screen.dart';
import 'package:guffgaff/screens/screens.dart';
import 'package:guffgaff/splash_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../features/auth/screens.dart/user_info_screen.dart';

class AppRoutes {
  AppRoutes({required this.ref});
  Ref ref;
  static final router = GoRouter(
    observers: [BotToastNavigatorObserver()],
    initialLocation: SplashScreen.routeName,
    routes: [
      SplashScreen.route(),
      LandingScreen.route(),
      LoginScreen.route(),
      OtpScreen.route(),
      UserInfoScreen.route(),
      MobileLayoutScreen.route()
    ],
    // redirect: (context, state) {

    //   final bool loggedIn = FirebaseAuth.instance.currentUser != null;
    //   final bool loggingIn = state.matchedLocation == LoginPage.route;
    //   if (!loggedIn) return LoginPage.route;
    //   if (loggingIn) return MainMenuPage.route;
    //   // no need to redirect at all
    //   return null;
    //   return null;
    // },
    errorBuilder: (context, state) {
      return const Scaffold(
          body: ErrorScreen(error: "Hahhaha You lost Buddy..."));
    },
  );
}
