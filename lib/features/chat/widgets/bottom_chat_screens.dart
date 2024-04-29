// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:guffgaff/features/chat/controller/chats_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../config/config.dart';

class BottomChatField extends HookConsumerWidget {
  final String receiverUserid;
  const BottomChatField({
    super.key,
    required this.receiverUserid,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messageController = useTextEditingController();
    final isShowSendButton = useState<bool>(false);

    void sendTextMessage() async {
      if (isShowSendButton.value) {
        ref.read(chatControllerProvider).senTextMessage(
            receiverUserId: receiverUserid,
            context: context,
            text: messageController.text.trim());
        messageController.text = "";
        messageController.clear();
        isShowSendButton.value = false;
      }
    }

    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: messageController,
            onChanged: (val) {
              if (val.isNotEmpty) {
                isShowSendButton.value = true;
              } else {
                isShowSendButton.value = false;
              }
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: mobileChatBoxColor,
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.emoji_emotions,
                            color: Colors.grey,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.gif,
                            color: Colors.grey,
                          )),
                    ],
                  ),
                ),
              ),
              suffixIcon: SizedBox(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.camera_alt,
                          color: Colors.grey,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.attach_file,
                          color: Colors.grey,
                        )),
                  ],
                ),
              ),
              hintText: 'Type a message!',
              hintStyle: const TextStyle(color: Colors.white),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              contentPadding: const EdgeInsets.all(10),
            ),
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(bottom: 8, right: 2, left: 2),
            child: CircleAvatar(
                radius: 25,
                backgroundColor: const Color(0xFF128C73),
                child: isShowSendButton.value
                    ? GestureDetector(
                        onTap: sendTextMessage,
                        child: const Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(
                        Icons.mic,
                        color: Colors.white,
                      ))),
      ],
    );
  }
}
