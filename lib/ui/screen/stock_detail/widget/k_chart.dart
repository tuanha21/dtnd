import 'package:dtnd/=models=/response/index_model.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/utilities/logger.dart';
import 'package:flutter/material.dart';
import 'package:k_chart/flutter_k_chart.dart';

class KChart extends StatefulWidget {
  const KChart({
    super.key,
    required this.indexModel,
    this.isLine = false,
    this.showNowPrice = false,
    this.dateTimeFormat,
  });

  final IndexModel indexModel;
  final bool isLine;
  final bool showNowPrice;
  final List<String>? dateTimeFormat;

  @override
  State<KChart> createState() => _KChartState();
}

class _KChartState extends State<KChart> {
  final List<KLineEntity> datas = <KLineEntity>[];
  bool initializing = true;

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() {
    setState(() {
      initializing = true;
    });
    final List<num> list = [];
    for (int i = 0;
        i < widget.indexModel.stockTradingHistory.value!.t!.length;
        i++) {
      list.add(widget.indexModel.stockTradingHistory.value!.o![i].toDouble());
      datas.add(KLineEntity.fromCustom(
          open: widget.indexModel.stockTradingHistory.value!.o![i].toDouble(),
          close: widget.indexModel.stockTradingHistory.value!.c![i].toDouble(),
          time:
              widget.indexModel.stockTradingHistory.value!.t![i].toInt() * 1000,
          high: widget.indexModel.stockTradingHistory.value!.h![i].toDouble(),
          low: widget.indexModel.stockTradingHistory.value!.l![i].toDouble(),
          vol: widget.indexModel.stockTradingHistory.value!.v![i].toDouble()));
    }
    setState(() {
      initializing = false;
    });
  }

  @override
  void didUpdateWidget(covariant KChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.indexModel.index != widget.indexModel.index) {
      initData();
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = AppService.instance.themeMode.value;
    final bgColor = <Color>[
      Colors.transparent,
      Colors.transparent,
    ];
    return KChartWidget(
      datas,
      ChartStyle(),
      ChartColors(
          bgColor: bgColor,
          kLineColor: widget.indexModel.indexDetail.color,
          lineFillColor: Colors.transparent,
          volColor: AppColors.neutral_06,
          upColor: AppColors.semantic_01,
          dnColor: AppColors.semantic_03,
          nowPriceUpColor: AppColors.semantic_01,
          nowPriceDnColor: AppColors.semantic_03,
          hCrossColor: Colors.transparent,
          vCrossColor: Colors.transparent,
          crossTextColor: Colors.transparent,
          selectBorderColor: Colors.transparent,
          selectFillColor: Colors.transparent),
      showNowPrice: widget.showNowPrice,
      isTrendLine: false,
      isTapShowInfoDialog: true,
      isLine: true,
      secondaryState: SecondaryState.NONE,
      hideGrid: true,
      stockCode: widget.indexModel.index.name,
    );
  }
}