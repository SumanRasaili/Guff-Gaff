import 'package:go_router/go_router.dart';
import 'package:guffgaff/splash_screen.dart';

class AppRoutes {
  static final router = GoRouter(
      initialLocation: SplashScreen.routeName, routes: [SplashScreen.route()]);
}
