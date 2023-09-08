import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:untitled/controller/chat_helper.dart';
import 'package:untitled/controller/firebase_helper.dart';

import '../Helper.dart';
import '../constants.dart';
import '../model/Userr.dart';
import 'Layout.dart';

class ConversationPage extends StatefulWidget {
  final String receiverId;
  final String roomId;

  const ConversationPage(
      {required this.receiverId, required this.roomId, super.key});

  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController newMessage = TextEditingController();

    return Layout(
      content: FutureBuilder<List<Map<String, dynamic>>>(
        future: ChatHelper().getMessagesFromRoom(widget.roomId),
        builder: (cntxt, snapchot) {
          if (!snapchot.hasData || snapchot.data == null) {
            return Column(children: [
              const SizedBox(height: 40),
              Lottie.asset("assets/animation_lm4phajv.json"),
              const Center(child: Text("Start the chat now !"))
            ]);
          } else {
            List<Map<String, dynamic>> messages = snapchot.data!;

            return FutureBuilder<Userr>(
                future: FirebaseHelper().getUser(widget.receiverId)!,
                builder: (ctx, snap) {
                  Userr? user = snap.data;

                  if (user == null) {
                    return const Column(children: [
                      Center(
                          child:
                              Text("We don't know who are you talking to..."))
                    ]);
                  } else {
                    return SizedBox(
                        child: Column(children: [
                      Card(
                        elevation: 0,
                        child: ListTile(
                            leading: CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(user.avatar!),
                            ),
                            title: Text(
                                "${user.firstName} ${user.lastName.toUpperCase()}")),
                      ),
                      SingleChildScrollView(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.75,
                          child: ListView.builder(
                              itemCount: messages.length,
                              itemBuilder: (ct, i) {
                                String msg = messages[i]["message"];
                                Color bg =
                                    messages[i]["senderId"] == currentUser.uid
                                        ? Colors.amberAccent
                                        : Colors.orangeAccent;

                                Timestamp timestamp = messages[i]["timestamp"];
                                DateTime date = DateTime.parse(
                                    timestamp.toDate().toString());

                                return SizedBox(
                                    height: 60,
                                    child: Container(
                                        margin: messages[i]["senderId"] ==
                                                currentUser.uid
                                            ? EdgeInsets.only(left: 50)
                                            : EdgeInsets.only(right: 50),
                                        child: Card(
                                            color: bg,
                                            elevation: 5,
                                            child: Column(children: [
                                              Text(date.toString(),
                                                  style: const TextStyle(
                                                    fontStyle: FontStyle.italic,
                                                  )),
                                              Text(msg,
                                                  style: const TextStyle(
                                                      color: Colors.brown,
                                                      fontSize: 16)),
                                            ]))));
                              }),
                        ),
                      ),
                      TextField(
                        controller: newMessage,
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              if (newMessage.text != "" &&
                                  newMessage.text != null) {
                                ChatHelper().sendChat(
                                    widget.receiverId, newMessage.text);
                                setState(() {});
                              }
                            },
                            child: const Icon(Icons.send),
                          ),
                          hintText: "New message",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ]));
                  }
                });
          }
        },
      ),
    );
  }
}
