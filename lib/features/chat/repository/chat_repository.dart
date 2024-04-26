// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:guffgaff/common/utils/utils.dart';
import 'package:guffgaff/models/user_models.dart';

class ChatRepository {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth auth;
  ChatRepository({
    required this.firebaseFirestore,
    required this.auth,
  });

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
// saving the data to
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}
