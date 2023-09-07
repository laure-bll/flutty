import 'dart:async';

import 'package:flutter/material.dart';

class AnimationWidget extends StatefulWidget {
  const AnimationWidget({required this.child, required this.duration, super.key});
  @override
  State<AnimationWidget> createState() => _AnimationWidgetState();

  final Widget child;
  final int duration;
}

class _AnimationWidgetState extends State<AnimationWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> animationOffset;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(microseconds: 2500)
    );

    CurvedAnimation animationCurved = CurvedAnimation(parent: _controller, curve: Curves.bounceInOut);

    animationOffset = Tween<Offset>(
      begin: const Offset(0, 5),
      end: Offset.zero,
    ).animate(animationCurved);

    Timer(Duration(seconds: widget.duration), () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: animationOffset,
      child: FadeTransition(
          opacity: _controller,
          child: widget.child,
      )
    );
  }
}
