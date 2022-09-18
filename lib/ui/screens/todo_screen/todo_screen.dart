import 'package:flutter/material.dart';
import 'package:todo_list/constants/app_colors.dart';
import 'package:todo_list/ui/screens/todo_screen/todo_pages/personal_page.dart';
import 'package:todo_list/widgets/app_nav_bar.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: AppColors.backgroundLite,
        bottomNavigationBar: const AppNavBar(current: 0),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.dehaze,
              color: AppColors.secendary,
            ),
          ),
          title: const Text(
            'Список дел',
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w700,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.calendar_today_outlined,
                color: AppColors.secendary,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert_outlined,
                color: AppColors.secendary,
              ),
            ),
          ],
          bottom: TabBar(
            labelStyle: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
            unselectedLabelColor: Colors.black87,
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
            labelPadding: const EdgeInsets.symmetric(horizontal: 10.0),
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            indicator: const BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            indicatorSize: TabBarIndicatorSize.label,
            isScrollable: true,
            tabs: const [
              TabItemWidget(title: 'Личные'),
              TabItemWidget(title: 'Работа'),
              TabItemWidget(title: 'Список покупок'),
              TabItemWidget(title: 'Другое'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const PersonalTodoPage(),
            Container(),
            Container(
              color: Colors.blue,
            ),
            Container(
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}

class TabItemWidget extends StatelessWidget {
  final String title;
  const TabItemWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11.0, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black87),
        borderRadius: const BorderRadius.all(Radius.circular(9)),
      ),
      child: Center(
        child: Text(title),
      ),
    );
  }
}
