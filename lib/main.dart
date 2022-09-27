import 'package:flutter/material.dart';

import 'package:habits_now_app/app/presenter/ui/splash_page/login_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'app/presenter/ui/categories/category_model.dart';
import 'app/presenter/ui/home/home_page.dart';
import 'app/presenter/ui/sidebar/widgets/navigation_provider.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CategoryAdapter());
  var catBox = await Hive.openBox('catBox');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<NavigationProvider>(
          create: (context) => NavigationProvider(),
          child: HomePage(
            name: '',
            image: '',
          ),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        title: "Main Page",
        home: const Login(),
      ),
    ),
  );
}
