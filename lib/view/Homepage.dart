import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:untitled/view/Background.dart';
import 'package:untitled/view/Login.dart';
import 'package:untitled/view/Signup.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool displayLoginPage = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Stack(children: <Widget>[
                BackgroundPage(),
              ]),
              SizedBox(
                  width: 300,
                  child: Column(
                    children: [
                      const Text(
                        "Flutty",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.amber,
                        ),
                      ),
                      const SizedBox(height: 30),
                      (displayLoginPage ? const Login() : const Signup()),
                      Center(
                        child: TextButton(
                          onPressed: () => setState(
                              () => displayLoginPage = !displayLoginPage),
                          child: Text(displayLoginPage ? "Sign up" : "Sign in"),
                        ),
                      )
                    ],
                  )),
              Lottie.asset("assets/animation_flowers.json")
            ]),
      ),
    );
  }
}
