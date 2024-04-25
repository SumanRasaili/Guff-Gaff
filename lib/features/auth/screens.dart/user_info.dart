import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserInfoScreen extends ConsumerWidget {
  static const String routeName = "/user-info-screen";
  static GoRoute route(){
    return GoRoute(path: routeName,builder: (context, state) => const UserInfoScreen(),);
  }
  const UserInfoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Info Screen"),
      ),
    );
  }
}