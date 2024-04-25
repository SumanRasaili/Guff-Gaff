import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserInfoScreen extends ConsumerWidget {
  static const String routeName = "/user-info-screen";
  static GoRoute route() {
    return GoRoute(
      path: routeName,
      builder: (context, state) => const UserInfoScreen(),
    );
  }

  const UserInfoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Info Screen"),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Stack(
            children: [
              const CircleAvatar(
                backgroundColor: Colors.grey,
                backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8cmFuZG9tJTIwcGVvcGxlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=900&q=60',
                ),
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.add))
            ],
          ),
        ],
      )),
    );
  }
}
