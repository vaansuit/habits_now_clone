import 'package:dio/dio.dart';

import 'habit_model.dart';

class HabitsRepository {
  final Dio dio;
  HabitsRepository(this.dio) {
    getAllHabits();
  }

  Future<List<HabitsModel>> getAllHabits() async {
    List<HabitsModel> habits = [];
    String email = "carlos";
    String url =
        'http://zuplae.vps-kinghost.net:8081/api/Habit/getbyemail/$email';
    final response = await dio.get(url);
    habits = List.from(
      response.data.map((task) => HabitsModel.fromMap(task)),
    );
    return habits;
  }
}
