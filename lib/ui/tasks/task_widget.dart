import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_list/ui/tasks/task_widget_model.dart';

class TaskWidgetConfiguration {
  final int todoKey;
  final String title;

  TaskWidgetConfiguration(this.todoKey, this.title);
}

class TaskWidget extends StatefulWidget {
  final TaskWidgetConfiguration configuration;
  const TaskWidget({super.key, required this.configuration});

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  late final TaskWidgetModel _model;

  @override
  void initState() {
    super.initState();
    _model = TaskWidgetModel(configuration: widget.configuration);
  }

  @override
  Widget build(BuildContext context) {
    return TaskWidgetModelProvider(
      model: _model,
      child: const TaskWidgetBody(),
    );
  }

  @override
  void dispose() async {
    await _model.dispose();
    super.dispose();
  }
}

class TaskWidgetBody extends StatelessWidget {
  const TaskWidgetBody({super.key});

  @override
  Widget build(BuildContext context) {
    final model = TaskWidgetModelProvider.watch(context)?.model;
    final title = model?.configuration.title ?? 'Todo';
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
    final style = task.isDone
        ? const TextStyle(
            color: Colors.black45,
            decoration: TextDecoration.lineThrough,
          )
        : null;
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
        title: Text(
          task.text,
          style: style,
        ),
        onTap: () => model.doneToggle(index),
      ),
    );
  }
}
