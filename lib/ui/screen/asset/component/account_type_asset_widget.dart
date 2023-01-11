import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/asset/screen/base_asset/base_asset_screen.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';

class AccountTypeAssetWidget extends StatelessWidget {
  const AccountTypeAssetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          _StockType(
            label: S.of(context).base,
            value: "1.200.000.000 đ",
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const BaseAssetScreen(),
              ));
            },
          ),
          const SizedBox(width: 10),
          _StockType(
            label: S.of(context).derivative,
            value: "800.000.000đ",
          ),
          const SizedBox(width: 10),
          const _StockType(
            label: "CopyTrade",
            value: "800.000.000đ",
          ),
        ],
      ),
    );
  }
}

class _StockType extends StatelessWidget {
  const _StockType({
    Key? key,
    required this.label,
    required this.value,
    this.onTap,
  }) : super(key: key);
  final String label;
  final String value;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Material(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: Ink(
          height: 100,
          width: 188,
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    label,
                    style: textTheme.labelMedium!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Flexible(
                    child: Text(
                      value,
                      style: textTheme.labelLarge!
                          .copyWith(fontWeight: FontWeight.w700),
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "005C193380",
                      style: textTheme.labelSmall!
                          .copyWith(color: AppColors.neutral_03),
                    ),
                  ),
                  Text(
                    "+12%",
                    style: textTheme.labelMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.semantic_01),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
