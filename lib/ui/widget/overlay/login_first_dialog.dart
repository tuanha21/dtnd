import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';

import 'app_dialog.dart';

class LoginFirstCatalog extends StatelessWidget {
  const LoginFirstCatalog({super.key});

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      icon: const Icon(Icons.warning_amber_rounded),
      title: Text(S.of(context).login_required),
      content: Text(S.of(context).login_to_continue),
      actions: [
        Flexible(
          child: InkWell(
              onTap: () => Navigator.of(context).pop(false),
              child: Container(
                alignment: Alignment.center,
                child: Text(S.of(context).cancel),
              )),
        ),
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
