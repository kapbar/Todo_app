import 'package:flutter/material.dart';
import 'package:todo_list/constants/app_colors.dart';

class FinanceListItem extends StatelessWidget {
  final String title;
  const FinanceListItem({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 2),
      dense: true,
      onTap: () {},
      title: Text(
        title,
        style: const TextStyle(fontSize: 16),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('\u00240,0'),
          OutlinedButton(
            style: ButtonStyle(
              side: MaterialStateProperty.all(
                  const BorderSide(color: AppColors.secendary)),
              minimumSize: MaterialStateProperty.all(const Size(0, 0)),
              padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 6.5)),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
              ),
            ),
            onPressed: () {},
            child: const Text(
              '+',
              style: TextStyle(
                  fontWeight: FontWeight.w600, fontSize: 18, height: 1.3),
            ),
          ),
        ],
      ),
    );
  }
}
