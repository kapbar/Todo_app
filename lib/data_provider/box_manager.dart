import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/entity/todo.dart';

class BoxManager {
  static final BoxManager instance = BoxManager._();
  final Map<String, int> _boxCounter = <String, int>{};

  BoxManager._();

  Future<Box<Todo>> openPersonalBox() async {
    return _openBox('todo_personall', 0, TodoAdapter());
  }

  Future<Box<Todo>> openWorkBox() async {
    return _openBox('todo_work', 0, TodoAdapter());
  }

  Future<Box<Todo>> openShopBox() async {
    return _openBox('todo_shop', 0, TodoAdapter());
  }

  Future<Box<Todo>> openOtherBox() async {
    return _openBox('todo_other', 0, TodoAdapter());
  }

  Future<void> closeBox<T>(Box<T> box) async {
    if (!box.isOpen) {
      _boxCounter.remove(box.name);
      return;
    }
    var count = _boxCounter[box.name] ?? 1;
    count -= 1;
    _boxCounter[box.name] = count;
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
