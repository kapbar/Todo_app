import 'package:flutter/material.dart';
import 'package:todo_list/data_provider/box_manager.dart';
import 'package:todo_list/entity/todo.dart';

class ShopTodoFormModel extends ChangeNotifier {
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
    final box = await BoxManager.instance.openShopBox();
    final todo = Todo(name: todoName, isDone: false);
    await box.add(todo);
    await BoxManager.instance.closeBox(box);
    if (!mounted) return;
    Navigator.of(context).pop();
  }
}

class ShopTodoFormModelProvider extends InheritedNotifier {
  final ShopTodoFormModel model;
  const ShopTodoFormModelProvider({
    super.key,
    required Widget child,
    required this.model,
  }) : super(
          child: child,
          notifier: model,
        );

  static ShopTodoFormModelProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ShopTodoFormModelProvider>();
  }

  static ShopTodoFormModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<ShopTodoFormModelProvider>()
        ?.widget;
    return widget is ShopTodoFormModelProvider ? widget : null;
  }
}