import 'package:flutter/material.dart';
import 'package:untitled/controller/CustomPath.dart';

class BackgroundPage extends StatefulWidget {
  const BackgroundPage({super.key});

  @override
  State<BackgroundPage> createState() => _BackgroundPageState();
}

class _BackgroundPageState extends State<BackgroundPage> {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomPath(),
      child: Container(
        color: Colors.yellow,
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }
}
