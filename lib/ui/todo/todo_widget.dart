import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_list/ui/todo/todo_widget_model.dart';

class TodoWidget extends StatefulWidget {
  const TodoWidget({super.key});

  @override
  State<TodoWidget> createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  final _model = TodoWidgetModel();
  @override
  Widget build(BuildContext context) {
    return TodoWidgetModelProvider(
      model: _model,
      child: const TodoWidgetBody(),
    );
  }
}

class TodoWidgetBody extends StatelessWidget {
  const TodoWidgetBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo'),
        centerTitle: true,
      ),
      body: const GroupList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            TodoWidgetModelProvider.read(context)?.model.showForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class GroupList extends StatelessWidget {
  const GroupList({super.key});

  @override
  Widget build(BuildContext context) {
    final todoCount =
        TodoWidgetModelProvider.watch(context)?.model.todo.length ?? 0;
    return ListView.separated(
      itemCount: todoCount,
      itemBuilder: (context, index) {
        return GroupListRowWidget(index: index);
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
    );
  }
}

class GroupListRowWidget extends StatelessWidget {
  final int index;
  const GroupListRowWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final model = TodoWidgetModelProvider.read(context)!.model;
    final todo = model.todo[index];
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
            onPressed: (_) => model.deleteTodo(index),
          ),
        ],
      ),
      child: ListTile(
        title: Text(todo.name),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => model.showTasks(context, index),
      ),
    );
  }
}
