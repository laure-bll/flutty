import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/constants.dart';
import 'package:untitled/controller/firebase_helper.dart';
import 'package:untitled/model/Userr.dart';

class People extends StatefulWidget {
  const People({super.key});

  @override
  State<People> createState() => _PeopleState();
}

class _PeopleState extends State<People> {
  @override
  Widget build(BuildContext context) {
    popUp(user) {
      showDialog(
          context: context,
          builder: (context) {
            if (Platform.isIOS) {
              return CupertinoAlertDialog(
                title: const Text("Profile"),
                content: Column(
                  children: [
                    const SizedBox(height: 50),
                    GestureDetector(
                      child: CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(user.avatar!),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Text("${user.firstName} ${user.lastName.toUpperCase()}",
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text(currentUser.email,
                        style: const TextStyle(
                            fontStyle: FontStyle.italic, fontSize: 16)),
                    const SizedBox(height: 20),
                  ],
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Close")),
                ],
              );
            } else {
              return AlertDialog(
                title: const Text("Profile"),
                content: Column(
                  children: [
                    const SizedBox(height: 50),
                    GestureDetector(
                      child: CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(user.avatar!),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Text("${user.firstName} ${user.lastName.toUpperCase()}",
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text(user.email,
                        style: const TextStyle(
                            fontStyle: FontStyle.italic, fontSize: 16)),
                    const SizedBox(height: 20),
                  ],
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Close")),
                ],
              );
            }
          });
    }

    return StreamBuilder(
        stream: FirebaseHelper().cloudUsers.snapshots(),
        builder: (context, snap) {
          if (snap.data == null) {
            return const Center(
                child: Text("Sorry dear there is no one here..."));
          } else {
            List people = snap.data!.docs;

            return ListView.builder(
                itemCount: people.length,
                itemBuilder: (context, index) {
                  Userr user = Userr.bdd(people[index]);

                  bool isFavorite = currentUser.favorites.contains(user.uid);

                  if (currentUser.uid != user.uid) {
                    return GestureDetector(
                        onTap: () => popUp(user),
                        child: Card(
                          elevation: 5,
                          child: ListTile(
                              leading: CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(user.avatar!),
                              ),
                              subtitle: Text(user.email),
                              trailing: GestureDetector(
                                onTap: () => {
                                  if(isFavorite) {
                                    FirebaseHelper().removeFavorite(user.uid),
                                    setState(() => isFavorite = false)
                                  } else {
                                    FirebaseHelper().addFavorite(user.uid),
                                    setState(() => isFavorite = true)
                                  }
                                },
                                child: Icon(Icons.favorite,
                                    color: isFavorite
                                        ? Colors.yellow
                                        : Colors.brown),
                              ),
                              title: Text(
                                  "${user.firstName} ${user.lastName.toUpperCase()}")),
                        ));
                  }
                });
          }
        });
  }
}
