// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:guffgaff/common/repositories/common_firebase_reposorities.dart';
import 'package:guffgaff/common/utils/bot_toast.dart';
import 'package:guffgaff/features/auth/screens.dart/otp_screen.dart';
import 'package:guffgaff/features/auth/screens.dart/user_info_screen.dart';
import 'package:guffgaff/models/user_models.dart';
import 'package:guffgaff/screens/mobile_screen_layout.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
      auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance);
});

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  AuthRepository({required this.auth, required this.firestore});

  void signInWithPhone(
      {required BuildContext context, required String phoneNumber}) async {
    CustomBotToast.loading();

    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (phoneAuthCredential) async {
          BotToast.closeAllLoading();
          await auth.signInWithCredential(phoneAuthCredential);
        },
        verificationFailed: (error) {
          BotToast.closeAllLoading();
          throw Exception(error.message);
        },
        codeSent: (verificationId, forceResendingToken) async {
          BotToast.closeAllLoading();
          context.push(OtpScreen.routeName, extra: verificationId);
        },
        codeAutoRetrievalTimeout: (verificationId) {
          BotToast.closeAllLoading();
          // context.push(OtpScreen.routeName, extra: verificationId);
        },
      );
    } on FirebaseAuthException catch (e) {
      BotToast.closeAllLoading();
      CustomBotToast.text(e.message.toString(), isSuccess: false);
    }
  }

  void verifyOtp(
      {required BuildContext context,
      required String verificationId,
      required String userOtp}) async {
    try {
      CustomBotToast.loading();
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOtp);
      await auth.signInWithCredential(credential);
      BotToast.closeAllLoading();
      context.go(UserInfoScreen.routeName);
    } on FirebaseAuthException catch (e) {
      BotToast.closeAllLoading();
      CustomBotToast.text(e.message.toString(), isSuccess: false);
    }
  }

  void saveUserDataToFirestore(
      {required String name,
      required BuildContext context,
      required File? profilePic,
      required ProviderRef ref}) async {
    try {
      CustomBotToast.loading();
      String uid = auth.currentUser!.uid;
      String photoUrl =
          'https://images.unsplash.com/photo-1539571696357-5a69c17a67c6?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NHx8cmFuZG9tJTIwcGVvcGxlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=900&q=60';
      if (profilePic != null) {
        photoUrl = await ref
            .read(commonFirebaseStorageProvider)
            .storeFileToFirebase(ref: "ProfilePic/$uid", file: profilePic);
      }
      final user = UserModel(
          name: name,
          uid: uid,
          profilePic: photoUrl,
          isOnline: true,
          groupId: [],
          phoneNumber: auth.currentUser!.uid);

      await firestore
          .collection("users")
          .doc(uid)
          .set(user.toMap())
          .then((value) {
        BotToast.closeAllLoading();
        context.go(MobileLayoutScreen.routeName);
      });
    } on FirebaseAuthException catch (e) {
      BotToast.closeAllLoading();
      CustomBotToast.text(e.message.toString(), isSuccess: false);
    }
  }
}
