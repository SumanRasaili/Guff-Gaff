// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:guffgaff/common/widgets/loader.dart';
import 'package:guffgaff/features/auth/controller/auth_controller.dart';
import 'package:guffgaff/features/chat/widgets/bottom_chat_screens.dart';
import 'package:guffgaff/models/user_models.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../config/app_colors.dart';
import '../widgets/chat_list.dart';

class ChatScreenArguments {
  final String name;
  final String userId;
  ChatScreenArguments({
    required this.name,
    required this.userId,
  });
}

class MobileChatScreen extends StatefulHookConsumerWidget {
  final ChatScreenArguments args;
  static const String routeName = "/mobile-chat-screen";
  static route() {
    return GoRoute(
      path: routeName,
      builder: (context, state) => MobileChatScreen(
        args: state.extra as ChatScreenArguments,
      ),
    );
  }

  const MobileChatScreen({required this.args, super.key});

  @override
  ConsumerState<MobileChatScreen> createState() => _MobileChatScreenState();
}

class _MobileChatScreenState extends ConsumerState<MobileChatScreen>{
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: StreamBuilder<UserModel>(
            stream: ref
                .read(authControllerProvider)
                .getUserDataById(userId: widget.args.userId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Loader();
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.args.name,
                  ),
                  Text(
                    snapshot.data!.isOnline ? "Online" : "Offline",
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.normal),
                  ),
                ],
              );
            }),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.video_call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child:
                  ChatList(args: ChatArgs(receiverUserId: widget.args.userId))),
          BottomChatField(
            receiverUserid: widget.args.userId,
          ),
        ],
      ),
    );
  }
}
