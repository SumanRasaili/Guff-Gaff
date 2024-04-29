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

//to get chat contacts in main poage tab

  Stream<List<ChatContactsModel>> getChatContacts() {
    return firebaseFirestore
        .collection("users")
        .doc(auth.currentUser!.uid)
        .collection("chats")
        .snapshots()
        .asyncMap((event) async {
      List<ChatContactsModel> chats = [];
      for (var documents in event.docs) {
        var chatContacts = ChatContactsModel.fromMap(documents.data());

//here we are getting the userData according to userid which is associated with chatContacts
        var userData = await firebaseFirestore
            .collection("users")
            .doc(chatContacts.contactId)
            .get();

        var user = UserModel.fromMap(userData.data() as Map<String, dynamic>);
        //we cant get the name from chat contact so we neeed to get user and assign from there //
        chats.add(ChatContactsModel(
            name: user.name,
            profilePic: user.profilePic,
            contactId: chatContacts.contactId,
            lastMessage: chatContacts.lastMessage,
            sentTime: chatContacts.sentTime));
      }
      return chats;
    });
  }

  Stream<List<Message>> getMessages({required String receiverUserId}) {
    return firebaseFirestore
        .collection("users")
        .doc(auth.currentUser!.uid)
        .collection("chats")
        .doc(receiverUserId)
        .collection("messages")
        .snapshots()
        .map((event) {
      List<Message> messages = [];
      for (var document in event.docs) {
        messages.add(Message.fromMap(document.data()));
      }
      return messages;
    });
  }

//this is for saving the data for listing to chat screen in mainpage
  _saveDataToContactsSubCollection(
      {required String lastMessage,
      required UserModel senderUserData,
      required UserModel receiverUserData,
      required DateTime timeSent,
      required String receiverUserId}) async {
// we have chats in main page and another in inside message typing screen..
//1. In mainpage as we r sendiong the message and receiver will listen to message.
// 2. But if we r logged in and in main tab chats screen we also
// have to listen the message so we need to make two collection for one is for the sender
//and one for the receiver

//1. in case of receiver we make collection as like that
//--users-->receiver-id--> chats--> sender_id--> chats stored

    var receiverChatContact = ChatContactsModel(
        name: senderUserData.name,
        profilePic: senderUserData.profilePic,
        contactId: senderUserData.uid,
        lastMessage: lastMessage,
        sentTime: timeSent);

    await firebaseFirestore
        .collection("users")
        .doc(receiverUserId)
        .collection("chats")
        .doc(auth.currentUser?.uid)
        .set(receiverChatContact.toMap())
        .then((value) => print("contact data collection of receiver saved"));

//---------collection for sender

//in case of sender
//users-->sender_id--?chats--?receiver_id--> chats message

    var senderChatContact = ChatContactsModel(
        name: receiverUserData.name,
        profilePic: receiverUserData.profilePic,
        contactId: receiverUserData.uid, //it is of sending user
        lastMessage: lastMessage,
        sentTime: timeSent);

    await firebaseFirestore
        .collection("users")
        .doc(auth.currentUser?.uid)
        .collection("chats")
        .doc(receiverUserId)
        .set(senderChatContact.toMap())
        .then((value) => print("contact data collection for sender finished"));
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
    print("message to message data collection started");
    await firebaseFirestore
        .collection("users")
        .doc(auth.currentUser?.uid)
        .collection("chats")
        .doc(receiverUserId)
        .collection("messages")
        .doc(messageId)
        .set(message.toMap());

    //by receiver sent message

    //--> users--senderid--messages-messageid-receiverid-messages
    await firebaseFirestore
        .collection("users")
        .doc(receiverUserId)
        .collection("chats")
        .doc(auth.currentUser?.uid)
        .collection("messages")
        .doc(messageId)
        .set(message.toMap());
    print("message to message data collection finished");
  }

  void sendTextMessages(
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

//decoding that receiver data to usermodal
      receiverUserData =
          UserModel.fromMap(receiverUserDataMap.data() as Map<String, dynamic>);
      var messageId = const Uuid().v1();
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

      print("message to message data collection finished");
    } on FirebaseException catch (e) {
      print(e.toString());
      print(e.stackTrace);
      showSnackBar(context: context, content: e.toString());
    }
  }
}
