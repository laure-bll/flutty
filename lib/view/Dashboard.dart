import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/constants.dart';
import 'package:untitled/controller/firebase_helper.dart';
import 'package:untitled/view/Background.dart';
import 'package:untitled/view/ErrorPage.dart';
import 'package:untitled/view/FavoritesPage.dart';
import 'package:untitled/view/MachineLearning.dart';
import 'package:untitled/view/MapPage.dart';
import 'package:untitled/view/People.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int indexPage = 0;
  String? fileName = null;
  Uint8List? bytesFile = null;

  @override
  Widget build(BuildContext context) {
    pickPhoto() {
      showDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text("Download this file dear ?"),
              content: Image.memory(bytesFile!),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Cancel")),
                TextButton(
                    onPressed: () {
                      FirebaseHelper()
                          .stockage(
                              "images", currentUser.uid, fileName!, bytesFile!)
                          .then((value) {
                        setState(() => currentUser.avatar = value);
                        Map<String, dynamic> map = {
                          "avatar": currentUser.avatar
                        };
                        FirebaseHelper().updateUser(currentUser.uid, map);
                        Navigator.pop(context);
                      });
                    },
                    child: const Text("Upload"))
              ],
            );
          });
    }

    pickFile() async {
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(type: FileType.image, withData: true);

      if (result != null) {
        fileName = result.files.first.name;
        bytesFile = result.files.first.bytes;
        pickPhoto();
      }
    }

    return Scaffold(
      drawer: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height,
          color: Colors.yellow,
          child: Column(
            children: [
              const SizedBox(height: 50),
              GestureDetector(
                onTap: () => pickFile(),
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: NetworkImage(currentUser.avatar!),
                ),
              ),
              const SizedBox(height: 40),
              Text(
                  "Welcome ${currentUser.firstName} ${currentUser.lastName.toUpperCase()}",
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              const Text("You are connected as ",
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16)),
              const SizedBox(height: 10),
              Text(currentUser.email,
                  style: const TextStyle(
                      fontStyle: FontStyle.italic, fontSize: 16)),
              const SizedBox(height: 40),
              TextButton(
                  onPressed: () => FirebaseHelper().signout(context),
                  child: const Text("Log out")),
            ],
          )),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: indexPage,
        onTap: (index) {
          setState(() {
            indexPage = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "Map"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: "Favorites"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "People"),
          BottomNavigationBarItem(
              icon: Icon(Icons.airplane_ticket), label: "ML"),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(children: [const BackgroundPage(), bodyPage(indexPage)]),
    );
  }

  Widget bodyPage(int indexPage) {
    switch (indexPage) {
      case 0:
        return const MapPage();
      case 1:
        return const FavoritesPage();
      case 2:
        return const People();
      case 3:
        return const MachineLearning();
      default:
        return const ErrorPage();
    }
  }
}
