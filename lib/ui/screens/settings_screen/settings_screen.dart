import 'package:flutter/material.dart';
import 'package:todo_list/widgets/app_nav_bar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: AppNavBar(current: 3),
      body: Center(child: Text('Настройки')),
    );
  }
}
