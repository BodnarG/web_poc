import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

import 'expense_tracker_home.dart';
import 'model/transaction.dart';

class Boxes {
  // static Box<Transaction> getTransactions() => Hive.box<Transaction>(expenseTrackerBoxName);
  static Box<Transaction> getTransactions() {
    debugPrint('Boxes.getTransactions()  >  box() will be called');
    var box = Hive.box<Transaction>(expenseTrackerBoxName);
    debugPrint('Boxes.getTransactions()  >  box() returned with value');
    debugPrint('Boxes.getTransactions()  >  box.isOpen() >> ${box.isOpen}');
    return box;
  }
  static bool isOpen() => Hive.isBoxOpen(expenseTrackerBoxName);
}