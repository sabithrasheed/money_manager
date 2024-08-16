// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:money_management_app/Models/Category/category_model.dart';

const categoryDBname = 'Database name';

abstract class CategoryDatas {
  Future<List<CategoryModel>> getcategories();
  Future<void> insertCategory(CategoryModel modelvalue);
  Future<void> deleteCategory(String categoryid);
}

class CategoryDataBaseClass implements CategoryDatas {
  CategoryDataBaseClass.internal();
  static CategoryDataBaseClass instance = CategoryDataBaseClass.internal();
  factory CategoryDataBaseClass() {
    return instance;
  }

  ValueNotifier<List<CategoryModel>> incomeListListener = ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expenseListListener = ValueNotifier([]);

  @override
  Future<void> insertCategory(CategoryModel modelvalue) async {
    final insertdb = await Hive.openBox<CategoryModel>(categoryDBname);
    await insertdb.put(modelvalue.id, modelvalue);
    refreshUI();
  }

  @override
  Future<List<CategoryModel>> getcategories() async {
    final insertdb = await Hive.openBox<CategoryModel>(categoryDBname);
    return insertdb.values.toList();
  }

  Future<void> refreshUI() async {
    final addgetcategory = await getcategories();
    incomeListListener.value.clear();
    expenseListListener.value.clear();

    await Future.forEach(addgetcategory, (CategoryModel categoryobj2) {
      if (categoryobj2.types == CategoryType.income) {
        incomeListListener.value.add(categoryobj2);
      } else {
        expenseListListener.value.add(categoryobj2);
      }
    });

    incomeListListener.notifyListeners();

    expenseListListener.notifyListeners();
  }

  @override
  Future<void> deleteCategory(String categoryid) async {
    final insertdb = await Hive.openBox<CategoryModel>(categoryDBname);
    await insertdb.delete(categoryid);
    refreshUI();
  }
}
