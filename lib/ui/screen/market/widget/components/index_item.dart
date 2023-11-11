import 'package:dtnd/=models=/index.dart';
import 'package:dtnd/=models=/response/market/index_model.dart';
import 'package:dtnd/ui/screen/home/widget/home_market_today.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../=models=/response/market/index_detail.dart';
import '../../../../../config/service/app_services.dart';
import '../../../../../l10n/generated/l10n.dart';
import '../../../../theme/app_image.dart';

class MarketIndexItem extends StatelessWidget {
  const MarketIndexItem({
    super.key,
    required this.data,
    this.selectedIndex,
    this.onSelected,
  });

  final IndexModel data;
  final Index? selectedIndex;
  final ValueChanged<Index>? onSelected;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final themeMode = AppService.instance.themeMode.value;

    BoxBorder? border;
    if (selectedIndex != null && data.index == selectedIndex) {
      border = Border.all(color: AppColors.neutral_04);
    }
    VoidCallback? onTap;
    if (onSelected != null) {
      onTap = () {
        onSelected?.call(data.index);
      };
    }
    return Obx(() {
      return Material(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        color: themeData.colorScheme.background,
        child: InkWell(
          onTap: onTap,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          child: Ink(
            width: 148,
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: border,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              color: themeMode.isLight
                  ? AppColors.neutral_07
                  : AppColors.text_black_1,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      data.index.exchangeName,
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: themeMode.isLight
                              ? AppColors.bg_2
                              : AppColors.neutral_07),
                    ),
                    Builder(builder: (context) {
                      return SizedBox.square(
                        dimension: 20,
                        child: HomeIndexItemChart(data: [
                          data.indexDetail.upQuant.toInt(),
                          data.indexDetail.downQuant.toInt(),
                          data.indexDetail.refQuant.toInt(),
                        ]),
                      );
                    }),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${data.indexDetail.cIndex.value}",
                      style: AppTextStyle.labelMedium_12.copyWith(
                        fontWeight: FontWeight.w600,
                        color: data.indexDetail.color,
                      ),
                    ),
                    Text(
                      "${data.indexDetail.change} (${data.indexDetail.changePc})",
                      style: AppTextStyle.bodySmall_8.copyWith(
                        fontWeight: FontWeight.w600,
                        color: data.indexDetail.color,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() => SizedBox.square(
                          dimension: 12,
                          child: Image.asset(AppImages.home_icon_clock,
                              color: data.indexDetail.status.value.color),
                        )),
                    Obx(() {
                      return Text(
                        "${NumUtils.formatInteger(
                          (data.indexDetail.value.value ?? 0) ~/ 1000,
                        )} ${S.of(context).billion_lowercase}",
                        style: AppTextStyle.labelSmall_11.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.neutral_03,
                        ),
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
