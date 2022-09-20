import 'package:flutter/material.dart';
import 'package:todo_list/constants/app_colors.dart';
import 'package:todo_list/widgets/finance_list_item_widget.dart';

class FinancePageBodyOne extends StatelessWidget {
  const FinancePageBodyOne({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, top: 12, right: 7, bottom: 35),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        children: [
          const FinanceListItem(title: 'Продукты'),
          const Divider(height: 1),
          const FinanceListItem(title: 'Образование'),
          const Divider(height: 1),
          const FinanceListItem(title: 'Транспорт'),
          const Divider(height: 1),
          const FinanceListItem(title: 'Здоровье'),
          const Divider(height: 1),
          const FinanceListItem(title: 'Отдых и развлечения'),
          const Divider(height: 1),
          const FinanceListItem(title: 'Кафе и рестораны'),
          const Divider(height: 1),
          const FinanceListItem(title: 'Покупки, одежды'),
          const Divider(height: 1),
          const FinanceListItem(title: 'Спорт, фитнес'),
          const Divider(height: 1),
          Padding(
            padding:
                const EdgeInsets.only(right: 23, left: 10, top: 30, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Итого:',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '0,0',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 23, left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Баланс:',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '0,0',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}