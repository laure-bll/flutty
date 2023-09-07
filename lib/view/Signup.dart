import 'package:flutter/material.dart';
import 'package:untitled/constants.dart';
import 'package:untitled/controller/firebase_helper.dart';
import 'package:untitled/view/Dashboard.dart';
import 'package:untitled/widgets/popupError.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  _SignupState();

  TextEditingController lastName = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                  .signUp(
                      lastName.text, firstName.text, email.text, password.text)
                  .then((res) => {
                        setState(() => currentUser = res),
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            duration: Duration(seconds: 10),
                            content: Text(
                                "Yeah, you've just joined the Flutty team !"))),
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const Dashboard();
                        }))
                      })
                  .catchError((err) => showDialog(
                      context: context,
                      builder: (context) => const PopupError()));
            },
            child: const Text("Sign up", style: TextStyle()),
          ),
        ),
      ],
    );
  }
}
