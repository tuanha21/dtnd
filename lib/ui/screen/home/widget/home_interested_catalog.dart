import 'dart:ui';

import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/utilities/extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeInterestedCatalog extends StatefulWidget {
  const HomeInterestedCatalog({super.key});

  @override
  State<HomeInterestedCatalog> createState() => _HomeInterestedCatalogState();
}

class _HomeInterestedCatalogState extends State<HomeInterestedCatalog> {
  final IDataCenterService dataCenterService = DataCenterService();
  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: Size(MediaQuery.of(context).size.width, 72),
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          },
        ),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: dataCenterService.listInterestedStocks.length,
          itemBuilder: (context, index) => HomeInterestedCatalogItem(
            data: dataCenterService.listInterestedStocks[index],
          ),
          separatorBuilder: (BuildContext context, int index) => const SizedBox(
            width: 8,
          ),
        ),
      ),
    );
  }
}

class HomeInterestedCatalogItem extends StatelessWidget {
  const HomeInterestedCatalogItem({super.key, required this.data});
  final StockModel data;
  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: const Size(168, 72),
      child: ObxValue<Rx<ThemeMode>>(
        (themeMode) {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              color: themeMode.value.isLight
                  ? AppColors.neutral_06
                  : AppColors.neutral_01,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      data.stock.stockCode,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "${data.stockData?.lastPrice}",
                      style: AppTextStyle.labelMedium_12.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.semantic_01,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${data.stockData?.lastVolume}",
                      style: AppTextStyle.labelMedium_12.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.neutral_03,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: themeMode.value.isLight
                            ? AppColors.accent_light_01
                            : AppColors.accent_dark_01,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(2)),
                      ),
                      child: Text(
                        "${data.stockData?.ot}",
                        style: AppTextStyle.labelMedium_12.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.semantic_01,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        AppService.instance.themeMode,
      ),
    );
  }
}
