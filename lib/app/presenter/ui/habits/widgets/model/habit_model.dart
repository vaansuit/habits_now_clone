import 'dart:convert';

class HabitsModel {
  int id;
  String calendar;
  String title;
  String category;
  String description;
  HabitsModel({
    required this.id,
    required this.calendar,
    required this.title,
    required this.category,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'calendar': calendar});
    result.addAll({'title': title});
    result.addAll({'description': description});

    return result;
  }

  factory HabitsModel.fromMap(Map<String, dynamic> map) {
    return HabitsModel(
      id: map['id']?.toInt() ?? 0,
      calendar: map['calendar'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory HabitsModel.fromJson(String source) =>
      HabitsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TaskModel(id: $id, calendar: $calendar, title: $title, description: $description)';
  }
}
