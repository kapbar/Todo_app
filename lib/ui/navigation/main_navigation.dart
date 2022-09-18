import 'package:flutter/material.dart';
import 'package:todo_list/ui/screens/todo_screen/todo_screen.dart';
import 'package:todo_list/ui/todo_form/todo_form.dart';

abstract class MainNavigationRouteNames {
  static const todo = 'todo';
  static const goals = 'goals';
  static const notes = 'notes';
}

class MainNavigation {
  final initialRoute = MainNavigationRouteNames.todo;
  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteNames.todo: (context) =>  const TodoScreen(),
    MainNavigationRouteNames.goals: (context) => const TodoForm(),
    MainNavigationRouteNames.notes: (context) => const TodoForm(),
  };
}
