import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled/constants.dart';

import '../model/Userr.dart';
import 'firebase_helper.dart';

class ChatHelper extends ChangeNotifier {
  final cloud_rooms = FirebaseFirestore.instance.collection("ROOMS");

//pour envoyer un message et update la bdd
  Future<void> sendChat(
      String receiverId,
      String message,
      ) async {
    final String roomId = getRoomId(receiverId);
    final Timestamp timestamp = Timestamp.now();
    Userr receiverUser = await FirebaseHelper().getUser(receiverId);
    String receiverName = receiverUser.fullName;
    String? receiverAvatar = receiverUser.avatar;
    Map<String, dynamic> chat = {
      "senderId": currentUser.uid,
      "receiverId": receiverId,
      "receiverName": receiverName,
      "timestamp": timestamp,
      "message": message,
      "avatar": receiverAvatar,
    };

    final roomDoc = cloud_rooms.doc(roomId);

    //verifie si la room existe ou non
    bool doesRoomExist = await doesRoomIdExist(roomId);


    //si elle existe on ajoutera directement à la collection de la roomId
    if (doesRoomExist) {
      await roomDoc.collection("MESSAGES").add(chat);
    }
    // sinon on va créer une nouvelle room
    else {
      await roomDoc.set({});
      await roomDoc.collection("MESSAGES").add(chat);
    }
  }

  //verifie sur la room existe ou non
  Future<bool> doesRoomIdExist(String roomId) async {
    try {
      final QuerySnapshot roomSnap = await cloud_rooms.get();
      final List<String> roomIds = roomSnap.docs.map((doc) => doc.id).toList();
      print("the list of roomIds");
      print(roomIds);
      print("true or not");
      print(roomIds.contains(roomId));
      return roomIds.contains(roomId);
    } catch (e) {
      print("Erreur pour récup les roomIds $e");
      return false;
    }
  }

  Future<List<String>> getAllRoomIds() async {
    try {
      final QuerySnapshot roomSnap = await cloud_rooms.get();
      final List<String> roomIds = roomSnap.docs.map((doc) => doc.id).toList();
      return roomIds;
    } catch (e) {
      print("Error fetching room IDs: $e");
      return [];
    }
  }

  //donne un id à la room
  String getRoomId(String receiverId) {
    List<String> userId = [currentUser.uid, receiverId];
    userId.sort();

    return 'room_${userId[0]}_${userId[1]}';
  }

  Future<List<Map<String, dynamic>>> getMessagesFromRoom(String roomId) async {
    try {
      final messagesQuery = await FirebaseFirestore.instance
          .collection("ROOMS")
          .doc(roomId)
          .collection("MESSAGES")
          .get();

      return messagesQuery.docs
          .map((messageDoc) => messageDoc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print("Error fetching messages for room $roomId: $e");
      return [];
    }
  }
}