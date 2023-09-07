import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
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
    List favorites = currentUser.favorites;

    return Column(
      children: [
        Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10, top: 120),
              height: 400,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseHelper().cloudUsers.snapshots(),
                builder: ((context, snap) {
                  if (snap.data == null) {
                    return Container(
                      child: const Center(
                        child: Text(
                            "Ajoutez des personnes à vos favoris pour discuter avec eux."),
                      ),
                    );
                  } else {
                    List documents = snap.data!.docs;
                    return Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            ChatHelper().sendChat(
                                "hsshFfqedQWaj2laz3H9q9Ypal72", "hello");
                          },
                          child: Container(
                            alignment: Alignment.topLeft,
                            height: 100,
                            width: 80,
                            child: const CircleAvatar(
                              radius: 40,
                              backgroundColor:
                                  Color.fromARGB(255, 231, 231, 231),
                              child: Center(child: Icon(Icons.chat_sharp)),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            const SizedBox(width: 90),
                            Expanded(
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: favorites.length,
                                itemBuilder: (context, index) {
                                  if (index < favorites.length) {
                                    String favoriteUid = favorites[index];
                                    Userr? user = documents
                                        .map((doc) => Userr.bdd(doc))
                                        .firstWhere(
                                          (user) => user.uid == favoriteUid,
                                        );
                                    return Row(
                                      children: [
                                        Column(
                                          children: [
                                            CircleAvatar(
                                              radius: 40,
                                              backgroundImage:
                                                  NetworkImage(user.avatar!),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                                "${user.firstName} ${user.lastName.toUpperCase()}",
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.w400)),
                                          ],
                                        ),
                                        const SizedBox(width: 10),
                                      ],
                                    );
                                  }

                                  return const SizedBox.shrink();
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
            const Column(
              children: [
                SizedBox(height: 220),
                Divider(
                  thickness: 0.5,
                  color: Color.fromARGB(255, 143, 143, 143),
                ),
              ],
            ),
          ],
        ),
        ViewAllChats()
      ],
    );
  }
}
