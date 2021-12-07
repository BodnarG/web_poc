import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive/hive.dart';

import 'colored_path_adapter.dart';
import 'drawing_screen.dart';

void main() async {
  if (!kIsWeb) {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
  }

  Hive.registerAdapter(ColoredPathAdapter());

  runApp(const DrawApp());
}

class DrawApp extends StatelessWidget {
  const DrawApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hive Sketchpad',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'OpenSans',
      ),
      home: FutureBuilder(
        future: Hive.openBox('sketch'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.error != null) {
              print(snapshot.error);
              return const Scaffold(
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
      ),
    );
  }
}