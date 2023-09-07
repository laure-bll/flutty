import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PopupError extends StatelessWidget {
  const PopupError({super.key});

  @override
  Widget build(BuildContext context) {
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
  }
}
