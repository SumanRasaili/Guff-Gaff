// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:guffgaff/common/enum/message_enums.dart';

class Message {
  //to check message is send by us or not
  final String senderId;
  //to update is seen functionality
  final String receiverId;
  final String text;
  final MessageEnum messageEnumType;
  final DateTime timeSent;
  final String messageId;
  final bool isSeen;
  Message({
    required this.senderId,
    required this.receiverId,
    required this.text,
    required this.messageEnumType,
    required this.timeSent,
    required this.messageId,
    required this.isSeen,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderId': senderId,
      'receiverId': receiverId,
      'text': text,
      'messageEnumType': messageEnumType.type,
      'timeSent': timeSent.millisecondsSinceEpoch,
      'messageId': messageId,
      'isSeen': isSeen,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      senderId: map['senderId'] as String,
      receiverId: map['receiverId'] as String,
      text: map['text'] as String,
      messageEnumType: (map['messageEnumType'] as String).toEnum(),
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent'] as int),
      messageId: map['messageId'] as String,
      isSeen: map['isSeen'] as bool,
    );
  }
}
