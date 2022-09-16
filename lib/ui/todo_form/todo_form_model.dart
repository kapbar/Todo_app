import 'package:flutter/material.dart';
import 'package:todo_list/data_provider/box_manager.dart';
import 'package:todo_list/entity/todo.dart';

class TodoFormModel {
  var todoName = '';

  void saveTodo(BuildContext context, [bool mounted = true]) async {
    if (todoName.isEmpty) return;
    final box = await BoxManager.instance.openTodoBox();
    final todo = Todo(name: todoName);
    await box.add(todo);
    await BoxManager.instance.closeBox(box);
    if (!mounted) return;
    Navigator.of(context).pop();
  }
}

class TodoFormModelProvider extends InheritedWidget {
  final TodoFormModel model;
  const TodoFormModelProvider({
    super.key,
    required Widget child,
    required this.model,
  }) : super(child: child);

  static TodoFormModelProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TodoFormModelProvider>();
  }

  static TodoFormModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<TodoFormModelProvider>()
        ?.widget;
    return widget is TodoFormModelProvider ? widget : null;
  }

  @override
  bool updateShouldNotify(TodoFormModelProvider oldWidget) {
    return false;
  }
}
