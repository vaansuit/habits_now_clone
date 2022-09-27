import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class CategoryModel {
  String name;
  int icon;
  int color;
  CategoryModel({
    required this.name,
    required this.icon,
    required this.color,
  });

  @override
  String toString() => 'CategoryModel(name: $name, icon: $icon, color: $color)';

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'icon': icon});
    result.addAll({'color': color});

    return result;
  }

  String toJson() => json.encode(toMap());
}

class CategoryAdapter extends TypeAdapter<CategoryModel> {
  @override
  final typeId = 0;

  @override
  CategoryModel read(BinaryReader reader) {
    return CategoryModel(
      name: reader.readString(),
      icon: reader.readInt(),
      color: reader.readInt(),
    );
  }

  @override
  void write(BinaryWriter writer, CategoryModel obj) {
    writer.writeString(obj.name);
    writer.writeInt(obj.icon);
    writer.writeInt(obj.color);
  }
}
