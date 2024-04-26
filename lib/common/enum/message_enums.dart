enum MessageEnum {
  text(type: "text"),
  image(type: "image"),
  audio(type: "audio"),
  video(type: "video"),
  gif(type: "gif");

  const MessageEnum({required this.type});
  final String type;
}

//we need to make sure that enum type returns a String

//1.using extension
//2.enhanced enum

//using extension//
extension ConvertMessage on String {
  MessageEnum toEnum() {
    switch (this) {
      case "audio":
        return MessageEnum.audio;
      case "text":
        return MessageEnum.text;
      case "gif":
        return MessageEnum.gif;
      case "image":
        return MessageEnum.image;
      case "video":
        return MessageEnum.video;
      default:
        return MessageEnum.text;
    }
  }
}
