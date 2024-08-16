// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:money_management_app/Database/Category/category_db.dart';
import 'package:money_management_app/Models/Category/category_model.dart';

ValueNotifier<CategoryType> selectedpopupnotifier =
    ValueNotifier(CategoryType.income);
Future<void> addCategoryPopup(BuildContext context) async {
  final formfieldcontroller = TextEditingController();

  showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          title: Text(
            'Add Categories',
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: formfieldcontroller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Category Name',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  RadioButtonWidget(
                    title: 'Income',
                    radiotype: CategoryType.income,
                  ),
                  RadioButtonWidget(
                    title: 'Expense',
                    radiotype: CategoryType.expense,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  final name = formfieldcontroller.text;
                  if (name.isEmpty) {
                    return;
                  }
                  final objtype = selectedpopupnotifier.value;
                  final objcategory = CategoryModel(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    name: name,
                    types: objtype,
                  );
                  CategoryDataBaseClass.instance.insertCategory(objcategory);
                  Navigator.of(ctx).pop();
                },
                child: const Text('ADD'),
              ),
            ),
          ],
        );
      });
}

class RadioButtonWidget extends StatelessWidget {
  final String title;
  final CategoryType radiotype;
  const RadioButtonWidget({
    super.key,
    required this.title,
    required this.radiotype,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
            valueListenable: selectedpopupnotifier,
            builder: (BuildContext ctx, CategoryType newtype, Widget? _) {
              return Radio<CategoryType>(
                value: radiotype,
                groupValue: newtype,
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  selectedpopupnotifier.value = value;

                  // ignore: invalid_use_of_protected_member
                  selectedpopupnotifier.notifyListeners();
                },
              );
            }),
        Text(
          title,
        )
      ],
    );
  }
}
