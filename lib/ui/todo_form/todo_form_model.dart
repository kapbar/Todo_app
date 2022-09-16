import 'package:flutter/material.dart';
import 'package:todo_list/data_provider/box_manager.dart';
import 'package:todo_list/entity/todo.dart';

class TodoFormModel extends ChangeNotifier {
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
      errorText = 'Name Todo is not a null';
      notifyListeners();
      return;
    }
    final box = await BoxManager.instance.openTodoBox();
    final todo = Todo(name: todoName);
    await box.add(todo);
    await BoxManager.instance.closeBox(box);
    if (!mounted) return;
    Navigator.of(context).pop();
  }
}

class TodoFormModelProvider extends InheritedNotifier {
  final TodoFormModel model;
  const TodoFormModelProvider({
    super.key,
    required Widget child,
    required this.model,
  }) : super(
          child: child,
          notifier: model,
        );

  static TodoFormModelProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TodoFormModelProvider>();
  }

  static TodoFormModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<TodoFormModelProvider>()
        ?.widget;
    return widget is TodoFormModelProvider ? widget : null;
  }
}
