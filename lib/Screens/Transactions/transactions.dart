import 'package:flutter/material.dart';
import 'package:money_management_app/Database/Transactions/trans_db.dart';

import '../../Models/Transaction/transaction_model.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.transactionRefresh();
    return ValueListenableBuilder(
      valueListenable: TransactionDB.instance.transactionNotifier,
      builder: (BuildContext ctx, List<TransactionModels> newtransactionlist,
          Widget_) {
        return ListView.separated(
          itemBuilder: (ctx, index) {
            final _value = newtransactionlist[index];
            return Card(
              elevation: 4,
              child: ListTile(
                leading: CircleAvatar(
                  radius: 50,
                  child: Text(
                    "12\njuly",
                    textAlign: TextAlign.center,
                  ),
                ),
                title: Text(
                  ' RS${_value.amount}',
                  style: TextStyle(),
                ),
                trailing: Icon(
                  Icons.currency_rupee,
                  color: Colors.green,
                ),
                subtitle: Text(
                  _value.transactionmodel.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (ctx, index) {
            return SizedBox(
              height: 10,
            );
          },
          itemCount: newtransactionlist.length,
        );
      },
    );
  }
}
