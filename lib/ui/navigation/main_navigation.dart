import 'package:flutter/material.dart';
import 'package:todo_list/ui/screens/goals_screen/goals_screen.dart';
import 'package:todo_list/ui/screens/notes_screen/notes_screen.dart';
import 'package:todo_list/ui/screens/todo_screen/todo_screen.dart';

abstract class MainNavigationRouteNames {
  static const todo = 'todo';
  static const goals = 'goals';
  static const notes = 'notes';
}

class MainNavigation {
  final initialRoute = MainNavigationRouteNames.todo;
  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteNames.todo: (context) => const TodoScreen(),
    MainNavigationRouteNames.goals: (context) => const GoalsScreen(),
    MainNavigationRouteNames.notes: (context) => const NotesScreen(),
  };
}
