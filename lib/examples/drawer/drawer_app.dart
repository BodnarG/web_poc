import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'drawing_screen.dart';

const drawAppBoxName = 'sketch';

class DrawApp extends StatelessWidget {
  static const String id = drawAppBoxName;

  const DrawApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('DrawApp  >  build()');

    return FutureBuilder(
      future: Hive.openBox(drawAppBoxName),
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
            return const DrawingScreen();
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
