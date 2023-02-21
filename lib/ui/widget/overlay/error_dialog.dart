import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';

import 'app_dialog.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({super.key, required this.title, this.content});
  final String title;
  final String? content;
  @override
  Widget build(BuildContext context) {
    return AppDialog(
      icon: const Icon(Icons.warning_amber_rounded),
      title: Text(title),
      content: Text(content ?? "Đã có lỗi xảy ra"),
      actions: [
        Flexible(
          child: InkWell(
              onTap: () => Navigator.of(context).pop(true),
              child: Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  border: Border(
                    left: BorderSide(color: AppColors.neutral_05),
                  ),
                ),
                child: const Text("OK"),
              )),
        )
      ],
    );
  }
}
