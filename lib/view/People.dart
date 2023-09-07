import 'package:flutter/material.dart';
import 'package:untitled/constants.dart';
import 'package:untitled/controller/firebase_helper.dart';
import 'package:untitled/model/Userr.dart';

import '../widgets/viewProfile.dart';

class People extends StatefulWidget {
  const People({super.key});

  @override
  State<People> createState() => _PeopleState();
}

class _PeopleState extends State<People> {
  @override
  Widget build(BuildContext context) {
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

                  if (currentUser.email != user.email) {
                    return GestureDetector(
                        onTap: () => showDialog(builder: (context) => ViewProfile(user: user), context: context),
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
                                  if (isFavorite)
                                    {FirebaseHelper().removeFavorite(user.uid)}
                                  else
                                    {FirebaseHelper().addFavorite(user.uid)}
                                },
                                child: Icon(Icons.favorite,
                                    color: isFavorite
                                        ? Colors.yellow
                                        : Colors.brown),
                              ),
                              title: Text(
                                  "${user.firstName} ${user.lastName.toUpperCase()}")),
                        ));
                  } else {
                    return Container();
                  }
                });
          }
        });
  }
}
