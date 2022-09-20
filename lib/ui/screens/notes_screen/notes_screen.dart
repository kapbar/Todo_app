import 'package:flutter/material.dart';
import 'package:todo_list/constants/app_colors.dart';
import 'package:todo_list/widgets/app_nav_bar.dart';
import 'package:todo_list/widgets/drawer_widget.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerWidget(),
      bottomNavigationBar: const AppNavBar(current: 2),
      backgroundColor: AppColors.backgroundLite,
      appBar: AppBar(
      
        title: const Text(
          'Заметки',
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
              Icons.search_outlined,
              color: AppColors.secendary,
              size: 27,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
        child: ListView(
          children: const [
            NotesWidget(title: 'Дневник'),
            SizedBox(height: 15),
            NotesWidget(title: 'Дневник успеха'),
            SizedBox(height: 15),
            NotesWidget(title: 'Благодарности'),
            SizedBox(height: 15),
            NotesWidget(title: 'Мои ощибки'),
            SizedBox(height: 15),
            NotesWidget(title: 'Дневник счастья'),
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

class NotesWidget extends StatelessWidget {
  final String title;
  const NotesWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      onTap: () {},
      iconColor: AppColors.primary,
      tileColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13.0),
      ),
      leading: const Icon(Icons.folder),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: const Text(
        '0',
        style: TextStyle(
          color: AppColors.secendary,
          fontSize: 16,
        ),
      ),
    );
  }
}
