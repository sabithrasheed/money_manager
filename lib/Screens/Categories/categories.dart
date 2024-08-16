import 'package:flutter/material.dart';
import 'package:money_management_app/Database/Category/category_db.dart';
import 'package:money_management_app/Screens/Categories/expense.dart';
import 'package:money_management_app/Screens/Categories/income.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    CategoryDataBaseClass().refreshUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
            controller: _tabController,
            labelColor: Colors.black,
            labelStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelColor: Colors.black54,
            unselectedLabelStyle: TextStyle(
              fontSize: 13,
              fontStyle: FontStyle.italic,
            ),
            tabs: [
              Tab(
                text: 'INCOME',
                icon: Icon(
                  Icons.money_sharp,
                  color: Colors.green,
                  size: 30,
                ),
              ),
              Tab(
                text: 'EXPENSE',
                icon: Icon(
                  Icons.explore_off,
                  color: Colors.red,
                  size: 30,
                ),
              ),
            ]),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              IncomeList(),
              ExpenseList(),
            ],
          ),
        )
      ],
    );
  }
}
