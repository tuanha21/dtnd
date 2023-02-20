import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/widget/icon/sheet_header.dart';
import 'package:dtnd/utilities/new_order_message.dart';
import 'package:flutter/material.dart';

class StockOrderFailSheet extends StatelessWidget {
  const StockOrderFailSheet({
    super.key,
    required this.rc,
  });
  final int rc;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SheetHeader(
              title: "",
              implementBackButton: false,
              implementDivider: false,
            ),
            const SizedBox(height: 90),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox.square(
                  dimension: 200,
                  child: Image.asset(AppImages.illust06),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  S.of(context).create_order_failed,
                  style: textTheme.labelLarge,
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Text(
                    NewOrderMessage.getErrorMessage(context, rc),
                    textAlign: TextAlign.center,
                    // style: textTheme.labelLarge,
                  ),
                )
              ],
            ),
            const SizedBox(height: 90),
            Row(
              children: [
                Expanded(
                    child: TextButton(
                        onPressed: () {},
                        child: Text(S.of(context).create_new_order))),
              ],
            ),
            const SizedBox(height: 90),
          ],
        ),
      ),
    );
  }
}
