import 'package:dtnd/=models=/index.dart';
import 'package:dtnd/=models=/response/liquidity_model.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class LiquidityChart extends StatefulWidget {
  const LiquidityChart({super.key});

  @override
  State<LiquidityChart> createState() => _LiquidityChartState();
}

class _LiquidityChartState extends State<LiquidityChart> {
  final IDataCenterService dataCenterService = DataCenterService();
  late final LiquidityModel liquidityModel;
  late List<charts.Series<num, String>> seriesList;
  bool initialized = false;
  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() async {
    liquidityModel = await dataCenterService.getLiquidity(Index.VNI);
    seriesList = [
      charts.Series<num, String>(
        id: 'Hiện tại',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(AppColors.graph_2),
        domainFn: (num val, index) => (index ?? 0).toString(),
        measureFn: (num val, _) => val,
        data: liquidityModel.currVal,
      ),
      charts.Series<num, String>(
        id: 'Phiên trước',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(AppColors.graph_1),
        domainFn: (num val, index) => (index ?? 0).toString(),
        measureFn: (num val, _) => val,
        data: liquidityModel.prevVal,
      )..setAttribute(charts.rendererIdKey, 'customLine'),
      charts.Series<num, String>(
        id: '1 tuần',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(AppColors.graph_5),
        domainFn: (num val, index) => (index ?? 0).toString(),
        measureFn: (num val, _) => val,
        data: liquidityModel.week1Val,
      )..setAttribute(charts.rendererIdKey, 'customLine'),
      charts.Series<num, String>(
        id: '2 tuần',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(AppColors.graph_4),
        domainFn: (num val, index) => (index ?? 0).toString(),
        measureFn: (num val, _) => val,
        data: liquidityModel.week2Val,
      )..setAttribute(charts.rendererIdKey, 'customLine'),
      charts.Series<num, String>(
        id: '1 tháng',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(AppColors.graph_3),
        domainFn: (num val, index) => (index ?? 0).toString(),
        measureFn: (num val, _) => val,
        data: liquidityModel.monthVal,
      )..setAttribute(charts.rendererIdKey, 'customLine'),
    ];
    setState(() {
      initialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (!initialized) {
      child = Center(
        child: Text(S.of(context).loading),
      );
    } else {
      child = charts.OrdinalComboChart(
        seriesList,
        animate: true,
        defaultRenderer: charts.BarRendererConfig(
          groupingType: charts.BarGroupingType.grouped,
          // By default, bar renderer will draw rounded bars with a constant
          // radius of 100.
          // To not have any rounded corners, use [NoCornerStrategy]
          // To change the radius of the bars, use [ConstCornerStrategy]
          cornerStrategy: const charts.ConstCornerStrategy(2),
        ),
        customSeriesRenderers: [
          charts.LineRendererConfig(customRendererId: 'customLine'),
          // charts.LineRendererConfig(
          //     customRendererId: 'week1Val'),
          // charts.LineRendererConfig(
          //     customRendererId: 'week2Val'),
          // charts.LineRendererConfig(
          //     customRendererId: 'monthVal'),
        ],
        behaviors: [
          charts.SeriesLegend(
            // Positions for "start" and "end" will be left and right respectively
            // for widgets with a build context that has directionality ltr.
            // For rtl, "start" and "end" will be right and left respectively.
            // Since this example has directionality of ltr, the legend is
            // positioned on the right side of the chart.
            position: charts.BehaviorPosition.bottom,
            // For a legend that is positioned on the left or right of the chart,
            // setting the justification for [endDrawArea] is aligned to the
            // bottom of the chart draw area.
            outsideJustification: charts.OutsideJustification.middleDrawArea,
            // By default, if the position of the chart is on the left or right of
            // the chart, [horizontalFirst] is set to false. This means that the
            // legend entries will grow as new rows first instead of a new column.
            horizontalFirst: false,
            // By setting this value to 2, the legend entries will grow up to two
            // rows before adding a new column.
            desiredMaxRows: 2,
            // This defines the padding around each legend entry.
            cellPadding:
                const EdgeInsets.symmetric(horizontal: 4, vertical: 4.0),
            // Render the legend entry text with custom styles.
            // entryTextStyle: const charts.TextStyleSpec(
            //     color: charts.Color(r: 127, g: 63, b: 191),
            //     fontFamily: 'Georgia',
            //     fontSize: 11),
          )
        ],
        // secondaryMeasureAxis: charts.NumericAxisSpec(
        //     tickProviderSpec:
        //         charts.BasicNumericTickProviderSpec(desiredTickCount: 10)),
        domainAxis: const charts.OrdinalAxisSpec(
          renderSpec: charts.SmallTickRendererSpec(
            labelRotation: 270,
            labelOffsetFromAxisPx: 20,
            minimumPaddingBetweenLabelsPx: 20,
          ),
        ),
      );
    }

    return SizedBox(
      height: 300,
      child: child,
    );
  }
}
