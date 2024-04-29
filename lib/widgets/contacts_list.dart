import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:guffgaff/common/widgets/loader.dart';
import 'package:guffgaff/config/config.dart';
import 'package:guffgaff/features/chat/repository/chat_repository.dart';
import 'package:guffgaff/models/chat_contact_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../screens/screens.dart';

class ContactsList extends ConsumerWidget {
  const ContactsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: StreamBuilder<List<ChatContactsModel>>(
          stream: ref.read(chatRepositoryProvider).getChatContacts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Loader();
            } else if (!snapshot.hasData) {
              return const Center(
                child: Text("No data Found"),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error Occured ${snapshot.error}"),
              );
            } else {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  final info = snapshot.data?[index];
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          context.push(MobileChatScreen.routeName,
                              extra: ChatScreenArguments(
                                  name: info?.name ?? "",
                                  userId: info?.contactId ?? ""));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: ListTile(
                            title: Text(
                              info?.name ?? "",
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 6.0),
                              child: Text(
                                info?.lastMessage ?? "",
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                info?.profilePic ?? "",
                              ),
                              radius: 30,
                            ),
                            trailing: Text(
                              DateFormat.Hm()
                                  .format(info?.sentTime ?? DateTime.now()),
                              //  info?.sentTime,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Divider(color: dividerColor, indent: 85),
                    ],
                  );
                },
              );
            }
          }),
    );
  }
}
