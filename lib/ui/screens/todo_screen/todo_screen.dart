import 'package:flutter/material.dart';
import 'package:todo_list/constants/app_colors.dart';
import 'package:todo_list/ui/screens/todo_screen/other_page/other_page.dart';
import 'package:todo_list/ui/screens/todo_screen/personal_page/personal_page.dart';
import 'package:todo_list/ui/screens/todo_screen/shop_page/shop_page.dart';
import 'package:todo_list/ui/screens/todo_screen/work_page/work_page.dart';
import 'package:todo_list/widgets/app_nav_bar.dart';
import 'package:todo_list/widgets/tab_item_widget.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: AppColors.backgroundLite,
        bottomNavigationBar: const AppNavBar(current: 0),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Drawer(
              backgroundColor: AppColors.backgroundLite,
              child: Container(
                height: 200,
                width: 200,
              ),
            ),
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
        body: const TabBarView(
          children: [
            PersonalTodoPage(),
            WorkTodoPage(),
            ShopTodoPage(),
            OtherTodoPage(),
          ],
        ),
      ),
    );
  }
}
