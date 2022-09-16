import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/data_provider/box_manager.dart';
import 'package:todo_list/entity/todo.dart';
import 'package:todo_list/ui/navigation/main_navigation.dart';
import 'package:todo_list/ui/tasks/task_widget.dart';

class TodoWidgetModel extends ChangeNotifier {
  TodoWidgetModel() {
    _setUp();
  }

  late final Future<Box<Todo>> _box;
  ValueListenable<Object>? _listenable;
  var _todo = <Todo>[];
  List<Todo> get todo => _todo.toList();

  void showForm(BuildContext context) {
    Navigator.of(context).pushNamed(MainNavigationRouteNames.todoForm);
  }

  Future<void> showTasks(BuildContext context, int index,
      [bool mounted = true]) async {
    final todo = (await _box).getAt(index);
    if (todo != null) {
      final configuration = TaskWidgetConfiguration(todo.key as int, todo.name);
      if (!mounted) return;
      Navigator.of(context)
          .pushNamed(MainNavigationRouteNames.tasks, arguments: configuration);
    }
  }

  Future<void> deleteTodo(int index) async {
    final box = await _box;
    final todoKey = box.keyAt(index) as int;
    final taskBoxName = BoxManager.instance.makeTaskBoxName(todoKey);
    await Hive.deleteBoxFromDisk(taskBoxName);
    await box.deleteAt(index);
  }

  Future<void> _readTodoFormHive() async {
    _todo = (await _box).values.toList();
    notifyListeners();
  }

  Future<void> _setUp() async {
    _box = BoxManager.instance.openTodoBox();
    await _readTodoFormHive();
    _listenable = (await _box).listenable();
    _listenable?.addListener(_readTodoFormHive);
  }

  @override
  Future<void> dispose() async {
    _listenable?.removeListener(_readTodoFormHive);
    await BoxManager.instance.closeBox(await _box);
    super.dispose();
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
