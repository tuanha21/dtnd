import 'package:dtnd/=models=/index.dart';
import 'package:dtnd/=models=/response/index_model.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/ui/screen/home/widget/home_market_today.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../=models=/response/index_detail.dart';

class MarketIndexItem extends StatelessWidget {
  const MarketIndexItem(
      {super.key,
      required this.data,
      this.selectedIndex,
      this.onSelected,
      required this.res});

  final IndexModel data;
  final Index? selectedIndex;
  final ValueChanged<Index>? onSelected;
  final IndexDetailResponse res;

  @override
  Widget build(BuildContext context) {
    final themeMode = AppService.instance.themeMode.value;
    BoxBorder? border;
    if (selectedIndex != null && data.index == selectedIndex) {
      border = Border.all(color: AppColors.neutral_03);
    }
    VoidCallback? onTap;
    if (onSelected != null) {
      onTap = () {
        print(data.index);
        onSelected?.call(data.index);
      };
    }
    return Obx(() {
      return Material(
        child: InkWell(
          onTap: onTap,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          child: Ink(
            width: 148,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: border,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              color: AppColors.neutral_07,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      data.index.exchangeName,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontWeight: FontWeight.w600),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      res.valueString,
                      style: AppTextStyle.labelMedium_12.copyWith(
                        fontWeight: FontWeight.w600,
                        color: data.indexDetail.color,
                      ),
                    ),
                    Text(
                      res.statusVN,
                      style: AppTextStyle.bodySmall_12.copyWith(
                        fontWeight: FontWeight.w400
                      ),
                    ),
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