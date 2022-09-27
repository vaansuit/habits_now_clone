import 'package:flutter/material.dart';
import 'package:habits_now_app/core/constants.dart';

class CustomSubmitButton extends StatefulWidget {
  String description;
  VoidCallback function;
  CustomSubmitButton({
    Key? key,
    required this.description,
    required this.function,
  }) : super(key: key);

  @override
  State<CustomSubmitButton> createState() => _CustomSubmitButtonState();
}

class _CustomSubmitButtonState extends State<CustomSubmitButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: 200,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: kDefaultAppcolor,
        ),
        onPressed: widget.function,
        child: Text(
          widget.description,
          style: kDefaultSplashPageButton,
        ),
      ),
    );
  }
}
