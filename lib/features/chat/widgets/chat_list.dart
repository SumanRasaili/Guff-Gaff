import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:guffgaff/common/widgets/loader.dart';
import 'package:guffgaff/features/chat/controller/chats_controller.dart';
import 'package:guffgaff/info.dart';
import 'package:guffgaff/models/messages.dart';
import 'package:guffgaff/widgets/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ChatArgs {
  final String receiverUserId;
  ChatArgs({required this.receiverUserId});
}

class ChatList extends ConsumerWidget {
  final ChatArgs args;
  static const String routeName = "/chat-list-page";
  static GoRoute route() {
    return GoRoute(
      path: routeName,
      builder: (context, state) => ChatList(
        args: state.extra as ChatArgs,
      ),
    );
  }

  const ChatList({required this.args, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder<List<Message>>(
        stream: ref
            .read(chatControllerProvider)
            .getMessages(receiverId: args.receiverUserId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          } else if (!snapshot.hasData) {
            return const Center(
              child: Text("No data Found"),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error Occured ${snapshot.error}"),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                final message = snapshot.data?[index];
                if (messages[index]['isMe'] == true) {
                  return MyMessageCard(
                    message: message?.text ?? "",
                    date: messages[index]['time'].toString(),
                  );
                }
                return SenderMessageCard(
                  message: message?.text ?? "",
                  date: messages[index]['time'].toString(),
                );
              },
            );
          }
        });
  }
}
