import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../constants.dart';
import '../controller/firebase_helper.dart';
import '../model/Userr.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseHelper().cloudUsers.snapshots(),
        builder: (context, snap) {
          if (snap.data == null) {
            return Column(children: [
              const SizedBox(height: 40),
              const Text(
                "Your favorites",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown),
              ),
              Lottie.asset("assets/animation_lm4phajv.json"),
              const Center(child: Text("You don't have any favorite yet !"))
            ]);
          } else {
            List people = snap.data!.docs
                .where((doc) => currentUser.favorites.contains(doc.id))
                .toList();

            return ListView.builder(
                itemCount: people.length,
                itemBuilder: (context, index) {
                  Userr user = Userr.bdd(people[index]);
                  return Card(
                    elevation: 5,
                    child: ListTile(
                        leading: CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(user.avatar!),
                        ),
                        subtitle: Text(user.email),
                        trailing: GestureDetector(
                          onTap: () => FirebaseHelper().removeFavorite(user.uid),
                          child:
                              const Icon(Icons.favorite, color: Colors.yellow),
                        ),
                        title: Text(
                            "${user.firstName} ${user.lastName.toUpperCase()}")),
                  );
                });
          }
        });
  }
}
