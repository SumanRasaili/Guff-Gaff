// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:guffgaff/features/select_contacts/repository/select_contact_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final getContactsProvider = FutureProvider((ref) async {
  final selectCountryRepo = ref.watch(selectContactRepositoryProvider);

  return selectCountryRepo.getContacts();
});

final selectContactProvider = Provider<SelectContactController>((ref) {
  final selRepo = ref.watch(selectContactRepositoryProvider);
  return SelectContactController(ref: ref, selectContactRepository: selRepo);
});

class SelectContactController {
  final Ref ref;
  final SelectContactRepository selectContactRepository;
  SelectContactController({
    required this.ref,
    required this.selectContactRepository,
  });

  void selectContact(
      {required BuildContext context, required Contact selectedContact}) {
    selectContactRepository.selectContact(
        context: context, selectedContact: selectedContact);
  }
}
