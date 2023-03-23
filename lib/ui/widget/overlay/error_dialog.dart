import 'package:dtnd/ui/widget/overlay/custom_dialog.dart';
import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({super.key, required this.title, this.content});

  final String title;
  final String? content;

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: title,
      content: content,
      action: () => Navigator.of(context).pop(true),
      textButtonAction: 'OK',
    );
  }
}
