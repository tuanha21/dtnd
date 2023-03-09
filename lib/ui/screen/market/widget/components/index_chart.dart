import 'dart:ui';

import 'package:dtnd/=models=/index.dart';
import 'package:dtnd/=models=/response/index_model.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/i_local_storage_service.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/market/market_controller.dart';
import 'package:dtnd/ui/screen/market/widget/components/index_item.dart';
import 'package:dtnd/ui/screen/stock_detail/widget/k_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../=models=/response/index_detail.dart';
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

  Future<List<IndexDetailResponse>> listIndexRes = Future.value([]);

  IndexModel? selectedIndex;

  @override
  void initState() {
    listIndexRes = dataCenterService.getListIndexDetail();
    super.initState();
  }

  void changeIndex(Index index) {
    marketController.changeSelectedIndex(index);
    setState(() {
      selectedIndex = marketController.currentIndexModel.value;
    });
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
                showNowPrice: true,
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
          return FutureBuilder<List<IndexDetailResponse>>(
              future: listIndexRes,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Text(S.of(context).loading),
                  );
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  var listRes = snapshot.data;
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
                              data:
                                  marketController.listIndexs.elementAt(index),
                              selectedIndex: currentIndexModel.value?.index,
                              onSelected: changeIndex,
                              res: listRes![index],
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
                }
                return const SizedBox();
              });
        }, marketController.initialized),
      ],
    );
  }
}
