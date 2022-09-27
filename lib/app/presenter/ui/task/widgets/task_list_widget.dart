import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:habits_now_app/app/presenter/ui/task/last/task_repository.dart';
import 'package:habits_now_app/core/constants.dart';
import 'package:http/http.dart' as http;

import '../last/task_model.dart';

class TaskListWidget extends StatefulWidget {
  const TaskListWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<TaskListWidget> createState() => _TaskListWidgetState();
}

class _TaskListWidgetState extends State<TaskListWidget> {
  TaskRepository repository = TaskRepository(Dio());
  late Future<List<TasksModel>> tasks;

  @override
  void initState() {
    refreshTasks();
    super.initState();
  }

  void refreshTasks() {
    tasks = repository.getAllTasks();
    setState(() {});
  }

  Future<void> deleteHabit(int id) async {
    var url = Uri.parse('http://zuplae.vps-kinghost.net:8081/api/duty/$id');
    var response = await http.delete(url);
    refreshTasks();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: tasks,
      builder: (context, AsyncSnapshot<List<TasksModel>> snapshot) {
        if (snapshot.hasData) {
          return Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                refreshTasks();
              },
              child: ListView.builder(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(
                    parent: ScrollPhysics()),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  TasksModel task =
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
                          deleteHabit(task.id);
                        },
                      )
                    ],
                    child: ListTile(
                      onTap: () {
                        refreshTasks();
                      },
                      title: Row(
                        children: [
                          Text(
                            task.title,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      subtitle: Row(
                        children: [
                          Text(task.category),
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
    );
  }
}
