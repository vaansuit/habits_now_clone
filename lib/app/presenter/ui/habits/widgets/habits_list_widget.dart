import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:habits_now_app/app/presenter/ui/habits/widgets/model/habit_model.dart';
import 'package:habits_now_app/app/presenter/ui/habits/widgets/model/habit_repository.dart';
import 'package:habits_now_app/core/constants.dart';
import 'package:http/http.dart' as http;

class HabitsListWidget extends StatefulWidget {
  const HabitsListWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<HabitsListWidget> createState() => _HabitsListWidgetState();
}

class _HabitsListWidgetState extends State<HabitsListWidget> {
  HabitsRepository repository = HabitsRepository(Dio());
  late Future<List<HabitsModel>> habits;

  @override
  void initState() {
    refreshHabits();
    super.initState();
  }

  void refreshHabits() {
    habits = repository.getAllHabits();
    setState(() {});
  }

  Future<void> deleteHabit(int id) async {
    var url = Uri.parse('http://zuplae.vps-kinghost.net:8081/api/Habit/$id');
    var response = await http.delete(url);
    refreshHabits();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder(
        future: habits,
        builder: (context, AsyncSnapshot<List<HabitsModel>> snapshot) {
          if (snapshot.hasData) {
            return Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  refreshHabits();
                },
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: ScrollPhysics(),
                  ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    HabitsModel habits =
                        snapshot.data![snapshot.data!.length - (1 + index)];
                    return Slidable(
                      actionPane: const SlidableDrawerActionPane(),
                      actions: [
                        IconSlideAction(
                          icon: Icons.delete_sharp,
                          color: kDefaultAppcolor,
                          caption: 'Deletar',
                          closeOnTap: true,
                          onTap: () {
                            deleteHabit(habits.id);
                          },
                        )
                      ],
                      child: ListTile(
                        onTap: () {
                          refreshHabits();
                        },
                        title: Row(
                          children: [
                            Text(
                              habits.title,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        subtitle: Row(
                          children: [
                            Text(habits.category),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
