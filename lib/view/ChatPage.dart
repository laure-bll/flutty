import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled/constants.dart';

import '../controller/chat_helper.dart';
import '../controller/firebase_helper.dart';
import '../model/Userr.dart';
import '../widgets/viewAllChats.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    List<dynamic> favorites = currentUser.favorites;

    return Column(
      children: [
        Stack(
          children: [
            Column(
              children: [
                SizedBox(height: 120),
                Stack(
                  children: [
                    ViewAllChats(),
                    Container(
                      // color: Colors.pink,
                        padding: EdgeInsets.only(
                          left: 16,
                        ),
                        alignment: Alignment.bottomLeft,
                        width: 300,
                        height: 145,
                        child: Text("Mes rooms",
                            style: TextStyle(
                                color: const Color.fromARGB(255, 61, 61, 61),
                                fontSize: 18,
                                fontWeight: FontWeight.bold))),
                  ],
                ),
              ],
            ),
            Container(
              color: Color.fromARGB(255, 226, 186, 255),
              padding: EdgeInsets.only(left: 10, top: 120),
              height: 230,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseHelper().cloudUsers.snapshots(),
                builder: ((context, snap) {
                  if (snap.data == null) {
                    return Container(
                      child: Center(
                        child: Text(
                            "Ajoutez des personnes à vos favoris pour discuter avec eux."),
                      ),
                    );
                  } else {
                    List documents = snap.data!.docs;
                    String recentMessage;
                    return Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            print("clicked");
                            ChatHelper().sendChat(
                                "hsshFfqedQWaj2laz3H9q9Ypal72",
                                "she doesn't want to reply");
                            setState(() {});
                          },
                        ),
                        Row(
                          children: [
                            SizedBox(width: 30),
                            Expanded(
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: favorites.length,
                                itemBuilder: (context, index) {
                                  if (index < favorites.length) {
                                    String favoriteEmail = favorites[index];
                                    Userr? user = documents
                                        .map((doc) => Userr.bdd(doc))
                                        .firstWhere(
                                          (user) => user.email == favoriteEmail,
                                    );
                                    bool isFavorite =
                                    favorites.contains(user?.email);
                                    if (user != null) {
                                      return Row(
                                        children: [
                                          Column(
                                            children: [
                                              CircleAvatar(
                                                radius: 40,
                                                backgroundImage:
                                                NetworkImage(user.avatar!),
                                              ),
                                              SizedBox(height: 5),
                                              Container(
                                                child: Text(user.fullName,
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.w400)),
                                              ),
                                            ],
                                          ),
                                          SizedBox(width: 10),
                                        ],
                                      );
                                    }
                                  }

                                  return SizedBox.shrink();
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }
                }),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.height * 0.45,

              alignment: Alignment.centerRight,
              height: 190,
              child: Icon(Icons.chat_sharp,
                  size: 30, color: Color.fromARGB(255, 40, 8, 48)),
              // child: CircleAvatar(
              //   radius: 40,
              //   backgroundColor: Color.fromARGB(255, 255, 255, 255),
              //   child: Center(child: Icon(Icons.chat_sharp)),
              // ),
            ),
            Column(
              children: [
                SizedBox(height: 220),
                Divider(
                  thickness: 0.5,
                  color: Color.fromARGB(255, 197, 113, 230),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}