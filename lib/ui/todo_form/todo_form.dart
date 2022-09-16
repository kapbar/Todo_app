import 'package:flutter/material.dart';
import 'package:todo_list/ui/todo_form/todo_form_model.dart';

class TodoForm extends StatefulWidget {
  const TodoForm({super.key});

  @override
  State<TodoForm> createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  final _model = TodoFormModel();

  @override
  Widget build(BuildContext context) {
    return TodoFormModelProvider(
      model: _model,
      child: const TodoFormBody(),
    );
  }
}

class TodoFormBody extends StatelessWidget {
  const TodoFormBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Todo'),
        centerTitle: true,
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: TodoName(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            TodoFormModelProvider.read(context)?.model.saveTodo(context),
        child: const Icon(Icons.done),
      ),
    );
  }
}

class TodoName extends StatelessWidget {
  const TodoName({super.key});

  @override
  Widget build(BuildContext context) {
    final model = TodoFormModelProvider.watch(context)?.model;
    return TextField(
      autofocus: true,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: 'Name Todo',
        errorText: model?.errorText,
      ),
      onEditingComplete: () => model?.saveTodo(context),
      onChanged: (value) => model?.todoName = value,
    );
  }
}
