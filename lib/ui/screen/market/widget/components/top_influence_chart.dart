import 'package:dtnd/=models=/response/top_influence_model.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/utilities/charts_util.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class TopInfluenceChart extends StatefulWidget {
  final Future<List<TopInfluenceModel>> topInfluenceList;

  const TopInfluenceChart({super.key, required this.topInfluenceList});

  @override
  State<TopInfluenceChart> createState() => _TopInfluenceChartState();
}

class _TopInfluenceChartState extends State<TopInfluenceChart> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text('Top ảnh hưởng đến INDEX',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700)),
        ),
        FutureBuilder<List<TopInfluenceModel>>(
            future: widget.topInfluenceList,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                  child: Text(S.of(context).loading),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                return SizedBox(
                  height: 300,
                  child: charts.BarChart(
                    [
                      charts.Series<TopInfluenceModel, String>(
                        id: 'Sales',
                        colorFn: (_, __) =>
                            charts.MaterialPalette.blue.shadeDefault,
                        domainFn: (TopInfluenceModel model, _) =>
                            model.stockCode,
                        measureFn: (TopInfluenceModel model, _) => model.point,
                        fillColorFn: (TopInfluenceModel model, _) =>
                            charts.ColorUtil.fromDartColor(model.point > 0
                                ? AppColors.semantic_01
                                : AppColors.semantic_03),
                        data: snapshot.data!,
                      )
                    ],
                    animate: true,
                    defaultRenderer: charts.BarRendererConfig(
                      // By default, bar renderer will draw rounded bars with a constant
                      // radius of 100.
                      // To not have any rounded corners, use [NoCornerStrategy]
                      // To change the radius of the bars, use [ConstCornerStrategy]
                      cornerStrategy: const charts.ConstCornerStrategy(2),
                    ),
                    domainAxis: const charts.OrdinalAxisSpec(
                      renderSpec: charts.SmallTickRendererSpec(
                        labelRotation: 270,
                        minimumPaddingBetweenLabelsPx: 0,
                        labelOffsetFromAxisPx: 35,
                      ),
                    ),
                  ),
                );
              }
              return const SizedBox();
            }),
      ],
    );
  }
}

class _TooltipData extends TooltipData {
  _TooltipData._internal();
  static final _TooltipData instance = _TooltipData._internal();
}
