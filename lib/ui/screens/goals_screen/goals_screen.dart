import 'package:flutter/material.dart';
import 'package:todo_list/constants/app_colors.dart';
import 'package:todo_list/widgets/app_nav_bar.dart';
import 'package:todo_list/widgets/drawer_widget.dart';

class GoalsScreen extends StatelessWidget {
  const GoalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      bottomNavigationBar: const AppNavBar(current: 1),
      backgroundColor: AppColors.backgroundLite,
      appBar: AppBar(
       
        title: const Text(
          'Цели',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'У вас пока нет целей.',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 25,
              ),
            ),
            SizedBox(height: 15),
            Text(
              '«Цели должны быть ясными, простыми и записанными. Если они не записаны и их каждый день не пересматривать - это не цели. Это пожелания».',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
