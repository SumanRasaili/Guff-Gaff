import 'package:flutter_contacts/contact.dart';
import 'package:guffgaff/features/select_contacts/repository/select_contact_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final selectContactControllerProvider =
    FutureProvider<List<Contact>>((ref) async {
  final selectCountryRepo = ref.watch(selectContactRepositoryProvider);

  return selectCountryRepo.getContacts();
});
