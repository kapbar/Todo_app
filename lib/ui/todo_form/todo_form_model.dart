import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/entity/todo.dart';

class TodoFormModel {
  var todoName = '';

  void saveTodo(BuildContext context) async {
    if (todoName.isEmpty) return;
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(TodoAdapter());
    }
    Navigator.of(context).pop();
    final box = await Hive.openBox<Todo>('todo_box');
    final todo = Todo(name: todoName);
    await box.add(todo);
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
    return true;
  }
}
