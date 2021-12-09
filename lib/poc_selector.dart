import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:web_poc/utils/utils.dart';

import 'examples/drawer/drawer_app.dart';
import 'examples/expense_tracker/expense_tracker_home.dart';
import 'examples/favorite_books/favorite_books.dart';

class PocSelector extends StatelessWidget {
  static const String id = 'PocSelector';

  const PocSelector({Key? key}) : super(key: key);

  static const List<String> listItems = [
    FavoriteBooksHome.id,
    DrawApp.id,
    ExpenseTrackerHome.id
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          TextButton(onPressed: () => Hive.close().then((value) => Utils.showSnackBar(
                  context: context,
                  text: 'The call for Hive.close() has ended'),
                  ),
              child: const Text('Close Hive Boxes', style: TextStyle(color: Colors.white),)),
          // IconButton(
          //     onPressed: () {
          //       debugPrint('Hive.deleteFromDisk() will be called');
          //       Hive.deleteFromDisk().then((_) {
          //         Utils.showSnackBar(
          //             context: context,
          //             text: 'The call for Hive.deleteFromDisk() has ended.');
          //         debugPrint('The call for Hive.deleteFromDisk() has ended.');
          //       });
          //     },
          //     icon: const Icon(Icons.delete),
          //     tooltip: 'Delete all Hive boxes'),
        ],
      ),
      body: getListView(),
    );
  }

  Widget getListView() {
    ListView listView = ListView.separated(
      // ListView listView = ListView.builder(
      itemCount: listItems.length,
      itemBuilder: (context, index) {
        return TextButton(
            onPressed: () {
              Navigator.pushNamed(context, listItems[index]);
            },
            onLongPress: () => Utils.showSnackBar(
                context: context,
                text: 'Is ${listItems[index]} box open >> ${Hive.isBoxOpen(listItems[index])}'),
            child: Text(listItems[index]));
      },
      separatorBuilder: (context, index) => const Divider(height: 20),
    );
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: listView,
    );
  }
}
