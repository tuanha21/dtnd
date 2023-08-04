import 'package:dtnd/=models=/response/stock_trading_history.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:k_chart/chart_translations.dart';
import 'package:k_chart/flutter_k_chart.dart';

import '../../../../config/service/app_services.dart';

class KChart extends StatefulWidget {
  const KChart({
    super.key,
    required this.stockTradingHistory,
    this.isLine = false,
    this.showNowPrice = false,
    this.dateTimeFormat,
    this.translations,
    this.mainState,
    this.secondaryState,
    this.showMA = false,
    required this.code,
    required this.vol,
    this.color,
  });

  final String code;
  final StockTradingHistory stockTradingHistory;
  final double? vol;
  final Color? color;
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
    for (int i = 0; i < widget.stockTradingHistory.t.length; i++) {
      list.add(widget.stockTradingHistory.o[i].toDouble());
      datas.add(KLineEntity.fromCustom(
        open: widget.stockTradingHistory.o[i].toDouble(),
        close: widget.stockTradingHistory.c[i].toDouble(),
        time: widget.stockTradingHistory.t[i].toInt() * 1000,
        high: widget.stockTradingHistory.h[i].toDouble(),
        low: widget.stockTradingHistory.l[i].toDouble(),
        vol: widget.stockTradingHistory.v[i].toDouble(),
        // amount:
        //     widget.indexModel.stockDayTradingHistory.value!.v![i].toDouble(),
      ));
    }
    if (widget.showMA) {
      DataUtil.calculate(datas, const [5, 20]);
    }
    setState(() {
      initializing = false;
    });
  }

  @override
  void didUpdateWidget(covariant KChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.code != widget.code) {
      initData();
    }
    if (widget.stockTradingHistory.c.isNotEmpty &&
        datas.last.close != widget.stockTradingHistory.c.last) {
      datas.last.close = widget.stockTradingHistory.c.last.toDouble();
      // DataUtil.calculate(datas);
      if (widget.showMA) {
        DataUtil.calculate(datas, const [5, 20]);
      }
    }
    if (widget.stockTradingHistory.v.isNotEmpty &&
        datas.last.vol != widget.vol) {
      datas.last.vol = widget.vol ?? datas.last.vol;
      // DataUtil.calculate(datas);
      if (widget.showMA) {
        DataUtil.calculate(datas, const [5, 20]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeMode themeMode = AppService.instance.themeMode.value;

    final bgColor = <Color>[
      Colors.transparent,
      Colors.transparent,
    ];
    return KChartWidget(
      datas,
      ChartStyle(),
      ChartColors(
        bgColor: bgColor,
        kLineColor: widget.color ?? AppColors.semantic_02,
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
        minColor: themeMode.isLight ? Colors.black : Colors.white,
        maxColor: themeMode.isLight ? Colors.black : Colors.white,
      ),
      stockCode: widget.code,
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
      maDayList: const [5, 20],
    );
  }
}
