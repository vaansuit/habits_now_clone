import 'package:flutter/material.dart';

const Color kTitleColor = Color.fromARGB(255, 214, 32, 90);
const Color descColor = Color.fromARGB(255, 228, 228, 228);
const Color degradeColor = Color.fromARGB(255, 160, 0, 78);
const Color kIconActiveColor = Color.fromARGB(255, 205, 36, 89);
const Color kIconDisableColor = Color.fromARGB(255, 60, 60, 60);
const Color topBarColor = Color.fromARGB(255, 255, 250, 250);
const Color optionsDialogBoxColor = Color.fromARGB(255, 213, 71, 58);
const Color kBackgroundColor = Color(0xFF161616);
const Color kDefaultBlack = Color(0xFF161616);
const Color kTextFormFieldIconColor = Color(0xFFDBDBDB);
Color kTextFormFieldColor = const Color(0xFF8d99ae).withOpacity(0.2);
Color kDefaultDeleteButton = const Color(0xFF8d99ae).withOpacity(0.2);
const Color kDefaultAppcolor = Color(0xFFD72652);

class Constants {
  Constants._();
  static const double padding = 20;
  static const double avatarRadius = 40;
}

const kCategorySubtitleText = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w500,
  color: Color.fromARGB(255, 73, 73, 73),
);
const kDefaultDividerStyle = BoxDecoration(
  border: Border(
    bottom: BorderSide(
      color: Colors.white12,
      width: 1,
      style: BorderStyle.solid,
    ),
  ),
);

const kDefaultMargin = EdgeInsets.all(5);
const kDefaultMaxSpace = SizedBox(
  height: 25,
);
const kDefaultMinSpace = SizedBox(
  height: 10,
);

const kSplashPageTextButton = TextStyle(
  color: Color(0xFFD72652),
  fontFamily: 'LexendDeca',
  fontSize: 16,
);
const kDefaultTitleStyle = TextStyle(
  fontFamily: 'LexendDeca',
  fontSize: 20,
  fontWeight: FontWeight.bold,
);
const kDefaultTextStyle = TextStyle(
  fontFamily: 'LexendDeca',
  fontSize: 16,
);
const kDefaultInputText = TextStyle(
  color: Color.fromARGB(255, 219, 219, 219),
  fontSize: 18,
  fontFamily: 'LexendDeca',
);

const kDefaultFocusInputBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color: Color.fromARGB(255, 219, 219, 219),
  ),
);

const kDefaultInputSplashPageText = TextStyle(
  fontSize: 18,
  fontFamily: 'LexendDeca',
  color: Color.fromARGB(255, 82, 182, 255),
  fontWeight: FontWeight.bold,
);

const kDefaultSplashPageText = TextStyle(
  color: Color.fromARGB(255, 82, 182, 255),
  fontSize: 15.5,
  fontFamily: 'LexendDeca',
);

const kDefaultSplashPageButton = TextStyle(
  color: Colors.white,
  fontSize: 16,
  fontWeight: FontWeight.bold,
  fontFamily: 'LexendDeca',
);

const kDefaultSplashPageLabel = TextStyle(
  fontSize: 16,
  color: Color.fromARGB(255, 219, 219, 219),
);
