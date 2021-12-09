import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:web_poc/poc_selector.dart';

import 'examples/drawer/colored_path_adapter.dart';
import 'examples/drawer/drawer_app.dart';
import 'examples/expense_tracker/expense_tracker_home.dart';
import 'examples/expense_tracker/model/transaction.dart';
import 'examples/favorite_books/favorite_books.dart';

void main() async {
  if (!kIsWeb) {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
  }

  Hive.registerAdapter(ColoredPathAdapter());
  Hive.registerAdapter(TransactionAdapter());

  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          fontFamily: 'OpenSans',
        ),
        initialRoute: PocSelector.id,
        home: const PocSelector(),
        routes: {
          PocSelector.id: (context) => const PocSelector(),
          FavoriteBooksHome.id: (context) => const FavoriteBooksHome(),
          DrawApp.id: (context) => const DrawApp(),
          // ContactsHome.id: (context) => const ContactsHome(),
          ExpenseTrackerHome.id: (context) => const ExpenseTrackerHome(),
        },);
  }
}
