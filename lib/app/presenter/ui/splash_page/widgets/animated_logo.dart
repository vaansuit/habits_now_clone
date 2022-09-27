import 'package:flutter/material.dart';

class AnimatedLogo extends StatefulWidget {
  dynamic sizeLogo;
  AnimatedLogo({
    Key? key,
    required this.sizeLogo,
  }) : super(key: key);

  @override
  State<AnimatedLogo> createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<AnimatedLogo> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'habits-logo',
      child: Image.asset(
        'assets/img/logo_habits.png',
        height: widget.sizeLogo,
      ),
    );
  }
}
