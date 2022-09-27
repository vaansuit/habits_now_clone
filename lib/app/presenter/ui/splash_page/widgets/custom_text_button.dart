import 'package:flutter/material.dart';
import 'package:habits_now_app/core/constants.dart';

class CustomTextButton extends StatelessWidget {
  String description;
  VoidCallback route;
  CustomTextButton({
    Key? key,
    required this.description,
    required this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: route,
      child: Text(
        description,
        style: kSplashPageTextButton,
      ),
    );
  }
}
