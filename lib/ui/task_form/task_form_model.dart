import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:todo_list/entity/task.dart';
import 'package:todo_list/entity/todo.dart';

class TaskFormModel {
  int todoKey;
  var taskText = '';

  TaskFormModel({
    required this.todoKey,
  });

  void saveTask(BuildContext context, [bool mounted = true]) async {
    if (taskText.isEmpty) return;
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(TodoAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(TaskAdapter());
    }
    final taskBox = await Hive.openBox<Task>('task_box');
    final task = Task(text: taskText, isDone: false);
    await taskBox.add(task);

    final todoBox = await Hive.openBox<Todo>('todo_box');
    final todo = todoBox.get(todoKey);
    todo?.addTask(taskBox, task);
    if (!mounted) return;
    Navigator.of(context).pop();
  }
}

class TaskFormModelProvider extends InheritedWidget {
  final TaskFormModel model;
  const TaskFormModelProvider({
    super.key,
    required Widget child,
    required this.model,
  }) : super(child: child);

  static TaskFormModelProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TaskFormModelProvider>();
  }

  static TaskFormModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<TaskFormModelProvider>()
        ?.widget;
    return widget is TaskFormModelProvider ? widget : null;
  }

  @override
  bool updateShouldNotify(TaskFormModelProvider oldWidget) {
    return false;
  }
}