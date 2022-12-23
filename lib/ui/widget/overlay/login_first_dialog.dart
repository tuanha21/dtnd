import 'package:dtnd/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'app_dialog.dart';

class LoginFirstCatalog extends StatelessWidget {
  const LoginFirstCatalog({super.key});

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      icon: Icon(Icons.warning_amber_rounded),
      title: Text("Yêu cầu đăng nhập"),
      content: Text("Hãy đăng nhập để tiếp tục!"),
      actions: [
        InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: Text(S.of(context).cancel)),
        Text("OK")
      ],
    );
  }
  
}
