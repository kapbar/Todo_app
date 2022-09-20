import 'package:flutter/material.dart';

import 'package:todo_list/constants/app_colors.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: AppColors.backgroundLite,
        child: Column(
          children: const [
            SizedBox(height: 50),
            ListTile(
              dense: true,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 20, horizontal: 25),
              minLeadingWidth: 50,
              iconColor: Color.fromARGB(255, 211, 63, 75),
              leading: Icon(
                Icons.collections_bookmark_outlined,
                size: 42,
              ),
              title: Text(
                'Блокнот',
                style: TextStyle(
                  fontSize: 26,
                  color: Color.fromARGB(255, 66, 71, 79),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Divider(),
            ListTileWidget(title: 'Темный режим', icon: Icons.timelapse),
            ListTileWidget(title: 'Темы', icon: Icons.theaters),
            ListTileWidget(title: 'Язык', icon: Icons.language_outlined),
            ListTileWidget(
                title: 'Отключить рекламу', icon: Icons.star_outline_rounded),
            ListTileWidget(title: 'Настройки', icon: Icons.settings_outlined),
            ListTileWidget(
                title: 'Пожертвования', icon: Icons.favorite_border_outlined),
            Divider(height: 20),
            ListTileWidget(title: 'Поделиться', icon: Icons.share_rounded),
            ListTileWidget(
                title: 'Частые вопросы', icon: Icons.question_mark_rounded),
            ListTileWidget(title: 'Обратная связь', icon: Icons.mode_outlined),
            ListTileWidget(
                title: 'Оцените нас', icon: Icons.star_outline_rounded),
          ],
        ),
      ),
    );
  }
}

class ListTileWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  const ListTileWidget({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
      minLeadingWidth: 10,
      onTap: () {},
      iconColor: AppColors.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      leading: Icon(icon),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 17,
          color: Color.fromARGB(255, 66, 71, 79),
        ),
      ),
    );
  }
}
