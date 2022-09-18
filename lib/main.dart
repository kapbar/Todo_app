import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/constants/app_colors.dart';
import 'package:todo_list/ui/navigation/main_navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final mainNavigation = MainNavigation();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Блокнот-Записки',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: AppColors.primary,
          backgroundColor: AppColors.backgroundLite,
          cardColor: AppColors.backgroundLite,
        ),
      ),
      routes: mainNavigation.routes,
      initialRoute: mainNavigation.initialRoute,
    );
  }
}
