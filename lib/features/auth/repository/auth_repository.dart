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
        verificationCompleted: (phoneAuthCredential) async {
          await auth.signInWithCredential(phoneAuthCredential);
        },
        verificationFailed: (error) {
          throw Exception(error.message);
        },
        codeSent: (verificationId, forceResendingToken) async {
          context.push(OtpScreen.routeName);
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      CustomBotToast.text(e.message.toString(), isSuccess: false);
    }
  }
}
