import 'dart:math';

import 'package:flutter/material.dart';

class RainAnimation extends StatefulWidget {
  final double height;
  final double width;
  const RainAnimation({super.key, required this.height, required this.width});

  @override
  State<RainAnimation> createState() => _RainAnimationState();
}

class _RainAnimationState extends State<RainAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation animation;
  late double dy, dx;
  @override
  void initState() {
    super.initState();

    dy = Random().nextDouble() * -500;
    dx = Random().nextDouble() * widget.width;
    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: Random().nextInt(3000)));
    animation = Tween<double>(begin: dy, end: widget.height)
        .animate(animationController);
    animationController.forward();
    animationController.addListener(() {
      if (animationController.isCompleted) {
        animationController.reset();
        dy = Random().nextDouble() * -500;
        dx = Random().nextDouble() * widget.width;
        animationController.duration =
            Duration(milliseconds: Random().nextInt(3000));
        animationController.forward();
      }
    });
  }
@override
  void dispose() {
    animationController.dispose();
     super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => Transform.translate(
          offset: Offset(dx, animation.value),
          child: Column(
            children: [
              Container(
                width: 2,
                height: 80,
                
                decoration:   BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(colors: [Colors.orange.shade800, Colors.white],begin: Alignment.topCenter)
                 ),
              ),
              CircleAvatar(radius: 4,backgroundColor: Colors.white,)
            ],
          )),
    );
  }
}
