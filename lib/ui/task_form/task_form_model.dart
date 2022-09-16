import 'package:flutter/material.dart';
import 'package:todo_list/data_provider/box_manager.dart';
import 'package:todo_list/entity/task.dart';

class TaskFormModel {
  int todoKey;
  var taskText = '';

  TaskFormModel({
    required this.todoKey,
  });

  void saveTask(BuildContext context, [bool mounted = true]) async {
    if (taskText.isEmpty) return;
    final task = Task(text: taskText, isDone: false);
    final box = await BoxManager.instance.openTaskBox(todoKey);
    await box.add(task);
    await BoxManager.instance.closeBox(box);
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
