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

    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                color: Color.fromARGB(255, 226, 186, 255),
                padding: EdgeInsets.only(left: 10, top: 90),
                height: 200,
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
                      return Stack(
                        children: [
                          Row(
                            children: [
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
                                            (user) => user.uid == favoriteEmail,
                                          );
                                      if (user != null) {
                                        return Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                ChatHelper().sendChat(user.uid,
                                                    "she doesn't want to reply");
                                                setState(() {});
                                              },
                                              child: Column(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 40,
                                                    backgroundImage:
                                                        NetworkImage(
                                                            user.avatar!),
                                                  ),
                                                  SizedBox(height: 5),
                                                  Container(
                                                    child: Text(user.fullName,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400)),
                                                  ),
                                                ],
                                              ),
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
            ],
          ),
          Column(
            children: [
              // SizedBox(height: 20),
              Container(
                  // color: Colors.pink,
                  padding: EdgeInsets.only(
                    left: 16,
                  ),
                  alignment: Alignment.bottomLeft,
                  height: 60,
                  child: Text("Mes conversations",
                      style: TextStyle(
                          color: const Color.fromARGB(255, 61, 61, 61),
                          fontSize: 18,
                          fontWeight: FontWeight.bold))),
              ViewAllChats(),
            ],
          ),
        ],
      ),
    );
  }
}
