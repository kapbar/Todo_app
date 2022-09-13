import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/ui/task_form/task_form.dart';
import 'package:todo_list/ui/tasks/task_widget.dart';
import 'package:todo_list/ui/todo/todo_widget.dart';
import 'package:todo_list/ui/todo_form/todo_form.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/todo': (context) => const TodoWidget(),
        '/todo/form': (context) => const TodoForm(),
        '/todo/tasks': (context) => const TaskWidget(),
        '/todo/tasks/form': (context) => const TaskForm(),
      },
      initialRoute: '/todo',
    );
  }
}
