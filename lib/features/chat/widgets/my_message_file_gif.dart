// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:guffgaff/common/enum/message_enums.dart';
import 'package:guffgaff/features/chat/widgets/video_player_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MessageFileShowWidget extends ConsumerWidget {
  final String message;
  final MessageEnum type;
  const MessageFileShowWidget({
    super.key,
    required this.message,
    required this.type,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return type == MessageEnum.text
        ? Text(
            message,
            style: const TextStyle(
              fontSize: 16,
            ),
          )
        : type == MessageEnum.video
            ? VideoPlayerWidget(
                videoData: message,
              )
            : CachedNetworkImage(imageUrl: message);
  }
}
