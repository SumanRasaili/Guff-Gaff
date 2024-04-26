import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:go_router/go_router.dart';
import 'package:guffgaff/common/utils/utils.dart';
import 'package:guffgaff/models/user_models.dart';
import 'package:guffgaff/screens/screens.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final selectContactRepositoryProvider =
    Provider<SelectContactRepository>((ref) {
  return SelectContactRepository(firestore: FirebaseFirestore.instance);
});

class SelectContactRepository {
  final FirebaseFirestore firestore;
  SelectContactRepository({required this.firestore});

  Future<List<Contact>> getContacts() async {
    List<Contact> contacts = [];
    try {
      if (await FlutterContacts.requestPermission()) {
        contacts = await FlutterContacts.getContacts(withProperties: true);
      }
    } catch (e) {
      debugPrint("Error from contact ${e.toString()}");
    }
    return contacts;
  }

  void selectContact(
      {required BuildContext context, required Contact selectedContact}) async {
    var userCollection = await firestore.collection("users").get();
    bool isUserExists = false;

    for (var document in userCollection.docs) {
      var userData = UserModel.fromMap(document.data());
      String selectedPhoneNo =
          selectedContact.phones[0].number.replaceAll(" ", "");

      if (selectedPhoneNo == userData.phoneNumber) {
        isUserExists = true;
        context.push(MobileChatScreen.routeName);
      }

      if (!isUserExists) {
        showSnackBar(
            context: context, content: "This number doesnot exist on the app");
      }
    }
  }
}
