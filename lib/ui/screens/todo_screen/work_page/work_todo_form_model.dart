import 'package:flutter/material.dart';
import 'package:todo_list/data_provider/box_manager.dart';
import 'package:todo_list/entity/todo.dart';

class WorkTodoFormModel extends ChangeNotifier {
  var _todoName = '';
  String? errorText;

  set todoName(String value) {
    if (errorText != null && value.trim().isNotEmpty) {
      errorText = null;
      notifyListeners();
    }
    _todoName = value;
  }

  void saveTodo(BuildContext context, [bool mounted = true]) async {
    final todoName = _todoName.trim();
    if (todoName.isEmpty) {
      errorText = 'Напишите название задачи';
      notifyListeners();
      return;
    }
    final box = await BoxManager.instance.openWorkBox();
    final todo = Todo(name: todoName, isDone: false);
    await box.add(todo);
    await BoxManager.instance.closeBox(box);
    if (!mounted) return;
    Navigator.of(context).pop();
  }
}

class WorkTodoFormModelProvider extends InheritedNotifier {
  final WorkTodoFormModel model;
  const WorkTodoFormModelProvider({
    super.key,
    required Widget child,
    required this.model,
  }) : super(
          child: child,
          notifier: model,
        );

  static WorkTodoFormModelProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<WorkTodoFormModelProvider>();
  }

  static WorkTodoFormModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<WorkTodoFormModelProvider>()
        ?.widget;
    return widget is WorkTodoFormModelProvider ? widget : null;
  }
}
