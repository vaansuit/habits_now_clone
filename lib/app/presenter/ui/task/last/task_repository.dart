import 'package:dio/dio.dart';
import 'package:habits_now_app/app/presenter/ui/task/last/task_model.dart';

class TaskRepository {
  final Dio dio;
  TaskRepository(this.dio) {
    getAllTasks();
  }

  Future<List<TasksModel>> getAllTasks() async {
    List<TasksModel> tasks = [];
    String email = "carlos";
    String url =
        'http://zuplae.vps-kinghost.net:8081/api/duty/getbyemail/$email';
    final response = await dio.get(url);
    tasks = List.from(
      response.data.map((task) => TasksModel.fromMap(task)),
    );
    return tasks;
  }
}
