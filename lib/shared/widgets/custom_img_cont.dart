import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomImgCont extends StatelessWidget {
  final String assetPath;
  const CustomImgCont({
    Key? key, required this.assetPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15,
        bottom: 15,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Lottie.network(assetPath, height: 150),
          // Container(
          //   height: 100,
          //   width: 100,
          //   decoration: BoxDecoration(
          //     shape: BoxShape.circle,
          //     image: DecorationImage(
          //       image: AssetImage(assetPath),
          //       fit: BoxFit.contain,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
