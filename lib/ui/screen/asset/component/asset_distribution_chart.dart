import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AssetDistributionChart extends StatelessWidget {
  const AssetDistributionChart({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
      child: AspectRatio(
        aspectRatio: 1.3,
        child: SfCircularChart(palette: const [
          AppColors.graph_1,
          AppColors.graph_2,
          AppColors.graph_3,
          AppColors.graph_4,
          AppColors.graph_5
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
                    "200Tr",
                    style: textTheme.bodyMedium!.copyWith(
                        color: AppColors.color_secondary,
                        fontWeight: FontWeight.w700),
                  )),
                ),
              ),
            ], series: <DoughnutSeries<_ChartData, String>>[
          DoughnutSeries<_ChartData, String>(
            dataSource: [
              _ChartData("Tiền", 70.28),
              _ChartData("Cổ phiếu", 17.38),
              _ChartData("Phái sinh", 17.38),
              _ChartData("Trái phiếu", 6.63),
            ],
            innerRadius: "75%%",
            radius: "100%",
            xValueMapper: (_ChartData data, _) => data.label,
            yValueMapper: (_ChartData data, _) => data.percent,
            dataLabelMapper: (_ChartData data, _) =>
                "${data.label}\n${data.percent}%",
            dataLabelSettings: const DataLabelSettings(
              isVisible: true,
              // Positioning the data label
              margin: EdgeInsets.all(0),
              labelPosition: ChartDataLabelPosition.outside,
            ),
          )
        ]),
      ),
    );
  }
}

class _ChartData {
  final String label;
  final double percent;

  _ChartData(
    this.label,
    this.percent,
  );
}
