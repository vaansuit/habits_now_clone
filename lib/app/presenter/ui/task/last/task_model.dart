import 'dart:convert';

class TasksModel {
  int id;
  String calendar;
  String title;
  String category;
  String userEmail;
  String description;
  TasksModel({
    required this.id,
    required this.calendar,
    required this.title,
    required this.category,
    required this.userEmail,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'calendar': calendar});
    result.addAll({'title': title});
    result.addAll({'userEmail': userEmail});
    result.addAll({'category': category});
    result.addAll({'description': description});

    return result;
  }

  factory TasksModel.fromMap(Map<String, dynamic> map) {
    return TasksModel(
      id: map['id']?.toInt() ?? 0,
      calendar: map['calendar'] ?? '',
      title: map['title'] ?? '',
      userEmail: map['userEmail'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TasksModel.fromJson(String source) =>
      TasksModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TaskModel(id: $id, calendar: $calendar, title: $title, userEmail: $userEmail, category: $category, description: $description)';
  }
}
