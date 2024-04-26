import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:guffgaff/common/utils/utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserInfoScreen extends StatefulHookConsumerWidget {
  static const String routeName = "/user-info-screen";
  static GoRoute route() {
    return GoRoute(
      path: routeName,
      builder: (context, state) => const UserInfoScreen(),
    );
  }

  const UserInfoScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends ConsumerState<UserInfoScreen> {
  @override
  Widget build(BuildContext context) {
    final imageFile = useState<File?>(File(""));
    final size = MediaQuery.of(context).size;
    final nameController = useTextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Info Screen"),
      ),
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Stack(
              children: [
                imageFile.value == null
                    ? const CircleAvatar(
                        radius: 64,
                        // backgroundColor: Colors.grey,
                        backgroundImage: NetworkImage(
                          'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8cmFuZG9tJTIwcGVvcGxlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=900&q=60',
                        ),
                      )
                    : CircleAvatar(
                        radius: 64,
                        // backgroundColor: Colors.grey,
                        backgroundImage: FileImage(imageFile.value!)),
                Positioned(
                    left: 80,
                    bottom: -10,
                    child: IconButton(
                        onPressed: () async {
                          imageFile.value =
                              await pickImageFromGallery(context: context);
                        },
                        icon: const Icon(Icons.add)))
              ],
            ),
            Row(
              children: [
                Container(
                  width: size.width * 0.8,
                  padding: const EdgeInsets.all(20),
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                        hintText: "Please enter your name"),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.done),
                  onPressed: () {},
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
