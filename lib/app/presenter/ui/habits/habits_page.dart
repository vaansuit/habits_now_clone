import 'package:flutter/material.dart';
import 'package:habits_now_app/core/constants.dart';

import '../../../../core/colors.dart';
import '../../../../shared/widgets/custom_img_cont.dart';
import '../../../../shared/widgets/custom_top_bar.dart';
import '../sidebar/navigation_drawer.dart';
import 'widgets/habits_list_widget.dart';

class HabitsPage extends StatefulWidget {
  final Function? callback;
  final String avatar;
  final String name;
  const HabitsPage(
      {Key? key, this.callback, required this.avatar, required this.name})
      : super(key: key);

  @override
  State<HabitsPage> createState() => _HabitsPageState();
}

class _HabitsPageState extends State<HabitsPage> with TickerProviderStateMixin {
  late TabController _colorController;

  @override
  void initState() {
    super.initState();
    _colorController = TabController(
      length: 2,
      vsync: this,
    );
    _colorController.addListener(_selectedTable);
  }

  void _selectedTable() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: const CustomTopBar(title: 'Hábitos'),
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
                    'Hábitos Ativos',
                    style: kDefaultTextStyle,
                  ),
                ),
                Tab(
                  child: Text(
                    'Arquivados',
                    style: TextStyle(
                      fontSize: 15,
                    ),
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
                    'https://assets1.lottiefiles.com/packages/lf20_touohxv0.json',
              ),
            ),
            kDefaultMaxSpace,
            const HabitsListWidget(),
          ],
        ),
      );
}
