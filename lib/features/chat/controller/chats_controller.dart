// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:guffgaff/features/auth/controller/auth_controller.dart';
import 'package:guffgaff/features/chat/repository/chat_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final chatControllerProvider = Provider<ChatController>((ref) {
  final chatRepo = ref.watch(chatRepositoryProvider);
  return ChatController(chatrepository: chatRepo, ref: ref);
});

class ChatController {
  final ChatRepository chatrepository;
  final ProviderRef ref;
  ChatController({
    required this.chatrepository,
    required this.ref,
  });

  void senTextMessage(
      {required receiverUserId,
      required BuildContext context,
      required String text}) async {
    ref.read(userDataAuthProvider).whenData((userData) =>
        chatrepository.sendTextMessage(
            receiverUserId: receiverUserId,
            context: context,
            senderUser: userData!,
            text: text));
  }
}
