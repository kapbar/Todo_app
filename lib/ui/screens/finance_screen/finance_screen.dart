import 'package:flutter/material.dart';
import 'package:todo_list/constants/app_colors.dart';
import 'package:todo_list/ui/screens/finance_screen/finance_page_body_one.dart';
import 'package:todo_list/ui/screens/finance_screen/finance_page_body_two.dart';
import 'package:todo_list/widgets/app_nav_bar.dart';
import 'package:todo_list/widgets/category_burron_widget.dart';
import 'package:todo_list/widgets/drawer_widget.dart';

class FinanceScreen extends StatelessWidget {
  const FinanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: const DrawerWidget(),
        backgroundColor: AppColors.backgroundLite,
        bottomNavigationBar: const AppNavBar(current: 3),
        appBar: AppBar(
          title: const Text(
            'Финансы',
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
                Icons.update_rounded,
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
        ),
        body: Column(
          children: [
            Container(
              width: 250,
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.secendary),
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              child: TabBar(
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
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                indicator: const BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                indicatorPadding: const EdgeInsets.all(1.0),
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: const [
                  Center(child: Text('Расходы')),
                  Center(child: Text('Доходы')),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Expanded(
              child: TabBarView(
                children: [
                  FinancePage(widget: FinancePageBodyOne()),
                  FinancePage(widget: FinancePageBodyTwo()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FinancePage extends StatelessWidget {
  final Widget widget;
  const FinancePage({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLite,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              widget,
              const SizedBox(height: 7),
              const CategoryButtonWidget(),
              const Center(
                child: Text('История'),
              ),
              const SizedBox(height: 140),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
