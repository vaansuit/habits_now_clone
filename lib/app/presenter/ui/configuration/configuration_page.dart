import 'package:flutter/material.dart';

import '../../../../core/colors.dart';
import 'widgets/list_view_buider.dart';

class ConfigurationPage extends StatelessWidget {
  const ConfigurationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: const Text('Configurações'),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Color.fromARGB(255, 213, 32, 89),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: const ListViewBuilder(),
      backgroundColor: backgroundColor,
    );
  }
}
