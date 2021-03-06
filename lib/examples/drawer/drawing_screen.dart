import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:web_poc/examples/drawer/path_painter.dart';
import 'package:web_poc/examples/drawer/undo_button.dart';

import 'clear_button.dart';
import 'colored_path.dart';
import 'drawer_app.dart';
import 'drawing_area.dart';

class DrawingScreen extends StatefulWidget {
  const DrawingScreen({Key? key}) : super(key: key);

  @override
  _DrawingScreenState createState() => _DrawingScreenState();
}

class _DrawingScreenState extends State<DrawingScreen> {
  var selectedColorIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drawing screen'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              children: <Widget>[
                ValueListenableBuilder(
                  valueListenable: Hive.box(drawAppBoxName).listenable(),
                  builder: buildPathsFromBox,
                ),
                DrawingArea(selectedColorIndex),
              ],
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (var i = 0; i < ColoredPath.colors.length; i++)
                    buildColorCircle(i),
                  const ClearButton(),
                  const UndoButton(),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget buildPathsFromBox(BuildContext context, Box box, Widget? _) {
    var paths = box.values.whereType<ColoredPath>();
    return Stack(
      children: <Widget>[
        for (var path in paths)
          CustomPaint(
            size: Size.infinite,
            painter: PathPainter(path),
          ),
      ],
    );
  }

  Widget buildColorCircle(int colorIndex) {
    var selected = selectedColorIndex == colorIndex;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColorIndex = colorIndex;
        });
      },
      child: ClipOval(
        child: Container(
          padding: const EdgeInsets.only(bottom: 16.0),
          height: selected ? 50 : 36,
          width: selected ? 50 : 36,
          color: ColoredPath.colors[colorIndex],
        ),
      ),
    );
  }
}
