import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_list/constants/app_colors.dart';
import 'package:todo_list/ui/screens/todo_screen/todo_pages/personal_page_model.dart';

class PersonalTodoPage extends StatefulWidget {
  const PersonalTodoPage({super.key});

  @override
  State<PersonalTodoPage> createState() => _PersonalTodoPageState();
}

class _PersonalTodoPageState extends State<PersonalTodoPage> {
  final _model = PersonalPageModel();
  @override
  Widget build(BuildContext context) {
    return PersonalPageModelProvider(
      model: _model,
      child: const PersonalPageBody(),
    );
  }

  @override
  void dispose() async {
    super.dispose();
    await _model.dispose();
  }
}

class PersonalPageBody extends StatelessWidget {
  const PersonalPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLite,
      body: const Padding(
        padding: EdgeInsets.only(top: 10, left: 20, right: 20),
        child: PersonalTodoList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            PersonalPageModelProvider.read(context)?.model.showForm(context),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class PersonalTodoList extends StatelessWidget {
  const PersonalTodoList({super.key});

  @override
  Widget build(BuildContext context) {
    final model = PersonalPageModelProvider.watch(context)!.model;
    final todoCount = model.todo.length;
    if (todoCount == 0) {
      return Column(
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
      );
    } else {
      return ListView.separated(
        itemCount: todoCount,
        itemBuilder: (context, index) {
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
                title: Text(model.todo[index].name),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {}),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
      );
    }
  }
}

class PersonalTodoForm extends StatelessWidget {
  const PersonalTodoForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: -11,
          child: Container(
            height: 6,
            width: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
          ),
        ),
        Column(
          children: [
            const SizedBox(height: 20),
            TextField(
              autofocus: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Введите задачу',
              ),
              onEditingComplete: () {},
              onChanged: (value) {},
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: const Icon(Icons.telegram_outlined),
            ),
          ],
        ),
      ],
    );
  }
}
