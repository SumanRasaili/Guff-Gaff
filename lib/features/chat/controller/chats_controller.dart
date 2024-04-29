// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:guffgaff/common/enum/message_enums.dart';
import 'package:guffgaff/features/chat/controller/user_data_provider.dart';
import 'package:guffgaff/features/chat/repository/chat_repository.dart';
import 'package:guffgaff/models/chat_contact_model.dart';
import 'package:guffgaff/models/messages.dart';
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
      required String text}) {
    print("hello in controller");
    final userData = ref.read(userDataProvider);
    print("User id is ${userData?.uid}");

    chatrepository.sendTextMessages(
        receiverUserId: receiverUserId,
        context: context,
        senderUser: userData!,
        text: text);
  }

  void sendFileMessage(
      {required receiverUserId,
      required BuildContext context,
      required File file,
      required MessageEnum messageEnum,
      required String text}) {
    print("hello in controller");
    final userData = ref.read(userDataProvider);
    print("User id is ${userData?.uid}");

    chatrepository.sendFile(
        context: context,
        file: file,
        receiverUserId: receiverUserId,
        messageEnum: messageEnum,
        ref: ref,
        senderUserData: userData!);
  }

  Stream<List<ChatContactsModel>> getChatContacts() {
    return chatrepository.getChatContacts();
  }

  Stream<List<Message>> getMessages({required String receiverId}) {
    return chatrepository.getMessages(receiverUserId: receiverId);
  }
}
