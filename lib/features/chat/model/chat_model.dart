// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chatline_demo/common/widget/gifts.dart';

class ChatModel {
  String time;
  bool isSent;
  ChatContent content;

  /// 0 - not delivered
  /// 1 - delivered
  /// 2 - seen
  /// 3 - sent
  int status;
  ChatModel({
    required this.time,
    required this.isSent,
    required this.content,
    required this.status,
  });
}

abstract class ChatContent {}

class StickerChatContent extends ChatContent {
  Gift gift;

  StickerChatContent({
    required this.gift,
  });
}

abstract class BasicChatContent extends ChatContent {}

class TextChatContent extends BasicChatContent {
  String message;

  TextChatContent({
    required this.message,
  });
}

class ImageChatContent extends BasicChatContent {
  String image;
  ImageChatContent({
    required this.image,
  });
}

class AudioChatContent extends BasicChatContent {
  String duration;
  AudioChatContent({
    required this.duration,
  });
}

class VideoChatContent extends BasicChatContent {
  String image;
  VideoChatContent({
    required this.image,
  });
}
