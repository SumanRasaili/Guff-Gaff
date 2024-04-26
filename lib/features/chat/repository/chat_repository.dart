// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guffgaff/common/enum/message_enums.dart';
import 'package:guffgaff/common/utils/utils.dart';
import 'package:guffgaff/models/chat_contact_model.dart';
import 'package:guffgaff/models/messages.dart';
import 'package:guffgaff/models/user_models.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  return ChatRepository(
      firebaseFirestore: FirebaseFirestore.instance,
      auth: FirebaseAuth.instance);
});

class ChatRepository {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth auth;
  ChatRepository({
    required this.firebaseFirestore,
    required this.auth,
  });

//this is for saving the data for listing to chat screen in mainpage
  _saveDataToContactsSubCollection(
      {required String lastMessage,
      required UserModel senderUserData,
      required UserModel receiverUserData,
      required DateTime timeSent,
      required String receiverUserId}) async {
//collection is like this for receiver as there are two things while in main page one and in chatscreen to send another

//--users-receiver-id--> chats-> sender-id-> messages

    var receiverChatContact = ChatContactsModel(
        name: senderUserData.name,
        profilePic: senderUserData.profilePic,
        contactId: receiverUserId,
        lastMessage: lastMessage,
        sentTime: timeSent);

    await firebaseFirestore
        .collection("users")
        .doc(receiverUserId)
        .collection("chats")
        .doc(auth.currentUser?.uid)
        .set(receiverChatContact.toMap());

//---------collection for sender

//--users--sender_id--chats--receiver-id--> messages
    var senderChatContact = ChatContactsModel(
        name: receiverUserData.name,
        profilePic: receiverUserData.profilePic,
        contactId: senderUserData.uid,
        lastMessage: lastMessage,
        sentTime: timeSent);

    await firebaseFirestore
        .collection("users")
        .doc(senderUserData.uid)
        .collection("chats")
        .doc(receiverUserId)
        .set(senderChatContact.toMap());
  }

//to save message to message sub collection
  _saveMessageToMessageSubCollection(
      {required String receiverUserId,
      required String text,
      required DateTime timeSent,
      required String messageId,
      required String senderUserName,
      required MessageEnum messageType,
      required String receiverUserName}) async {
    final message = Message(
        senderId: auth.currentUser!.uid,
        receiverId: receiverUserId,
        text: text,
        messageEnumType: messageType,
        timeSent: timeSent,
        messageId: messageId,
        isSeen: false);

//by sender
    //--> users -- receiverid-messages-messageid-senderid-messages
    await firebaseFirestore
        .collection("users")
        .doc(auth.currentUser?.uid)
        .collection("chats")
        .doc(messageId)
        .collection("messages")
        .doc(receiverUserId)
        .set(message.toMap());
    //by receiver sent message

    //--> users--senderid--messages-messageid-receiverid-messages
    await firebaseFirestore
        .collection("users")
        .doc(receiverUserId)
        .collection("chats")
        .doc(messageId)
        .collection("messages")
        .doc(auth.currentUser?.uid)
        .set(message.toMap());
  }

  void sendTextMessage(
      {required receiverUserId,
      required BuildContext context,
      required UserModel senderUser,
      required String text}) async {
    try {
      //--users--senderid--receiverid-messages- messageid -snapshot,
      var timeSent = DateTime.now();

//to store reciver userdata
      UserModel receiverUserData;
// getting receiver data from users collection
      var receiverUserDataMap =
          await firebaseFirestore.collection("users").doc(receiverUserId).get();

//mapping that receiver data to usermodal
      receiverUserData =
          UserModel.fromMap(receiverUserDataMap as Map<String, dynamic>);
      var messageId = Uuid().v1();
// saving data
      _saveDataToContactsSubCollection(
          lastMessage: text,
          senderUserData: senderUser,
          receiverUserData: receiverUserData,
          timeSent: timeSent,
          receiverUserId: receiverUserId);

      _saveMessageToMessageSubCollection(
          receiverUserId: receiverUserId,
          text: text,
          timeSent: timeSent,
          messageId: messageId,
          messageType: MessageEnum.text,
          senderUserName: senderUser.name,
          receiverUserName: receiverUserData.name);
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}
