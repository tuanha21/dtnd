import 'package:flutter/material.dart';

import 'back_button.dart';
import 'close_button.dart';

class SheetHeader extends StatelessWidget {
  const SheetHeader({
    super.key,
    this.title,
    this.implementBackButton = true,
    this.implementDivider = true,
    this.backData,
  });
  final String? title;
  final bool implementBackButton;
  final bool implementDivider;
  final dynamic backData;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final titleTextStyle =
        textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700);
    return SizedBox(
      height: 52,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              implementBackButton
                  ? Row(
                      children: [
                        SheetBackButton(
                          onTap: backData,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          title ?? "",
                          style: titleTextStyle,
                        ),
                      ],
                    )
                  : Text(
                      title ?? "",
                      style: titleTextStyle,
                    ),
              const SheetCloseButton(),
            ],
          ),
          implementDivider
              ? const Divider(
                  thickness: 1,
                )
              : Container(),
        ],
      ),
    );
  }
}
