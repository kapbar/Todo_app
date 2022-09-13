import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/entity/todo.dart';

class TodoWidgetModel extends ChangeNotifier {
  TodoWidgetModel() {
    _setUp();
  }

  var _todo = <Todo>[];
  List<Todo> get todo => _todo.toList();

  void showForm(BuildContext context) {
    Navigator.of(context).pushNamed('/todo/form');
  }

  void showTasks(BuildContext context, int index, [bool mounted = true]) async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(TodoAdapter());
    }
    final box = await Hive.openBox<Todo>('todo_box');
    final todoKey = box.keyAt(index) as int;
    if (!mounted) return;
    Navigator.of(context).pushNamed('/todo/tasks', arguments: todoKey);
  }

  void _readTodoFormHive(Box<Todo> box) {
    _todo = box.values.toList();
    notifyListeners();
  }

  void deleteTodo(int index) async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(TodoAdapter());
    }
    final box = await Hive.openBox<Todo>('todo_box');
    await box.deleteAt(index);
  }

  void _setUp() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(TodoAdapter());
    }
    final box = await Hive.openBox<Todo>('todo_box');
    _readTodoFormHive(box);
    box.listenable().addListener(() {
      _readTodoFormHive(box);
    });
  }
}

class TodoWidgetModelProvider extends InheritedNotifier {
  final TodoWidgetModel model;
  const TodoWidgetModelProvider({
    super.key,
    required Widget child,
    required this.model,
  }) : super(
          child: child,
          notifier: model,
        );

  static TodoWidgetModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<TodoWidgetModelProvider>();
  }

  static TodoWidgetModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<TodoWidgetModelProvider>()
        ?.widget;
    return widget is TodoWidgetModelProvider ? widget : null;
  }
}
