import 'package:dtnd/l10n/generated/l10n.dart';
import 'package:dtnd/ui/screen/stock_detail/enum/price_alert_enum.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:flutter/material.dart';

class PriceAlert extends StatefulWidget {
  const PriceAlert({super.key});

  @override
  State<PriceAlert> createState() => _PriceAlertState();
}

class _PriceAlertState extends State<PriceAlert> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: const BoxDecoration(
          color: AppColors.neutral_07,
          borderRadius: BorderRadius.all(Radius.circular(12))),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: AppColors.accent_light_04,
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  AppImages.notification_icon,
                  scale: 4,
                ),
              ),
              const SizedBox(width: 10),
              Text(S.of(context).price_alert),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (final PriceAlertButton value in PriceAlertButton.values)
                Row(
                  children: [
                    Material(
                      child: InkWell(
                        onTap: () {},
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        child: Ink(
                          height: 32,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            color: AppColors.primary_01,
                          ),
                          child: Center(
                              child: Text(
                            value.name,
                            style: const TextStyle(color: AppColors.neutral_07),
                          )),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10)
                  ],
                ),
              Material(
                child: InkWell(
                  onTap: () {},
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  child: Ink(
                    height: 32,
                    width: 32,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: AppColors.neutral_05,
                    ),
                    child: Center(
                        child: Image.asset(
                      AppImages.tune_icon,
                    )),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
