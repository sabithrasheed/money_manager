import 'package:flutter/material.dart';
import 'package:money_management_app/Database/Category/category_db.dart';

import '../../Models/Category/category_model.dart';

class IncomeList extends StatelessWidget {
  const IncomeList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: CategoryDataBaseClass().incomeListListener,
        builder:
            (BuildContext context, List<CategoryModel> newincomelsit, Widget_) {
          return ListView.separated(
            itemBuilder: (ctx, index) {
              final incomeobj = newincomelsit[index];
              return Card(
                elevation: 4,
                child: ListTile(
                    title: Text(incomeobj.name),
                    trailing: IconButton(
                      onPressed: () {
                        CategoryDataBaseClass.instance
                            .deleteCategory(incomeobj.id);
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.green,
                      ),
                    )),
              );
            },
            separatorBuilder: (ctx, index) {
              return SizedBox(
                height: 10,
              );
            },
            itemCount: newincomelsit.length,
          );
        });
  }
}
