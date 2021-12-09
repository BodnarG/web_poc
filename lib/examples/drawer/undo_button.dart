import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'drawer_app.dart';

class UndoButton extends StatelessWidget {
  const UndoButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box(drawAppBoxName).listenable(),
      builder: (BuildContext context, Box box, Widget? _) {
        return IconButton(
            icon: const Icon(Icons.undo),
            onPressed:
                box.length == 0 ? null : () => box.deleteAt(box.length - 1));
      },
    );
  }
}
