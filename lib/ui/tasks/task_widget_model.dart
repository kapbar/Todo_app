import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/entity/task.dart';
import 'package:todo_list/entity/todo.dart';

class TaskWidgetModel extends ChangeNotifier {
  int todoKey;
  late final Future<Box<Todo>> _todoBox;
  Todo? _todo;
  Todo? get todo => _todo;
  var _tasks = <Task>[];
  List<Task> get tasks => _tasks.toList();

  TaskWidgetModel({required this.todoKey}) {
    _setUp();
  }

  void showForm(BuildContext context) {
    Navigator.of(context).pushNamed('/todo/tasks/form', arguments: todoKey);
  }

  void _loadTodo() async {
    final box = await _todoBox;
    _todo = box.get(todoKey);
    notifyListeners();
  }

  void _readTask() {
    _tasks = _todo?.tasks ?? <Task>[];
    notifyListeners();
  }

  void _setupListen() async {
    final box = await _todoBox;
    _readTask();
    box.listenable(keys: [todoKey]).addListener(_readTask);
  }

  void _setUp() {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(TodoAdapter());
    }
    _todoBox = Hive.openBox<Todo>('todo_box');
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(TaskAdapter());
    }

    Hive.openBox<Task>('task_box');
    _loadTodo();
    _setupListen();
  }

  void deleteTask(int index) {
    _todo?.tasks?.deleteFromHive(index);
    _todo?.save();
  }
}

class TaskWidgetModelProvider extends InheritedNotifier {
  final TaskWidgetModel model;
  const TaskWidgetModelProvider({
    super.key,
    required Widget child,
    required this.model,
  }) : super(
          child: child,
          notifier: model,
        );

  static TaskWidgetModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<TaskWidgetModelProvider>();
  }

  static TaskWidgetModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<TaskWidgetModelProvider>()
        ?.widget;
    return widget is TaskWidgetModelProvider ? widget : null;
  }
}
