import 'package:flutter/material.dart';
import 'package:todo_list/constants/app_colors.dart';
import 'package:todo_list/ui/screens/goals_screen/goals_screen.dart';
import 'package:todo_list/ui/screens/notes_screen/notes_screen.dart';
import 'package:todo_list/ui/screens/settings_screen/settings_screen.dart';
import 'package:todo_list/ui/screens/todo_screen/todo_screen.dart';

class AppNavBar extends StatelessWidget {
  const AppNavBar({
    Key? key,
    required this.current,
  }) : super(key: key);

  final int current;

  PageRouteBuilder _createRoute(Widget screen) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 0,
            blurRadius: 10,
          ),
        ],
      ),
      child: BottomNavigationBar(
        backgroundColor: AppColors.backgroundLite,
        type: BottomNavigationBarType.fixed,
        currentIndex: current,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.secendary,
        selectedFontSize: 14.0,
        unselectedFontSize: 14.0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted_rounded),
            label: 'Дела',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mode_standby_rounded),
            label: 'Цели',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notes_rounded),
            label: 'Заметки',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Настройки',
          ),
        ],
        onTap: (index) {
          if (index == current) return;
          if (index == 0) {
            Navigator.of(context).pushAndRemoveUntil(
              _createRoute(const TodoScreen()),
              (route) => false,
            );
          } else if (index == 1) {
            Navigator.of(context).pushAndRemoveUntil(
              _createRoute(const GoalsScreen()),
              (route) => false,
            );
          } else if (index == 2) {
            Navigator.of(context).pushAndRemoveUntil(
              _createRoute(const NotesScreen()),
              (route) => false,
            );
          } else if (index == 3) {
            Navigator.of(context).pushAndRemoveUntil(
              _createRoute(const SettingsScreen()),
              (route) => false,
            );
          }
        },
      ),
    );
  }
}
