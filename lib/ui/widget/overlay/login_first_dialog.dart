import 'package:dtnd/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'custom_dialog.dart';

class LoginFirstDialog extends StatelessWidget {
  const LoginFirstDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      textButtonAction: S.of(context).ok,
      textButtonExit: S.of(context).Later,
      title: S.of(context).login_required,
      content: S.of(context).login_to_continue,
      action: () => Navigator.of(context).pop(true),
      type: TypeAlert.notification,
    );
  }
}
