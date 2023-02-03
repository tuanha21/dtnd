import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StockDetailChart extends StatefulWidget {
  const StockDetailChart({
    super.key,
    required this.stockModel,
  });
  final StockModel stockModel;
  @override
  State<StockDetailChart> createState() => _StockDetailChartState();
}

class _StockDetailChartState extends State<StockDetailChart> {
  @override
  Widget build(BuildContext context) {
    if (widget.stockModel.indayTradingHistory.value?.c?.isEmpty ?? true) {
      return Container();
    }
    return _StockChart(
      datas: widget.stockModel.indayTradingHistory.value!.c!,
    );
  }
}

class _StockChart extends StatefulWidget {
  const _StockChart({
    required this.datas,
  });
  final List<num> datas;

  @override
  State<_StockChart> createState() => _StockChartState();
}

class _StockChartState extends State<_StockChart> {
  final LinearGradient gradient = const LinearGradient(
    colors: AppColors.chartArea,
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  late TrackballBehavior trackballBehavior;

  @override
  void initState() {
    trackballBehavior = TrackballBehavior(
        // Enables the trackball
        enable: true,
        lineColor: AppColors.primary_01,
        shouldAlwaysShow: true,
        activationMode: ActivationMode.singleTap,
        tooltipSettings: InteractiveTooltip(
            enable: true,
            color: AppColors.primary_03,
            textStyle: AppTextStyle.bodySmall_8
                .copyWith(color: AppColors.primary_01)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: NumericAxis(isVisible: false),
      primaryYAxis: NumericAxis(isVisible: false),
      plotAreaBorderWidth: 0,
      trackballBehavior: trackballBehavior,
      series: [
        SplineAreaSeries<num, int>(
          dataSource: widget.datas,
          xValueMapper: (datum, index) => index,
          yValueMapper: (datum, index) => datum,
          gradient: gradient,
          borderColor: AppColors.primary_01,
          borderWidth: 2,
        )
      ],
    );
  }
}
