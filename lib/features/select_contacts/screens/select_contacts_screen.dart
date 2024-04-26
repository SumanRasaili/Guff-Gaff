import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SelectContactsScreen extends ConsumerWidget {
  static const routeName = "/select-contact";
  static route() {
    return GoRoute(
      path: routeName,
      builder: (context, state) => const SelectContactsScreen(),
    );
  }

  const SelectContactsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Contact"),
      ),
    );
  }
}
