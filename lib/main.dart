import 'package:flutter/material.dart';
import 'package:guffgaff/screens/screens.dart';
import 'package:guffgaff/utils/responsive_layout.dart';

import 'config/config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const ResponsiveLayout(
          mobileScreenLayout: MobileLayoutScreen(),
          webScreenLayout: WebLayoutScreen()),
      // routerConfig: AppRoutes.router,
      title: 'Guff Gaff',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
      ),
    );
  }
}
