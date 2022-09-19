import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_list/constants/app_colors.dart';
import 'package:todo_list/ui/screens/todo_screen/other_page/other_page_model.dart';
import 'package:todo_list/ui/screens/todo_screen/other_page/other_todo_form.dart';

class OtherTodoPage extends StatefulWidget {
  const OtherTodoPage({super.key});

  @override
  State<OtherTodoPage> createState() => _OtherTodoPageState();
}

class _OtherTodoPageState extends State<OtherTodoPage> {
  final _model = OtherPageModel();
  @override
  Widget build(BuildContext context) {
    return OtherPageModelProvider(
      model: _model,
      child: const OtherPageBody(),
    );
  }

  @override
  void dispose() async {
    super.dispose();
    await _model.dispose();
  }
}

class OtherPageBody extends StatelessWidget {
  const OtherPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLite,
      body: const OtherTodoList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: AppColors.backgroundLite,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(12),
            ),
          ),
          builder: (context) => const OtherTodoForm(),
        ),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class OtherTodoList extends StatelessWidget {
  const OtherTodoList({super.key});

  @override
  Widget build(BuildContext context) {
    final model = OtherPageModelProvider.watch(context)!.model;
    final todoCount = model.todo.length;
    if (todoCount == 0) {
      return Padding(
        padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'У вас пока нет задач.',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 25,
              ),
            ),
            SizedBox(height: 15),
            Text(
              'Диспечер задач — эффективное средство для планирования и управления повседневными задачами. Совершенствуйтесь и повышайте производительность отслеживая статус выполнения ежедневных дел.',
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(top: 15),
        child: ListView.separated(
          itemCount: todoCount,
          itemBuilder: (context, index) {
            final style = model.todo[index].isDone
                ? const TextStyle(
                    color: AppColors.secendary,
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.lineThrough,
                  )
                : null;

            return Slidable(
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  const Spacer(),
                  SlidableAction(
                    borderRadius: BorderRadius.circular(15),
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: null,
                    onPressed: (_) => model.deleteTodo(index),
                  ),
                ],
              ),
              child: ListTile(
                minLeadingWidth: 10,
                title: Text(model.todo[index].name, style: style),
                leading: Container(
                  width: 11,
                  height: 11,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 132, 134, 138),
                      width: 2.5,
                    ),
                    borderRadius: BorderRadius.circular(5.5),
                  ),
                ),
                trailing: model.todo[index].isDone
                    ? const Text(
                        'Выполнено',
                        style: TextStyle(color: Colors.green, fontSize: 11),
                      )
                    : null,
                onTap: () => model.doneToggle(index),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider(
              height: 8,
            );
          },
        ),
      );
    }
  }
}
