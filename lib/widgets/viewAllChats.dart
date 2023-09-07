import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../controller/chat_helper.dart';

class ViewAllChats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Text(
                'All Chats',
              ),
            ],
          ),
        ),
        StreamBuilder<QuerySnapshot>(
          stream: ChatHelper().cloud_rooms.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: Text("Aucun utilisateur"),
              );
            } else {
              final rooms = snapshot.data!.docs;
              print("rooms");
              print(rooms);
              return ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: rooms.length,
                  itemBuilder: (context, int index) {
                    final room = rooms[index];
                    print("room");
                    print(room);
                    return Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: Row(
                          children: [
                            // CircleAvatar(
                            //   radius: 28,
                            //   backgroundImage: AssetImage(allChat.avatar),
                            // ),
                            SizedBox(
                              width: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                // Navigator.push(context,
                                //     CupertinoPageRoute(builder: (context) {
                                //   return ChatRoom(user: allChat.sender);
                                // }));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  // Text(
                                  //   allChat.sender.name,
                                  // ),
                                  // Text(
                                  //   allChat.text,
                                  // ),
                                ],
                              ),
                            ),
                            Spacer(),
                            // Column(
                            //   crossAxisAlignment: CrossAxisAlignment.end,
                            //   children: [
                            //     allChat.unreadCount == 0
                            //         ? Icon(
                            //             Icons.done_all,
                            //           )
                            //         : CircleAvatar(
                            //             radius: 8,
                            //             backgroundColor: Colors.pink,
                            //             child: Text(
                            //               allChat.unreadCount.toString(),
                            //               style: TextStyle(
                            //                   color: Colors.white,
                            //                   fontSize: 11,
                            //                   fontWeight: FontWeight.bold),
                            //             ),
                            //           ),
                            //     SizedBox(
                            //       height: 10,
                            //     ),
                            //     // Text(
                            //     //   allChat.time,
                            //     // )
                            //   ],
                            // ),
                          ],
                        ));
                  });
            }
          },
        )
      ],
    );
  }
}