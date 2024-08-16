import 'package:flutter/material.dart';
import 'package:money_management_app/Screens/AddTransactions/addtrans_act.dart';
import 'package:money_management_app/Screens/Categories/categories.dart';
import 'package:money_management_app/Screens/Categories/category_popup.dart';
import 'package:money_management_app/Screens/Transactions/transactions.dart';
import 'package:money_management_app/Screens/Widgets/bottom_nav.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static ValueNotifier<int> selectedindexnotifier = ValueNotifier(0);
  final pages = const [
    TransactionsScreen(),
    CategoriesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'MONEY MANAGER',
          style: TextStyle(
            fontSize: 28,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationScreen(),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: selectedindexnotifier,
          builder: (BuildContext context, int newvalue, _) {
            return pages[newvalue];
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade300,
        onPressed: () {
          if (selectedindexnotifier.value == 0) {
            print('Add Transactions');
            Navigator.of(context).pushNamed(AddTransactionScreen.routesname);
          } else {
            print('Add categories');
            addCategoryPopup(context);
          }
        },
        child: Icon(
          Icons.add,
          size: 35,
        ),
      ),
    );
  }
}
