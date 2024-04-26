import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:guffgaff/common/widgets/error_screen.dart';
import 'package:guffgaff/common/widgets/loader.dart';
import 'package:guffgaff/features/select_contacts/controller/select_contact_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SelectContactsScreen extends ConsumerWidget {
  static const routeName = "/select-contact";
  static route() {
    return GoRoute(
      path: routeName,
      builder: (context, state) => const SelectContactsScreen(),
    );
  }

  const SelectContactsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Contact"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: ref.watch(getContactsProvider).when(data: (contactList) {
        return RefreshIndicator(
          onRefresh: () {
            return ref.read(getContactsProvider.future);
          },
          child: ListView.builder(
              itemCount: contactList.length,
              itemBuilder: (context, index) {
                final contact = contactList[index];

                return InkWell(
                  onTap: () {
                    ref.read(selectContactProvider).selectContact(
                        context: context, selectedContact: contact);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: ListTile(
                      leading: contact.photo == null
                          ? null
                          : CircleAvatar(
                              radius: 30,
                              backgroundImage: MemoryImage(contact.photo!)),
                      title: Text(
                        contact.displayName,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                );
              }),
        );
      }, error: (error, stackTrace) {
        return ErrorScreen(error: error.toString());
      }, loading: () {
        return const Loader();
      }),
    );
  }
}
