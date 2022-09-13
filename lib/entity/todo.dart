import 'package:hive/hive.dart';

part 'todo.g.dart';

@HiveType(typeId: 0)
class Todo {
  @HiveField(0)
  String name;

  @HiveField(1)
  HiveList? tasks;

  Todo({
    required this.name,
  });
}
