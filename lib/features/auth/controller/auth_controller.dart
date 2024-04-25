// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:guffgaff/features/auth/repository/auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final authControllerProvider = Provider<AuthController>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(authRepository: authRepository);
});

class AuthController {
  final AuthRepository authRepository;
  AuthController({
    required this.authRepository,
  });

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
}
