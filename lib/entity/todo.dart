import 'package:hive/hive.dart';
part 'todo.g.dart';

@HiveType(typeId: 0)
class Todo extends HiveObject {
  // last used HiveField key 1
  @HiveField(0)
  String name;

  Todo({
    required this.name,
  });
}
