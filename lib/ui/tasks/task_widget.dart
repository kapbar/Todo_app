import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
    return TaskWidgetModelProvider(
      model: _model!,
      child: const TaskWidgetBody(),
    );
  }
}

class TaskWidgetBody extends StatelessWidget {
  const TaskWidgetBody({super.key});

  @override
  Widget build(BuildContext context) {
    final model = TaskWidgetModelProvider.watch(context)?.model;
    final title = model?.todo?.name ?? 'Todo';
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: const TaskList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => model?.showForm(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TaskList extends StatelessWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    final todoCount =
        TaskWidgetModelProvider.watch(context)?.model.tasks.length ?? 0;
    return ListView.separated(
      itemCount: todoCount,
      itemBuilder: (context, index) {
        return TaskListRowWidget(index: index);
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
    );
  }
}

class TaskListRowWidget extends StatelessWidget {
  final int index;
  const TaskListRowWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final model = TaskWidgetModelProvider.read(context)!.model;
    final task = model.tasks[index];
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
            onPressed: (_) => model.deleteTask(index),
          ),
        ],
      ),
      child: ListTile(
        title: Text(task.text),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {},
      ),
    );
  }
}
