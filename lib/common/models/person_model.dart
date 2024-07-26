// ignore_for_file: public_member_api_docs, sort_constructors_first
class PersonModel {
  String image;
  String name;
  bool isVerified;
  bool isRequest;
  bool isTyping;
  String time;
  String status;
  String latestMessage;
  int newCount;
  bool isSent;
  bool onHold;
  bool isActive;

  PersonModel({
    required this.image,
    required this.name,
    required this.isVerified,
    required this.isRequest,
    required this.isTyping,
    required this.time,
    required this.status,
    required this.latestMessage,
    required this.newCount,
    required this.isSent,
    required this.onHold,
    required this.isActive,
  });
}
