import 'package:flutter/material.dart';
import 'package:untitled/constants.dart';
import 'package:untitled/controller/firebase_helper.dart';
import 'package:untitled/model/Userr.dart';

class ViewProfile extends StatelessWidget {
  final Userr user;
  const ViewProfile({super.key, required this.user});

  @override
  Widget build(
    BuildContext context,
  ) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    List favorites = currentUser.favorites;

    bool isFavorite = favorites.contains(user.email);
    return Stack(
      children: <Widget>[
        Container(
          height: 300,
          width: 250,
          padding:
              const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
          margin: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Color.fromARGB(255, 73, 73, 73),
                    offset: Offset(0, 3),
                    blurRadius: 50),
              ]),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 65.0,
                  top: 20,
                  bottom: 20,
                ),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(user.avatar!),
                ),
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SizedBox(height: 95),
                    Text(
                      user.firstName,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      user.email,
                      style: const TextStyle(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    (isFavorite)
                        ? Align(
                            alignment: Alignment.center,
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: GestureDetector(
                                  onTap: () {
                                    if (isFavorite) {
                                      FirebaseHelper().removeFavorite(user.uid);
                                    } else {
                                      FirebaseHelper().addFavorite(user.uid);
                                    }
                                    Navigator.pop(context);
                                  },
                                  child: const Icon(Icons.heart_broken,
                                      color:
                                          Color.fromARGB(255, 255, 158, 191)),
                                )),
                          )
                        : Align(
                            alignment: Alignment.center,
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: GestureDetector(
                                  onTap: () {
                                    if (isFavorite) {
                                      FirebaseHelper().removeFavorite(user.uid);
                                    } else {
                                      FirebaseHelper().addFavorite(user.uid);
                                    }
                                    Navigator.pop(context);
                                  },
                                  child: const Icon(Icons.favorite,
                                      color:
                                          Color.fromARGB(255, 255, 158, 191)),
                                )),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
