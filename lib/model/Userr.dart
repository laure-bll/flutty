import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants.dart';

class Userr {
  late String lastName;
  late String firstName;
  late String email;
  late DateTime? birthday;
  late String? avatar;
  late Gender gender;
  late String uid;
  late List<dynamic> favorites;

  Userr() {
    lastName = "";
    firstName = "";
    email = "";
    favorites = [];
    gender = Gender.other;
  }

  Userr.bdd(DocumentSnapshot snapshot) {
    uid = snapshot.id;
    Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
    lastName = map["lastName"];
    firstName = map["firstName"];
    email = map["email"];
    avatar = map["avatar"] ?? defaultImage;
    Timestamp? timestamp = map["birthday"];
    favorites = map["favorites"];

    if(timestamp == null) {
      birthday = DateTime.now();
    } else
    {
      birthday = timestamp.toDate();
    }
  }

  String get fullName {
    return "$fullName $lastName";
  }
}