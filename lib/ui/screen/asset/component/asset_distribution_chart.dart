import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../config/service/app_services.dart';

class AssetDistributionChart extends StatefulWidget {
  const AssetDistributionChart({super.key, this.datas, this.total});
  final List<ChartData>? datas;
  final num? total;

  @override
  State<AssetDistributionChart> createState() => _AssetDistributionChartState();
}

class _AssetDistributionChartState extends State<AssetDistributionChart> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final ThemeMode themeMode = AppService.instance.themeMode.value;

    return Container(
      padding: const EdgeInsets.all(10),
      decoration:
           BoxDecoration(shape: BoxShape.circle, color: themeMode.isLight ? Colors.white : AppColors.text_black_1),
      child: AspectRatio(
        aspectRatio: 1.3,
        child: SfCircularChart(
            palette: const [
              AppColors.graph_1,
              AppColors.graph_2,
              AppColors.graph_3,
              AppColors.graph_4,
              AppColors.graph_5,
              AppColors.graph_6,
              AppColors.graph_7,
            ],
            // tooltipBehavior: TooltipBehavior(
            //     enable: true,
            //     color: AppColors.neutral_04,
            //     builder: (dynamic data, dynamic point, dynamic series,
            //         int pointIndex, int seriesIndex) {
            //       final String _value = UtilFormat.formatMoney(
            //           data.accountType == AccountType.MARGIN
            //               ? data.totalEquity
            //               : data.assets);
            //       final AccountType _key = data.accountType;
            //       return Container(
            //           padding: const EdgeInsets.all(10),
            //           decoration: const BoxDecoration(
            //               borderRadius: BorderRadius.all(Radius.circular(8))),
            //           child: Text(
            //             '${_key.name} : ${_value} đ',
            //             style: TextStyle(
            //               color: Colors.white,
            //               fontSize: 12,
            //             ),
            //           ));
            //     }),
            // legend: Legend(
            //     isVisible: true,
            //     // Templating the legend item
            //     position: LegendPosition.bottom,
            //     legendItemBuilder:
            //         (String name, dynamic series, dynamic point, int index) {
            //       return SizedBox(height: 20, width: 10, child: Text(name));
            //     }),
            annotations: <CircularChartAnnotation>[
              CircularChartAnnotation(
                height: "100%",
                width: "100%",
                widget: PhysicalModel(
                  shape: BoxShape.circle,
                  elevation: 10,
                  shadowColor: Colors.black,
                  color: Colors.white,
                  child: Center(
                      child: Text(
                    NumUtils.getMoneyWithPostfix(widget.total, context),
                    style: textTheme.bodyMedium!.copyWith(
                        color: AppColors.color_secondary,
                        fontWeight: FontWeight.w700),
                  )),
                ),
              ),
            ],
            series: <DoughnutSeries<ChartData, String>>[
              DoughnutSeries<ChartData, String>(
                dataSource: widget.datas,
                innerRadius: "75%%",
                radius: "100%",
                xValueMapper: (ChartData data, _) => data.label,
                yValueMapper: (ChartData data, _) => data.percent,
                dataLabelMapper: (ChartData data, _) =>
                    "${data.label}\n${data.percent.toStringAsFixed(2)}%",
                dataLabelSettings: DataLabelSettings(
                  isVisible: true,
                  // Positioning the data label
                  margin: const EdgeInsets.all(0),
                  textStyle: TextStyle(color: themeMode.isLight ? null :Colors.white),
                  labelPosition: ChartDataLabelPosition.outside,
                ),
              )
            ]),
      ),
    );
  }
}

class ChartData {
  final String label;
  final double percent;

  ChartData(
    this.label,
    this.percent,
  );
}
