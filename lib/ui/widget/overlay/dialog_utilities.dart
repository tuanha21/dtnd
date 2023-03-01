import 'package:flutter/material.dart';

import 'error_dialog.dart';
import 'material_dialog.dart';

class DialogUtilities {
  static Future<T?> showErrorDialog<T>({
    Key? key,
    required BuildContext context,
    required String title,
    required String content,
  }) {
    return showDialog<T>(
      context: context,
      builder: (context) {
        return ErrorDialog(
          key: key,
          title: title,
          content: content,
        );
      },
    );
  }

  static Future<T?> showMaterialDialog<T>({
    Key? key,
    required BuildContext context,
    required Widget header,
    required Widget content,
    required List<Widget> buttons,
  }) {
    return showDialog<T>(
      context: context,
      builder: (context) {
        return MaterialDialog(
          key: key,
          header: header,
          content: content,
          buttons: buttons,
        );
      },
    );
  }
}
