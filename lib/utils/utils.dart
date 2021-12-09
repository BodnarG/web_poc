import 'dart:ui';

import 'package:flutter/material.dart';

class Utils {
  static void showSnackBar({required BuildContext context, required String text, Color? bgColor}) =>
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
              content: Text(text),
              backgroundColor: bgColor,
              duration: const Duration(seconds: 2)),
        );
}
