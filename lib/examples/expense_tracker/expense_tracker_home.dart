import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:web_poc/examples/expense_tracker/page/transaction_page.dart';

import 'model/transaction.dart';

// Source of this example: https://github.com/JohannesMilke/hive_database_example
// https://www.youtube.com/watch?v=w8cZKm9s228&ab_channel=JohannesMilke

const expenseTrackerBoxName = 'transactions';
class ExpenseTrackerHome extends StatelessWidget {
  static const String id = expenseTrackerBoxName;
  const ExpenseTrackerHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('ExpenseTrackerHome  >  build()');
    return FutureBuilder(
      // future: Hive.openBox<Transaction>(expenseTrackerBoxName),
      future: () {
          debugPrint('openBox() will be called for $expenseTrackerBoxName box');
          var box = Hive.openBox<Transaction>(expenseTrackerBoxName);
          box.then((_box) => debugPrint('Hive.openBox() returned and isOpen() > ${_box.isOpen}'));
          return box;
        }.call(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.error != null) {
            return const Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: Text('Something went wrong :/'),
              ),
            );
          } else {
            return const TransactionPage();
          }
        } else {
          return const Scaffold(
            body: Center(
              child: Text('Opening Hive...'),
            ),
          );
        }
      },
    );
  }
}

// Future main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   await Hive.initFlutter();
//
//   Hive.registerAdapter(TransactionAdapter());
//
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   static const String title = 'Hive Expense App';
//
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) => MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: title,
//         theme: ThemeData(primarySwatch: Colors.indigo),
//         home: const TransactionPage(),
//       );
// }
