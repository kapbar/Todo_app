import 'package:flutter/material.dart';
import 'package:todo_list/ui/tasks/task_widget_model.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({super.key});

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  TaskWidgetModel? _model;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_model == null) {
      final todoKey = ModalRoute.of(context)!.settings.arguments as int;
      _model = TaskWidgetModel(todoKey: todoKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
