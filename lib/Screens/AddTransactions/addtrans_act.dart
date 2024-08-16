import 'package:flutter/material.dart';
import 'package:money_management_app/Database/Category/category_db.dart';
import 'package:money_management_app/Database/Transactions/trans_db.dart';

import 'package:money_management_app/Models/Category/category_model.dart';
import 'package:money_management_app/Models/Transaction/transaction_model.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});
  static const routesname = 'Add Transactions Routes';

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  DateTime? selectedDate;
  CategoryType? selectedCategoryType;
  CategoryModel? selectedCategoryModel2;
  String? categoryID;
  final purposecontroller = TextEditingController();
  final amountcontroller = TextEditingController();
  @override
  void initState() {
    selectedCategoryType = CategoryType.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: purposecontroller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'purpose',
            ),
          ),
          TextFormField(
            controller: amountcontroller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Amount',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextButton.icon(
            onPressed: () async {
              final datepicker = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now().subtract(
                  Duration(days: 30),
                ),
                lastDate: DateTime.now(),
              );
              if (datepicker == null) {
                return;
              } else {
                print(
                  datepicker.toString(),
                );
                setState(() {
                  selectedDate = datepicker;
                });
              }
            },
            icon: Icon(Icons.calendar_today),
            label: Text(
              selectedDate == null ? 'Select Date' : selectedDate!.toString(),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Row(
              children: [
                Radio(
                    value: CategoryType.income,
                    groupValue: selectedCategoryType,
                    onChanged: (nevalue) {
                      setState(() {
                        selectedCategoryType = CategoryType.income;
                        categoryID = null;
                      });
                    }),
                Text(
                  'Income',
                  style: TextStyle(
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Radio(
                    value: CategoryType.expense,
                    groupValue: selectedCategoryType,
                    onChanged: (newexpense) {
                      setState(() {
                        selectedCategoryType = CategoryType.expense;
                        categoryID = null;
                      });
                    }),
                Text(
                  'Expense',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ]),
          SizedBox(
            height: 10,
          ),
          DropdownButton<String>(
            hint: Text(
              'Select Category',
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
            value: categoryID,
            items: (selectedCategoryType == CategoryType.income
                    ? CategoryDataBaseClass().incomeListListener
                    : CategoryDataBaseClass().expenseListListener)
                .value
                .map((e) {
              return DropdownMenuItem(
                value: e.id,
                child: Text(e.name),
                onTap: () {
                  selectedCategoryModel2 = e;
                },
              );
            }).toList(),
            onChanged: (newclickedvalue) {
              setState(() {
                categoryID = newclickedvalue;
              });
            },
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () async {
              addTransactionButton();
            },
            child: Text(
              'Submit',
            ),
          ),
        ],
      )),
    );
  }

  Future<void> addTransactionButton() async {
    final purposetext = purposecontroller.text;
    final amounttext = amountcontroller.text;
    if (purposetext.isEmpty) {
      return;
    }
    if (amounttext.isEmpty) {
      return;
    }
    // if (categoryID == null) {
    //   return;
    // }
    if (selectedDate == null) {
      return;
    }
    final parseamounttext = double.tryParse(amounttext);
    if (parseamounttext == null) {
      return;
    }
    if (selectedCategoryModel2 == null) {
      return;
    }
    if (selectedCategoryType == null) {
      return;
    }
    final transobject = TransactionModels(
      purpose: purposetext,
      amount: parseamounttext,
      date: selectedDate!,
      transactiontype: selectedCategoryType!,
      transactionmodel: selectedCategoryModel2!,
    );
    TransactionDB.instance.addTransaction(transobject);
  }
}
