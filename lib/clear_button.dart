import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ClearButton extends StatelessWidget {
  const ClearButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WatchBoxBuilder(
      box: Hive.box('sketch'),
      builder: (context, box) {
        return IconButton(
          icon: const Icon(Icons.delete),
          onPressed: box.length == 0
              ? null
              : () {
            box.clear();
          },
        );
      },
    );
  }
}