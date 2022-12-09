import 'package:flutter/material.dart';

class ModelBottomSheet {
  static Future<T?> showBottomSheet<T>(
      {required BuildContext context,
      required List<Widget> children,
      bool isScrollControlled = false}) {
    return showModalBottomSheet<T>(
      isScrollControlled: isScrollControlled,
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (BuildContext context) {
        return Wrap(
          children: children,
        );
      },
    );
  }
}
