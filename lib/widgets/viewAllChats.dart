import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/constants.dart';
import '../controller/chat_helper.dart';

class ViewAllChats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        // color: Colors.pink,
        height: 350,
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder<QuerySnapshot>(
          stream: ChatHelper().cloud_rooms.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: Text("Aucun chats"),
              );
            } else {
              List rooms = snapshot.data!.docs;

              return Row(
                children: [
                  SizedBox(width: 10),
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: rooms.length,
                        itemBuilder: (context, int index) {
                          final room = rooms[index];

                          if (isRoomMine(currentUser.uid, room.id)) {
                            return FutureBuilder<List<Map<String, dynamic>>>(
                              future: ChatHelper().getMessagesFromRoom(room.id),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData ||
                                    snapshot.data == null) {
                                  return Center(
                                    child: Text("Loading messages..."),
                                  );
                                } else {
                                  List<Map<String, dynamic>> messages =
                                  snapshot.data!;

                                  print(messages.first);
                                  return Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(top: 20),
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                                radius: 28,
                                                backgroundImage: NetworkImage(
                                                    messages[0]["avatar"])),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            GestureDetector(
                                              onTap: () {},
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Text(
                                                    messages[0]["receiverName"],
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        fontSize: 15),
                                                  ),
                                                  Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Text(messages
                                                            .first["message"]),
                                                      ]),
                                                ],
                                              ),
                                            ),
                                            Spacer(),
                                            // Add your unread count and time widgets here
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        thickness: 0.5,
                                        color:
                                        Color.fromARGB(255, 214, 214, 214),
                                      ),
                                    ],
                                  );
                                }
                              },
                            );
                          } else {
                            return SizedBox.shrink();
                          }
                        }),
                  ),
                ],
              );
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