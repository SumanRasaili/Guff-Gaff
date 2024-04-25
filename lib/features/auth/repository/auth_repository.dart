import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:guffgaff/common/utils/bot_toast.dart';
import 'package:guffgaff/features/auth/screens.dart/otp_screen.dart';
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
}
