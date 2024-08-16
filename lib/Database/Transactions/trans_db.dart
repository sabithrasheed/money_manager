import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:money_management_app/Models/Transaction/transaction_model.dart';

const categoryDBname = 'Database name';

abstract class TransactionFunctions {
  Future<void> addTransaction(TransactionModels transobj);
  Future<List<TransactionModels>> getTransaction();
}

class TransactionDB implements TransactionFunctions {
  TransactionDB.internal();
  static TransactionDB instance = TransactionDB.internal();
  factory TransactionDB() {
    return instance;
  }
  ValueNotifier<List<TransactionModels>> transactionNotifier =
      ValueNotifier([]);
  @override
  Future<void> addTransaction(TransactionModels transobj) async {
    final transdb = await Hive.openBox<TransactionModels>(categoryDBname);
    await transdb.put(transobj.id, transobj);
  }

  Future<void> transactionRefresh() async {
    final translist = await getTransaction();
    transactionNotifier.value.clear();
    transactionNotifier.value.addAll(translist);
    transactionNotifier.notifyListeners();
  }

  @override
  Future<List<TransactionModels>> getTransaction() async {
    final translist = await Hive.openBox<TransactionModels>(categoryDBname);
    return translist.values.toList();
  }
}
