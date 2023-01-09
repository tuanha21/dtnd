import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/widget/button/text_icon_button.dart';
import 'package:flutter/material.dart';

class TotalAssetWidget extends StatelessWidget {
  const TotalAssetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: Colors.white,
      ),
      height: 124,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "200.000.000đ",
                style:
                    textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppImages.prefix_up_icon,
                    width: 10,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "2,108.63 (0.92%)",
                    style: textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.semantic_01),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TextIconButton(
                  icon: AppImages.money_recive,
                  label: S.of(context).deposite_money,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextIconButton(
                  icon: AppImages.money_send,
                  label: S.of(context).withdraw_money,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
