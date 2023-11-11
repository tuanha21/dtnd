import 'package:dtnd/ui/widget/icon/sheet_header.dart';
import 'package:flutter/material.dart';

import '../../../../../l10n/generated/l10n.dart';

class VABotListSheet extends StatelessWidget {
  const VABotListSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SheetHeader(
              title: S.of(context).Bot_list,
              implementBackButton: true,
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
