import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  final String message;
  final String receiverId;
  final String senderId;
  final Timestamp timestamp;

  Chat(
      {required this.message,
      required this.receiverId,
      required this.senderId,
      required this.timestamp});

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'message': message,
      'receivedId': receiverId,
      'timestamp': timestamp,
    };
  }
}
