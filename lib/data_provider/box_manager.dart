import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/entity/task.dart';
import 'package:todo_list/entity/todo.dart';

class BoxManager {
  static final BoxManager instance = BoxManager._();
  final Map<String, int> _boxCounter = <String, int>{};

  BoxManager._();

  Future<Box<Todo>> openTodoBox() async {
    return _openBox('todo_box', 0, TodoAdapter());
  }

  Future<Box<Task>> openTaskBox(int todoKey) async {
    return _openBox(makeTaskBoxName(todoKey), 1, TaskAdapter());
  }

  String makeTaskBoxName(int todoKey) => 'task_box_$todoKey';

  Future<void> closeBox<T>(Box<T> box) async {
    if (!box.isOpen) {
      _boxCounter.remove(box.name);
      return;
    }
    final count = _boxCounter[box.name] ?? 1;
    _boxCounter[box.name] = count - 1;
    if (count > 0) return;

    _boxCounter.remove(box.name);
    await box.compact();
    await box.close();
  }

  Future<Box<T>> _openBox<T>(
    String name,
    int typeId,
    TypeAdapter<T> adapter,
  ) async {
    if (Hive.isBoxOpen(name)) {
      final count = _boxCounter[name] ?? 1;
      _boxCounter[name] = count + 1;
      return Hive.box(name);
    }
    _boxCounter[name] = 1;
    if (!Hive.isAdapterRegistered(typeId)) {
      Hive.registerAdapter(adapter);
    }
    return Hive.openBox<T>(name);
  }
}
