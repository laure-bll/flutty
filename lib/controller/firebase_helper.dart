import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../constants.dart';
import '../model/Userr.dart';

class FirebaseHelper {
  final auth = FirebaseAuth.instance;
  final cloudUsers = FirebaseFirestore.instance.collection("USERS");
  final storage = FirebaseStorage.instance;

  signUp(
      String lastName, String firstName, String email, String password) async {
    UserCredential credential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    String uid = credential.user!.uid;
    Map<String, dynamic> data = {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "favorites": [],
    };
    addUser(uid, data);
    return getUser(uid);
  }

  signIn(String email, String password) async {
    UserCredential credential =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    return getUser(credential.user!.uid);
  }

  Future<Userr> getUser(String uid) async {
    DocumentSnapshot snapchot = await cloudUsers.doc(uid).get();
    return Userr.bdd(snapchot);
  }

  addUser(String uid, Map<String, dynamic> data) {
    cloudUsers.doc(uid).set(data);
  }

  updateUser(String uid, Map<String, dynamic> map) {
    cloudUsers.doc(uid).update(map);
  }

  Future<String> stockage(
      String dir, String uidUser, String fileName, Uint8List fileData) async {
    TaskSnapshot snapshot =
        await storage.ref("/$dir/$uidUser/$fileName").putData(fileData);
    String url = await snapshot.ref.getDownloadURL();
    return url;
  }

  addFavorite(String attachedUser) {
    cloudUsers.doc(currentUser.uid).update({
      'favorites': FieldValue.arrayUnion([attachedUser])
    });
  }

  removeFavorite(String attachedUser) {
    cloudUsers.doc(currentUser.uid).update({
      'favorites': FieldValue.arrayRemove([attachedUser])
    });
  }
}
