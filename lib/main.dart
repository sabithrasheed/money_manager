import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_management_app/Models/Category/category_model.dart';
import 'package:money_management_app/Models/Transaction/transaction_model.dart';
import 'package:money_management_app/Screens/AddTransactions/addtrans_act.dart';
import 'package:money_management_app/Screens/Home/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.initFlutter();
  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }

  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }
  if (!Hive.isAdapterRegistered(TransactionModelsAdapter().typeId)) {
    Hive.registerAdapter(TransactionModelsAdapter());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: HomeScreen(),
      routes: {
        AddTransactionScreen.routesname: (ctx) {
          return AddTransactionScreen();
        }
      },
    );
  }
}
