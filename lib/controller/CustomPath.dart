import 'package:flutter/cupertino.dart';


class CustomPath extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.3);
    path.cubicTo(size.width * 0.3, size.height * 0.1, size.width * 0.6, size.height * 0.35, size.width * 1, size.height * 0.15);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true; // reload permanently (recommended for animations)
  }
  
}