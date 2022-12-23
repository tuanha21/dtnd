import 'dart:ui';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:dtnd/=models=/local/local_catalog.dart';
import 'package:dtnd/=models=/local/saved_catalog.dart';
import 'package:dtnd/=models=/response/deep_model.dart';
import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/i_local_storage_service.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/data/implementations/local_storage_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/home/widget/home_market_overview.dart';
import 'package:dtnd/ui/screen/market/market_controller.dart';
import 'package:dtnd/ui/screen/market/widget/components/deep_market_chart.dart';
import 'package:dtnd/ui/screen/stock_detail.dart/widget/k_chart.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/widget/overlay/app_dialog.dart';
import 'package:dtnd/ui/widget/section/section_with_title.dart';
import 'package:dtnd/ui/widget/slidable_action/catalog_slidable_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import '../../../../../=models=/response/index_model.dart';
import '../../../home/widget/home_market_today.dart';

class MarketOverviewTab extends StatefulWidget {
  const MarketOverviewTab({super.key});

  @override
  State<MarketOverviewTab> createState() => _MarketOverviewTabState();
}

class _MarketOverviewTabState extends State<MarketOverviewTab> {
  final IDataCenterService dataCenterService = DataCenterService();
  final ILocalStorageService localStorageService = LocalStorageService();
  final IUserService userService = UserService();
  final MarketController marketController = MarketController();

  late final List<StockModel> listCatalog;

  bool listCatalogInitialized = false;

  @override
  void initState() {
    super.initState();
    initListCatalog();
  }

  void initListCatalog() async {
    if (!userService.isLogin) {
      listCatalog = await dataCenterService
          .getStockModelsFromStockCodes(defaultListStock);
      setState(() {
        listCatalogInitialized = true;
      });
      return;
    }
    final SavedCatalog savedCatalog =
        await localStorageService.getSavedCatalog(userService.token!.user);
    final LocalCatalog localCatalog = savedCatalog.catalogs.first;
    listCatalog = await dataCenterService
        .getStockModelsFromStockCodes(localCatalog.stocks!);
    setState(() {
      listCatalogInitialized = true;
    });
  }

  List<charts.Series<DeepModel, String>> _generateData(List<DeepModel> datas) {
    datas.removeWhere((element) => element.tYPE == "Total");
    return [
      charts.Series<DeepModel, String>(
        id: "MarketDeep",
        data: datas,
        domainFn: (data, _) => data.tYPE,
        measureFn: (data, _) => data.sL,
        colorFn: (data, _) {
          if (data.tYPE == "0%") {
            return charts.ColorUtil.fromDartColor(AppColors.semantic_02);
          }
          if (_spaceTypeRegex.hasMatch(data.tYPE) ||
              _upTypeRegex.hasMatch(data.tYPE)) {
            return charts.ColorUtil.fromDartColor(AppColors.semantic_01);
          }
          return charts.ColorUtil.fromDartColor(AppColors.semantic_03);
        },
        labelAccessorFn: (data, _) => '${data.sL}',
        outsideLabelStyleAccessorFn: (data, _) {
          charts.Color textColor;
          final int size;
          if (data.sL > 100) {
            size = 10;
          } else {
            size = 12;
          }
          if (data.tYPE == "0%") {
            textColor = charts.ColorUtil.fromDartColor(AppColors.semantic_02);
          } else if (_spaceTypeRegex.hasMatch(data.tYPE) ||
              _upTypeRegex.hasMatch(data.tYPE)) {
            textColor = charts.ColorUtil.fromDartColor(AppColors.semantic_01);
          } else {
            textColor = charts.ColorUtil.fromDartColor(AppColors.semantic_03);
          }
          return charts.TextStyleSpec(
            fontSize: size,
            fontWeight: "600",
            color: textColor,
          );
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Obx(
          () {
            if (marketController
                    .currentIndexModel.value?.stockTradingHistory.value ==
                null) {
              return Container();
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox.fromSize(
                size: Size(MediaQuery.of(context).size.width, 250),
                child: KChart(
                  indexModel: marketController.currentIndexModel.value!,
                  isLine: true,
                ),
              ),
            );
          },
        ),
        ObxValue<Rx<bool>>((initialized) {
          print("rebuilt");
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
                    return HomeIndexItem(
                      data: marketController.listIndexs.elementAt(index),
                      selectedIndex: currentIndexModel.value?.index,
                      onSelected: marketController.changeSelectedIndex,
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
        ObxValue<Rx<bool>>((loading) {
          if (loading.value) {
            return Center(
              child: Text(S.of(context).loading),
            );
          }
          final _seriesList = _generateData(marketController.listDeepMarket);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: DeepMarketChart(_seriesList),
          );
        }, marketController.loadingDeepModel),
        SectionWithTitle(
          title: S.of(context).interested_catalog,
          child: Builder(
            builder: (context) {
              if (listCatalogInitialized) {
                return Column(
                  children: [
                    for (final StockModel data in listCatalog)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 6),
                        child: SizedBox(
                          height: 85,
                          child: Slidable(
                            endActionPane: ActionPane(
                              extentRatio: 0.3,
                              motion: const DrawerMotion(),
                              children: [
                                CatalogSlidableAction(
                                  onPressed: (context) {
                                    return _onAddingStock(data);
                                  },
                                  backgroundColor: AppColors.neutral_06,
                                  foregroundColor: AppColors.primary_01,
                                  icon: Icons.add_box_rounded,
                                  label: 'Thêm vào danh mục',
                                  padding: const EdgeInsets.all(8),
                                ),
                              ],
                            ),
                            child: HomeMarketOverviewItem(
                              data: data,
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              }
              return Center(
                child: Text(S.of(context).loading),
              );
            },
          ),
        ),
      ],
    );
  }

  void _onAddingStock(StockModel stockModel) async {
    if (!userService.isLogin) {
      await showDialog(
        context: context,
        builder: (context) {
          return AppDialog(
            icon: Icon(Icons.warning_amber_rounded),
            title: Text("Yêu cầu đăng nhập"),
            content: Text("Hãy đăng nhập để tiếp tục!"),
            actions: [Text("Huỷ"), Text("OK")],
          );
        },
      );
    }
  }
}

final RegExp _spaceTypeRegex = RegExp(r'^(\d)(?=-)-(\d%)$');
final RegExp _upTypeRegex = RegExp(r'^>=(\d%)$');
