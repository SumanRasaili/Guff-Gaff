import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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

class ChatList extends StatefulHookConsumerWidget {
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
  ConsumerState<ChatList> createState() => _ChatListState();
}

class _ChatListState extends ConsumerState<ChatList>
    {
  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = useScrollController();
    return StreamBuilder<List<Message>>(
        stream: ref
            .read(chatControllerProvider)
            .getMessages(receiverId: widget.args.receiverUserId),
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
//this for automatically scroll the page to last if user types some messages
            SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
              scrollController
                  .jumpTo(scrollController.position.maxScrollExtent);
            });
            return ListView.builder(
              controller: scrollController,
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                final message = snapshot.data?[index];
                if (message?.senderId ==
                    FirebaseAuth.instance.currentUser?.uid) {
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
