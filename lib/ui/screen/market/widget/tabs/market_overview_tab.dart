import 'package:charts_flutter/flutter.dart' as charts;
import 'package:dtnd/=models=/response/deep_model.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/market/market_controller.dart';
import 'package:dtnd/ui/screen/market/widget/components/deep_market_chart.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MarketOverviewTab extends StatefulWidget {
  const MarketOverviewTab({super.key});

  @override
  State<MarketOverviewTab> createState() => _MarketOverviewTabState();
}

class _MarketOverviewTabState extends State<MarketOverviewTab> {
  final MarketController marketController = MarketController();
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
          charts.Color _textColor;
          final int _size = data.sL > 100 ? 10 : 12;
          if (data.tYPE == "0%") {
            _textColor = charts.ColorUtil.fromDartColor(AppColors.semantic_02);
          } else if (_spaceTypeRegex.hasMatch(data.tYPE) ||
              _upTypeRegex.hasMatch(data.tYPE)) {
            _textColor = charts.ColorUtil.fromDartColor(AppColors.semantic_01);
          } else {
            _textColor = charts.ColorUtil.fromDartColor(AppColors.semantic_03);
          }
          return charts.TextStyleSpec(
            fontSize: _size,
            fontWeight: "600",
            color: _textColor,
          );
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
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
      ],
    );
  }
}

final RegExp _spaceTypeRegex = RegExp(r'^(\d)(?=-)-(\d%)$');
final RegExp _upTypeRegex = RegExp(r'^>=(\d%)$');
