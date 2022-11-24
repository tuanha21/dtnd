import 'dart:ui';

import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/i_local_storage_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/data/implementations/local_storage_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/stock_detail.dart/stock_detail_screen.dart';
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
  final ILocalStorageService localStorageService = LocalStorageService();
  final IDataCenterService dataCenterService = DataCenterService();
  late final List<StockModel> interestedCatalog;
  bool initialized = false;

  @override
  void initState() {
    super.initState();
    getListInterestedStocks();
  }

  Future<void> getListInterestedStocks() async {
    interestedCatalog = await dataCenterService.getStockModelsFromStockCodes(
        localStorageService.getListInterestedStock() ?? defaultListStock);
    setState(() {
      initialized = true;
    });
  }

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
        child: Builder(builder: (context) {
          if (!initialized) {
            return Center(
              child: Text(S.of(context).loading),
            );
          }
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: interestedCatalog.length,
            itemBuilder: (context, index) => HomeInterestedCatalogItem(
              data: interestedCatalog[index],
            ),
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(
              width: 8,
            ),
          );
        }),
      ),
    );
  }
}

class HomeInterestedCatalogItem extends StatelessWidget {
  const HomeInterestedCatalogItem({super.key, required this.data});
  final StockModel data;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => StockDetailScreen(stockModel: data),
      )),
      child: SizedBox.fromSize(
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
                        "${data.stockData.lastPrice}",
                        style: AppTextStyle.labelMedium_12.copyWith(
                          fontWeight: FontWeight.w600,
                          color: data.stockData.color,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${data.stockData.lastVolume}",
                        style: AppTextStyle.labelMedium_12.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.neutral_03,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          color: data.stockData.bgColor(themeMode.value),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(2)),
                        ),
                        child: Text(
                          "${data.stockData.prefix} ${data.stockData.ot}",
                          style: AppTextStyle.labelMedium_12.copyWith(
                            fontWeight: FontWeight.w600,
                            color: data.stockData.color,
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
      ),
    );
  }
}
