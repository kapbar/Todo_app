import 'package:hive/hive.dart';

part 'todo.g.dart';

@HiveType(typeId: 0)
class Todo extends HiveObject {
  // last used HiveField key 1, 2, 3
  @HiveField(0)
  String name;
  @HiveField(4)
  bool isDone;

  Todo({
    required this.name,
    required this.isDone,
  });
}
