import 'package:flutter/material.dart';
import 'package:todo_list/ui/task_form/task_form_model.dart';

class TaskForm extends StatefulWidget {
  const TaskForm({super.key});

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  TaskFormModel? _model;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_model == null) {
      final todoKey = ModalRoute.of(context)!.settings.arguments as int;
      _model = TaskFormModel(todoKey: todoKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TaskFormModelProvider(
      model: _model!,
      child: const TaskFormBody(),
    );
  }
}

class TaskFormBody extends StatelessWidget {
  const TaskFormBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Task'),
        centerTitle: true,
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: TaskName(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            TaskFormModelProvider.read(context)?.model.saveTask(context),
        child: const Icon(Icons.done),
      ),
    );
  }
}

class TaskName extends StatelessWidget {
  const TaskName({super.key});

  @override
  Widget build(BuildContext context) {
    final model = TaskFormModelProvider.read(context)?.model;
    return TextField(
      autofocus: true,
      expands: true,
      maxLines: null,
      minLines: null,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Name task',
      ),
      onEditingComplete: () => model?.saveTask(context),
      onChanged: (value) => model?.taskText = value,
    );
  }
}
