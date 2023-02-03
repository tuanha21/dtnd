import 'dart:ui';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:dtnd/=models=/response/deep_model.dart';
import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/i_local_storage_service.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/data/implementations/local_storage_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/market/market_controller.dart';
import 'package:dtnd/ui/screen/market/widget/components/deep_market_chart.dart';
import 'package:dtnd/ui/screen/market/widget/components/index_chart.dart';
import 'package:dtnd/ui/screen/market/widget/components/not_signin_catalog_widget.dart';
import 'package:dtnd/ui/screen/market/widget/components/user_catalog_widget.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/widget/section/section_with_title.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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


  @override
  void initState() {
    super.initState();
  }

  void rebuild() {
    return setState(() {});
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
    Widget catalog;
    if (!userService.isLogin) {
      catalog = NotSigninCatalogWidget(
        afterLogin: rebuild,
      );
    } else {
      catalog = const UserCatalogWidget();
    }
    return ListView(
      children: [
        const IndexChart(),
        ObxValue<Rx<bool>>((loading) {
          if (loading.value) {
            return Center(
              child: Text(S.of(context).loading),
            );
          }
          final seriesList = _generateData(marketController.listDeepMarket);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: DeepMarketChart(seriesList),
          );
        }, marketController.loadingDeepModel),
        SectionWithTitle(
          title: S.of(context).interested_catalog,
          onMore: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: catalog,
          ),
        ),
        const SizedBox(height: 100),
      ],
    );
  }
}

final RegExp _spaceTypeRegex = RegExp(r'^(\d)(?=-)-(\d%)$');
final RegExp _upTypeRegex = RegExp(r'^>=(\d%)$');