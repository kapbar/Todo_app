import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/data_provider/box_manager.dart';
import 'package:todo_list/entity/task.dart';
import 'package:todo_list/ui/navigation/main_navigation.dart';
import 'package:todo_list/ui/tasks/task_widget.dart';

class TaskWidgetModel extends ChangeNotifier {
  TaskWidgetConfiguration configuration;
  ValueListenable<Object>? _listenable;
  late final Future<Box<Task>> _box;
  var _tasks = <Task>[];
  List<Task> get tasks => _tasks.toList();

  TaskWidgetModel({required this.configuration}) {
    _setUp();
  }

  void showForm(BuildContext context) {
    Navigator.of(context).pushNamed(MainNavigationRouteNames.tasksForm,
        arguments: configuration.todoKey);
  }

  Future<void> _readTaskFormHive() async {
    _tasks = (await _box).values.toList();
    notifyListeners();
  }

  Future<void> _setUp() async {
    _box = BoxManager.instance.openTaskBox(configuration.todoKey);
    await _readTaskFormHive();
    _listenable = (await _box).listenable();
    _listenable?.addListener(_readTaskFormHive);
  }

  Future<void> deleteTask(int index) async {
    await (await _box).deleteAt(index);
  }

  Future<void> doneToggle(int index) async {
    final task = (await _box).getAt(index);
    task?.isDone = !task.isDone;
    await task?.save();
  }

  @override
  Future<void> dispose() async {
    _listenable?.removeListener(_readTaskFormHive);
    await BoxManager.instance.closeBox(await _box);
    super.dispose();
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
