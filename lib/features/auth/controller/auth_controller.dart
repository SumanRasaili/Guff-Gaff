// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guffgaff/features/auth/repository/auth_repository.dart';
import 'package:guffgaff/models/user_models.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final authControllerProvider = Provider<AuthController>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(ref: ref, authRepository: authRepository);
});

final userDataAuthProvider = FutureProvider<UserModel?>((ref) async {
  final authController = ref.watch(authControllerProvider);
  return authController.getUserData();
});

class AuthController {
  final AuthRepository authRepository;
  AuthController({required this.authRepository, required this.ref});
  final ProviderRef ref;

  Future<UserModel?> getUserData() async {
    UserModel? user = await authRepository.getCurrentUserData();
    return user;
  }

  void signInWithPhone(
      {required BuildContext context, required String phoneNumber}) {
    authRepository.signInWithPhone(context: context, phoneNumber: phoneNumber);
  }

  void verifyOtp(
      {required BuildContext context,
      required String otp,
      required String verificationId}) {
    authRepository.verifyOtp(
        context: context, userOtp: otp, verificationId: verificationId);
  }

  void saveUserDataToFirestore(
      {required BuildContext context,
      required String name,
      required File? profilePic}) {
    authRepository.saveUserDataToFirestore(
        name: name, context: context, profilePic: profilePic, ref: ref);
  }

  Stream<UserModel> getUserDataById({required String userId}) {
    return authRepository.getUserData(userId: userId);
  }

  setUserOnlineStatus({required bool isOnline}) async {
    authRepository.setUserOnlineStatus(isOnline: isOnline);
  }
}
