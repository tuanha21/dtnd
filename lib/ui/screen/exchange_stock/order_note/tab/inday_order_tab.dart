import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/exchange_stock/order_note/sheet/order_filter_flow.dart';
import 'package:dtnd/ui/screen/exchange_stock/order_note/sheet/order_filter_sheet.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:flutter/material.dart';

import '../component/inday_order_panel.dart';

class IndayOrderTab extends StatefulWidget {
  const IndayOrderTab({super.key});

  @override
  State<IndayOrderTab> createState() => _IndayOrderTabState();
}

class _IndayOrderTabState extends State<IndayOrderTab> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).order_type,
                style: textTheme.titleSmall,
              ),
              Material(
                borderRadius: const BorderRadius.all(Radius.circular(6)),
                child: InkWell(
                  onTap: () {
                    IOrderFilterISheet()
                        .show(context, const OrderFilterSheet());
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                  child: Ink(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: AppColors.primary_03,
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                    child: SizedBox.square(
                        dimension: 16,
                        child: Image.asset(AppImages.filter_icon)),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Expanded(child: IndayOrderPanel())
        ],
      ),
    );
  }
}
