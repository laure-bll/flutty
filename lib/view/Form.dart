import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:untitled/controller/firebase_helper.dart';

import '../constants.dart';
import 'Dashboard.dart';

SnackBar barAction(String message) {
  return SnackBar(duration: const Duration(minutes: 5), content: Text(message));
}

class FormSignup extends StatefulWidget {
  const FormSignup({super.key});

  @override
  State<FormSignup> createState() => _FormSignupState();
}

class _FormSignupState extends State<FormSignup> {
  TextEditingController lastName = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    popUpError() {
      showDialog(
          context: context,
          builder: (context) {
            if (Platform.isIOS) {
              return CupertinoAlertDialog(
                title: const Text("Error"),
                content: const Text("Wrong credentials my dear"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Got it")),
                ],
              );
            } else {
              return AlertDialog(
                title: const Text("Error"),
                content: const Text("Wrong credentials my dear"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Got it")),
                ],
              );
            }
          });
    }

    return SizedBox(
      width: 600,
      child: Column(children: [
        const Text(
          "Flutty",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.yellow,
          ),
        ),
        TextField(
          controller: firstName,
          decoration: InputDecoration(
            hintText: "First name",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        TextField(
          controller: lastName,
          decoration: InputDecoration(
            hintText: "Last name",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        TextField(
          controller: email,
          decoration: InputDecoration(
            hintText: "Email",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        TextField(
          controller: password,
          obscureText: true,
          decoration: InputDecoration(
            prefixIcon: const Icon(CupertinoIcons.eye),
            hintText: "Password",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        TextButton(
          onPressed: () {
            FirebaseHelper()
                .signUp(
                    lastName.text, firstName.text, email.text, password.text)
                .then((res) => {
                      setState(() => currentUser = res),
                      ScaffoldMessenger.of(context)
                          .showSnackBar(barAction("Welcome very dear user !")),
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const Dashboard();
                      }))
                    })
                .catchError((err) => popUpError());
          },
          child: const Text("Sign up", style: TextStyle()),
        ),
        Lottie.asset("assets/animation_flowers.json")
      ]),
    );
  }
}
