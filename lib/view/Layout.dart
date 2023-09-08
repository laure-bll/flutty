import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'Background.dart';

class Layout extends StatelessWidget {
  final Widget content;

  const Layout({required this.content, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 60,
              child: BackgroundPage(),
            ),
            Column(children: [(content)]),
          ],
        ),
      ),
    );
  }
}
