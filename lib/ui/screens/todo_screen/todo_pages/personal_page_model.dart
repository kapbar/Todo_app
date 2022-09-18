import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/constants/app_colors.dart';
import 'package:todo_list/data_provider/box_manager.dart';
import 'package:todo_list/entity/todo.dart';
import 'package:todo_list/ui/screens/todo_screen/todo_pages/personal_page.dart';

class PersonalPageModel extends ChangeNotifier {
  PersonalPageModel() {
    _setUp();
  }
  late final Future<Box<Todo>> _box;
  ValueListenable<Object>? _listenable;
  var _todo = <Todo>[];
  List<Todo> get todo => _todo.toList();

  void showForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(10),
        ),
      ),
      builder: (context) => ColoredBox(
        color: AppColors.backgroundLite,
        child: DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.4,
          minChildSize: 0.32,
          maxChildSize: 0.9,
          builder: (context, scrollcontroller) => SingleChildScrollView(
            controller: scrollcontroller,
            child: const PersonalTodoForm(),
          ),
        ),
      ),
    );
  }

  Future<void> deleteTodo(int index) async {
    final box = await _box;
    await box.deleteAt(index);
  }

  Future<void> _readTodoFormHive() async {
    _todo = (await _box).values.toList();
    notifyListeners();
  }

  Future<void> _setUp() async {
    _box = BoxManager.instance.openPersonalBox();
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

class PersonalPageModelProvider extends InheritedNotifier {
  final PersonalPageModel model;
  const PersonalPageModelProvider({
    super.key,
    required Widget child,
    required this.model,
  }) : super(
          child: child,
          notifier: model,
        );

  static PersonalPageModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<PersonalPageModelProvider>();
  }

  static PersonalPageModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<PersonalPageModelProvider>()
        ?.widget;
    return widget is PersonalPageModelProvider ? widget : null;
  }
}
