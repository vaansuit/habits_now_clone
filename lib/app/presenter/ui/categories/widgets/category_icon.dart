import 'package:flutter/material.dart';

class CategoryIcon extends StatelessWidget {
  CategoryIcon({
    required this.name,
    required this.entries,
    required this.icon,
    required this.color,
    Key? key,
  }) : super(key: key);
  String name;
  int entries;
  IconData icon;
  Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      child: Column(
        children: [
          Column(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 49, 49, 49),
                  borderRadius: BorderRadiusDirectional.circular(16),
                ),
                child: Icon(
                  icon,
                  size: 50,
                  color: color,
                ),
              ),

              //   Container(
              //     decoration: BoxDecoration(
              //       image: DecorationImage(
              //         colorFilter: ColorFilter.matrix([
              //           255,
              //           red.toDouble(),
              //           green.toDouble(),
              //           blue.toDouble()
              //         ]),
              //         image: AssetImage("assets/img/alarm_on.png"),
              //       ),
              //     ),
              //   ),
              // ),
              Text(
                name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
              Text(
                '$entries entradas',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 11,
                  color: Color.fromARGB(255, 128, 128, 128),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
