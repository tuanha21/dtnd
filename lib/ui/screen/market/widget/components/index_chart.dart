import 'dart:ui';

import 'package:dtnd/=models=/index.dart';
import 'package:dtnd/=models=/response/index_model.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/i_local_storage_service.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/home/widget/home_market_today.dart';
import 'package:dtnd/ui/screen/market/market_controller.dart';
import 'package:dtnd/ui/screen/market/widget/components/index_item.dart';
import 'package:dtnd/ui/screen/stock_detail/widget/k_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../data/implementations/data_center_service.dart';
import '../../../../../data/implementations/local_storage_service.dart';
import '../../../../../data/implementations/user_service.dart';

class IndexChart extends StatefulWidget {
  const IndexChart({super.key});

  @override
  State<IndexChart> createState() => _IndexChartState();
}

class _IndexChartState extends State<IndexChart> {
  final IDataCenterService dataCenterService = DataCenterService();
  final ILocalStorageService localStorageService = LocalStorageService();
  final IUserService userService = UserService();
  final MarketController marketController = MarketController();

  IndexModel? selectedIndex;

  @override
  void initState() {
    super.initState();
  }

  void changeIndex(Index index) {
    marketController.changeSelectedIndex(index);
    setState(() {
      selectedIndex = marketController.currentIndexModel.value;
    });
    print(selectedIndex!.index.exchangeName);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox.fromSize(
            size: Size(MediaQuery.of(context).size.width, 250),
            child: Obx(() {
              if (marketController
                      .currentIndexModel.value?.stockDayTradingHistory.value ==
                  null) {
                return Center(
                  child: Text(S.of(context).loading),
                );
              }
              return KChart(
                indexModel:
                    selectedIndex ?? marketController.currentIndexModel.value!,
                isLine: true,
              );
            }),
          ),
        ),
        ObxValue<Rx<bool>>((initialized) {
          if (!initialized.value) {
            return Center(
              child: Text(S.of(context).loading),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox.fromSize(
              size: Size(MediaQuery.of(context).size.width, 64),
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
                  itemCount: marketController.listIndexs.length,
                  itemBuilder: (context, index) =>
                      ObxValue<Rx<IndexModel?>>((currentIndexModel) {
                    return MarketIndexItem(
                      data: marketController.listIndexs.elementAt(index),
                      selectedIndex: currentIndexModel.value?.index,
                      onSelected: changeIndex,
                    );
                  }, marketController.currentIndexModel),
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                    width: 8,
                  ),
                ),
              ),
            ),
          );
        }, marketController.initialized),
      ],
    );
  }
}
