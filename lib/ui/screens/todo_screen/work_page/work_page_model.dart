import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/data_provider/box_manager.dart';
import 'package:todo_list/entity/todo.dart';

class WorkPageModel extends ChangeNotifier {
  WorkPageModel() {
    _setUp();
  }
  late final Future<Box<Todo>> _box;
  ValueListenable<Object>? _listenable;
  var _todo = <Todo>[];
  List<Todo> get todo => _todo.toList();

  Future<void> deleteTodo(int index) async {
    final box = await _box;
    await box.deleteAt(index);
  }

  Future<void> doneToggle(int index) async {
    final currentState = _todo[index].isDone;
    _todo[index].isDone = !currentState;
    await _todo[index].save();
    notifyListeners();
  }

  Future<void> _readTodoFormHive() async {
    _todo = (await _box).values.toList();
    notifyListeners();
  }

  Future<void> _setUp() async {
    _box = BoxManager.instance.openWorkBox();
    await _readTodoFormHive();
    _listenable = (await _box).listenable();
    _listenable?.addListener(_readTodoFormHive);
  }

  @override
  Future<void> dispose() async {
    _listenable?.removeListener(_readTodoFormHive);
    final box = await _box;
    await BoxManager.instance.closeBox(box);
    super.dispose();
  }
}

class WorkPageModelProvider extends InheritedNotifier {
  final WorkPageModel model;
  const WorkPageModelProvider({
    super.key,
    required Widget child,
    required this.model,
  }) : super(
          child: child,
          notifier: model,
        );

  static WorkPageModelProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<WorkPageModelProvider>();
  }

  static WorkPageModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<WorkPageModelProvider>()
        ?.widget;
    return widget is WorkPageModelProvider ? widget : null;
  }
}
