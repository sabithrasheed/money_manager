import 'package:flutter/material.dart';
import 'package:money_management_app/Database/Category/category_db.dart';

import '../../Models/Category/category_model.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CategoryDataBaseClass().expenseListListener,
      builder:
          (BuildContext context, List<CategoryModel> newexpneselist, Widget_) {
        return ListView.separated(
          itemBuilder: (ctx, index) {
            final expenseobj = newexpneselist[index];
            return Card(
              elevation: 4,
              child: ListTile(
                  title: Text(expenseobj.name),
                  trailing: IconButton(
                    onPressed: () {
                      CategoryDataBaseClass.instance
                          .deleteCategory(expenseobj.id);
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  )),
            );
          },
          separatorBuilder: (ctx, index) {
            return SizedBox(
              height: 10,
            );
          },
          itemCount: newexpneselist.length,
        );
      },
    );
  }
}
