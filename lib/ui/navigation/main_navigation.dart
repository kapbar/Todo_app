import 'package:flutter/material.dart';
import 'package:todo_list/ui/task_form/task_form.dart';
import 'package:todo_list/ui/tasks/task_widget.dart';
import 'package:todo_list/ui/todo/todo_widget.dart';
import 'package:todo_list/ui/todo_form/todo_form.dart';

abstract class MainNavigationRouteNames {
  static const todo = '/';
  static const todoForm = '/todoForm';
  static const tasks = '/tasks';
  static const tasksForm = '/tasks/form';
}

class MainNavigation {
  final initialRoute = MainNavigationRouteNames.todo;
  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteNames.todo: (context) => const TodoWidget(),
    MainNavigationRouteNames.todoForm: (context) => const TodoForm(),
  };
  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteNames.tasks:
        final configuration = settings.arguments as TaskWidgetConfiguration;
        return MaterialPageRoute(
          builder: (context) => TaskWidget(configuration: configuration),
        );

      case MainNavigationRouteNames.tasksForm:
        final todoKey = settings.arguments as int;
        return MaterialPageRoute(
          builder: (context) => TaskForm(todoKey: todoKey),
        );
      default:
        const widget = Text('Navigation Error!!!');
        return MaterialPageRoute(builder: (context) => widget);
    }
  }
}
