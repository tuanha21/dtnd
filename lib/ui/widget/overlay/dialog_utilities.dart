import 'package:flutter/material.dart';

import 'error_dialog.dart';

class DialogUtilities {
  static Future<T?> showErrorDialog<T>({
    required BuildContext context,
    required String title,
    required String content,
  }) {
    return showDialog<T>(
      context: context,
      builder: (context) {
        return ErrorDialog(
          title: title,
          content: content,
        );
      },
    );
  }
}
