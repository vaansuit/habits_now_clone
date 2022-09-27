import 'package:flutter/material.dart';
import 'package:habits_now_app/core/constants.dart';

import '../../../../core/colors.dart';
import '../../../../shared/widgets/custom_img_cont.dart';
import '../../../../shared/widgets/custom_top_bar.dart';
import '../sidebar/navigation_drawer.dart';
import 'widgets/task_list_widget.dart';

class TaskPage extends StatefulWidget {
  final String avatar;
  final String name;
  final Function? callback;
  const TaskPage(
      {Key? key, this.callback, required this.avatar, required this.name})
      : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> with TickerProviderStateMixin {
  late TabController _colorController;

  @override
  void initState() {
    super.initState();
    _colorController = TabController(length: 2, vsync: this);
    _colorController.addListener(_selectedTable);
  }

  void _selectedTable() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const CustomTopBar(title: 'Tarefas'),
        drawer: NavigationDrawer(
          callback: widget.callback,
          avatar: widget.avatar,
          name: widget.name,
        ),
        backgroundColor: kBackgroundColor,
        body: Column(
          children: [
            TabBar(
              controller: _colorController,
              indicatorColor: iconActiveColor,
              labelColor: Colors.white,
              tabs: const [
                Tab(
                  child: Text(
                    'Tarefas Simples',
                    style: kDefaultTextStyle,
                  ),
                ),
                Tab(
                  child: Text(
                    'Tarefas Recorrentes',
                    style: kDefaultTextStyle,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            const Center(
              child: CustomImgCont(
                assetPath:
                    'https://assets5.lottiefiles.com/packages/lf20_njhsezni.json',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const TaskListWidget(),
          ],
        ),
      );
}
