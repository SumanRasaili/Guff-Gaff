// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:guffgaff/common/enum/message_enums.dart';
import 'package:guffgaff/common/utils/utils.dart';
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
    final isShowEmojiContainer = useState<bool>(false);
    final focusNode = useState<FocusNode>(FocusNode());
    void sendFileMessage({required File file, required MessageEnum msgEnum}) {
      ref.read(chatControllerProvider).sendFileMessage(
            receiverUserId: receiverUserid,
            context: context,
            file: file,
            messageEnum: msgEnum,
          );
    }

    void pickImage() async {
      File? image = await pickImageFromGallery(context: context);
      if (image != null) {
        sendFileMessage(file: image, msgEnum: MessageEnum.image);
      }
    }

    void pickVideo() async {
      File? video = await pickVideoFromGallery(context: context);
      if (video != null) {
        sendFileMessage(file: video, msgEnum: MessageEnum.video);
      }
    }

//to show keyboard for emoji
    void showKeyboard() {
      focusNode.value.requestFocus();
    }

    void showEmojiContainer() {
      isShowEmojiContainer.value = true;
    }

//to remove keyboard focus for emoji
    void hideKeyboard() {
      focusNode.value.unfocus();
    }

    void hideEmojiContainer() {
      isShowEmojiContainer.value = false;
    }

//to toggle emoji keyboard and text keyboard
    void toggleEmojiContainer() {
      if (isShowEmojiContainer.value) {
        showKeyboard();
        hideEmojiContainer();
      } else {
        hideKeyboard();
        showEmojiContainer();
      }
    }

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


    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                focusNode: focusNode.value,
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
                              onPressed: toggleEmojiContainer,
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
                            onPressed: pickImage,
                            icon: const Icon(
                              Icons.camera_alt,
                              color: Colors.grey,
                            )),
                        IconButton(
                            onPressed: pickVideo,
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
        ),
        isShowEmojiContainer.value
            ? SizedBox(
                height: 310,
                child: EmojiPicker(
                  onEmojiSelected: (category, emoji) {
                    //to embed emoji and text
                    messageController.text =
                        messageController.text + emoji.emoji;
                    //to make sure that the text send icon is appear instead of audio if there is emoji only
                    if (!isShowSendButton.value) {
                      isShowSendButton.value = true;
                    }
                  },
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
