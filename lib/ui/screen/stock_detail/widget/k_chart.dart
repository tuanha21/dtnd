import 'package:dtnd/=models=/response/index_model.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:k_chart/chart_translations.dart';
import 'package:k_chart/flutter_k_chart.dart';

class KChart extends StatefulWidget {
  const KChart({
    super.key,
    required this.indexModel,
    this.isLine = false,
    this.showNowPrice = false,
    this.dateTimeFormat,
    this.translations,
    this.mainState,
    this.secondaryState,
    this.showMA = false,
  });

  final IndexModel indexModel;
  final bool isLine;
  final bool showMA;
  final bool showNowPrice;
  final List<String>? dateTimeFormat;
  final Map<String, ChartTranslations>? translations;
  final MainState? mainState;
  final SecondaryState? secondaryState;
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
        i < widget.indexModel.stockDayTradingHistory.value!.t!.length;
        i++) {
      list.add(
          widget.indexModel.stockDayTradingHistory.value!.o![i].toDouble());
      datas.add(KLineEntity.fromCustom(
          open:
              widget.indexModel.stockDayTradingHistory.value!.o![i].toDouble(),
          close:
              widget.indexModel.stockDayTradingHistory.value!.c![i].toDouble(),
          time: widget.indexModel.stockDayTradingHistory.value!.t![i].toInt() *
              1000,
          high:
              widget.indexModel.stockDayTradingHistory.value!.h![i].toDouble(),
          low: widget.indexModel.stockDayTradingHistory.value!.l![i].toDouble(),
          vol: widget.indexModel.stockDayTradingHistory.value!.v![i]
              .toDouble()));
    }
    if (widget.showMA) {
      DataUtil.calculate(datas);
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
    if (widget.indexModel.stockDayTradingHistory.value?.c?.last != null &&
        datas.last.close !=
            widget.indexModel.stockDayTradingHistory.value!.c!.last) {
      datas.last.close =
          widget.indexModel.stockDayTradingHistory.value!.c!.last.toDouble();
      // DataUtil.calculate(datas);
      if (widget.showMA) {
        DataUtil.calculate(datas);
      }
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
        lineFillColor: Colors.black,
        volColor: AppColors.neutral_06,
        upColor: AppColors.semantic_01,
        dnColor: AppColors.semantic_03,
        nowPriceUpColor: AppColors.semantic_01,
        nowPriceDnColor: AppColors.semantic_03,
        infoWindowNormalColor: Colors.black,
        infoWindowTitleColor: Colors.black,
        infoWindowDnColor: AppColors.semantic_03,
        infoWindowUpColor: AppColors.semantic_01,
        crossTextColor: Colors.black,
        hCrossColor: const Color(0xFF8894AA),
        vCrossColor: const Color(0x1E000000),
        defaultTextColor: const Color(0xFFA0AEC0),
        selectFillColor: AppColors.neutral_06,
        minColor: Colors.black,
        maxColor: Colors.black,
      ),
      stockCode: widget.indexModel.index.name,
      showNowPrice: widget.showNowPrice,
      fixedLength: 2,
      showInfoDialog: true,
      isTapShowInfoDialog: true,
      materialInfoDialog: true,
      verticalTextAlignment: VerticalTextAlignment.right,
      isTrendLine: false,
      isLine: false,
      mainState: widget.mainState ?? MainState.NONE,
      secondaryState: widget.secondaryState ?? SecondaryState.NONE,
      hideGrid: true,
      translations: widget.translations ?? kChartTranslations,
    );
  }
}
