import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled/Helper.dart';
import 'package:untitled/constants.dart';
import 'package:untitled/controller/firebase_helper.dart';
import 'package:untitled/view/ConversationPage.dart';
import '../controller/chat_helper.dart';
import '../model/Userr.dart';

class ViewAllChats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        // color: Colors.pink,
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder<QuerySnapshot>(
          stream: ChatHelper().cloud_rooms.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: Text("Aucunne conversation"),
              );
            } else {
              List rooms = snapshot.data!.docs;

              return ListView.builder(
                  padding: EdgeInsets.all(10),
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: rooms.length,
                  itemBuilder: (context, int index) {
                    final room = rooms[index];
                    String roomId = room.id;
                    List<String> roomSplit = roomId.split("_");
                    String userId = roomSplit[1] == currentUser.uid
                        ? roomSplit[2]
                        : roomSplit[1];

                    if (isRoomMine(currentUser.uid, room.id)) {
                      return FutureBuilder(
                        future: FirebaseHelper().getUser(userId),
                        builder: (context, user_snap) {
                          if (!user_snap.hasData || user_snap.data == null) {
                            return Center(
                              child: Text("Loading messages..."),
                            );
                          } else {
                            Userr user = user_snap.data!;
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return ConversationPage(
                                          receiverId: getRoomReceiver(room.id),
                                          roomId: room.id!);
                                    }));
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                            radius: 28,
                                            backgroundImage:
                                                NetworkImage(user.avatar!)),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              user.fullName,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            ),
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  FutureBuilder(
                                                      future: ChatHelper()
                                                          .getMessagesFromRoom(
                                                              room.id),
                                                      builder: (context,
                                                          messages_snap) {
                                                        if (!messages_snap
                                                                .hasData ||
                                                            messages_snap
                                                                    .data ==
                                                                null) {
                                                          return Center(
                                                            child: Text(
                                                                "Loading messages..."),
                                                          );
                                                        } else {
                                                          List<
                                                                  Map<String,
                                                                      dynamic>>
                                                              messages =
                                                              messages_snap
                                                                  .data!;
                                                          return Text(
                                                              messages.first[
                                                                  "message"]);
                                                        }
                                                      })
                                                ]),
                                          ],
                                        ),
                                        // Add your unread count and time widgets here
                                      ],
                                    ),
                                  ),
                                ),
                                Divider(),
                              ],
                            );
                          }
                        },
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  });
            }
          },
        ),
      ),
    );
  }
}

bool isRoomMine(String uid, String roomId) {
  List<String> parts = roomId.split('_');
  bool isRoomMine = parts.any((part) => part == uid);

  return isRoomMine;
}
