import 'package:flutter/material.dart';
import 'package:habits_now_app/core/constants.dart';

class HeaderSideBar extends StatelessWidget {
  final String image;
  final String name;
  final String title;
  HeaderSideBar({
    Key? key,
    required this.image,
    required this.name,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kDefaultMaxSpace,
            Row(
              children: [
                Text(
                  title,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    color: kDefaultAppcolor,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                const CircleAvatar(
                  radius: 15,
                  backgroundImage: AssetImage('assets/img/logo_habits.png'),
                ),
              ],
            ),
            kDefaultMaxSpace,
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(image),
                ),
                const SizedBox(
                  width: 30,
                ),
                Text(
                  'Olá, $name',
                  style: kDefaultTitleStyle,
                ),
              ],
            ),
          ],
        ));
  }
}
