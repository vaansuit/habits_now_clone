// import 'dart:async';

// import 'package:flutter/material.dart';

// import '../../app/presenter/ui/home/home_page.dart';

// class SplashPage extends StatefulWidget {
//   const SplashPage({Key? key}) : super(key: key);
//   @override
//   State<SplashPage> createState() => _SplashPageState();
// }

// class _SplashPageState extends State<SplashPage> {
//   bool isStarted = false;

//   @override
//   void initState() {
//     isStarted = false;
//     super.initState();

//     Timer(
//       const Duration(seconds: 3),
//       () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => const HomePage(),
//           ),
//         );
//       },
//     );
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       changeStarted();
//     });
//   }

//   void changeStarted() async {
//     setState(() {
//       isStarted = !isStarted;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 22, 22, 22),
//       body: Center(
//         child: Stack(
//           children: [
//             Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: const <Widget>[
//                   Text(
//                     'HabitsNow',
//                     style: TextStyle(
//                       fontSize: 40.0,
//                       fontWeight: FontWeight.bold,
//                       color: Color.fromARGB(255, 214, 32, 90),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20.0,
//                   ),
//                   CircularProgressIndicator(
//                     valueColor: AlwaysStoppedAnimation(
//                       Color.fromARGB(255, 214, 32, 90),
//                     ),
//                     strokeWidth: 11.0,
//                   ),
//                 ],
//               ),
//             ),
//             AnimatedContainer(
//               color: isStarted
//                   ? Colors.transparent
//                   : const Color.fromARGB(255, 22, 22, 22),
//               duration: const Duration(milliseconds: 750),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
