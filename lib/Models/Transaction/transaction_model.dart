import 'package:hive/hive.dart';
import 'package:money_management_app/Models/Category/category_model.dart';
part 'transaction_model.g.dart';

@HiveType(typeId: 3)
class TransactionModels {
  @HiveField(0)
  final String purpose;
  @HiveField(1)
  final double amount;
  @HiveField(2)
  final DateTime date;
  @HiveField(3)
  final CategoryType transactiontype;
  @HiveField(4)
  final CategoryModel transactionmodel;
  @HiveField(5)
  String? id;

  TransactionModels({
    required this.purpose,
    required this.amount,
    required this.date,
    required this.transactiontype,
    required this.transactionmodel,
  }) {
    id = DateTime.now().millisecondsSinceEpoch.toString();
  }
}
