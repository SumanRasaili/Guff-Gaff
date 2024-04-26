// ignore_for_file: public_member_api_docs, sort_constructors_first

class ChatContactsModel {
  final String name;
  final String profilePic;
  final String contactId;
  final String lastMessage;
  final DateTime sentTime;
  ChatContactsModel({
    required this.name,
    required this.profilePic,
    required this.contactId,
    required this.lastMessage,
    required this.sentTime,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'profilePic': profilePic,
      'contactId': contactId,
      'lastMessage': lastMessage,
      'sentTime': sentTime.millisecondsSinceEpoch,
    };
  }

  factory ChatContactsModel.fromMap(Map<String, dynamic> map) {
    return ChatContactsModel(
      name: map['name'] as String,
      profilePic: map['profilePic'] as String,
      contactId: map['contactId'] as String,
      lastMessage: map['lastMessage'] as String,
      sentTime: DateTime.fromMillisecondsSinceEpoch(map['sentTime'] as int),
    );
  }
}
