import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:guffgaff/firebase_options.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'config/config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRoutes.router,
      builder: BotToastInit(),
      // home: const LandingScreen(),
      // home: const ResponsiveLayout(
      //     mobileScreenLayout: MobileLayoutScreen(),
      //     webScreenLayout: WebLayoutScreen()),
      // routerConfig: AppRoutes.router,
      title: 'Guff Gaff',
      debugShowCheckedModeBanner: false,

      theme: ThemeData.dark().copyWith(
        appBarTheme: const AppBarTheme(color: appBarColor),
        scaffoldBackgroundColor: backgroundColor,
      ),
    );
  }
}
