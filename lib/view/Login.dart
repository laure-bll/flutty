import 'package:flutter/material.dart';
import 'package:untitled/constants.dart';
import 'package:untitled/controller/firebase_helper.dart';
import 'package:untitled/view/Dashboard.dart';
import 'package:untitled/widgets/popupError.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  _LoginState();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
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
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      const SizedBox(
        height: 30,
      ),
      Center(
          child: TextButton(
        onPressed: () {
          FirebaseHelper()
              .signIn(email.text, password.text)
              .then((res) => {
                    setState(() => currentUser = res),
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(duration:  Duration(seconds: 10), content: Text("Welcome back dear user"))),
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const Dashboard();
                    }))
                  })
              .catchError((err) => showDialog(context: context, builder: (context) => const PopupError()));
        },
        child: const Text("Sign in", style: TextStyle()),
      )),
    ]);
  }
}
