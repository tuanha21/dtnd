// ignore_for_file: library_private_types_in_public_api

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:dtnd/=models=/response/deep_model.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';

class DeepMarketChart extends StatefulWidget {
  final List<charts.Series<DeepModel, String>> seriesList;
  const DeepMarketChart(this.seriesList, {super.key});
  @override
  _DeepMarketChartState createState() => _DeepMarketChartState();
}

class _DeepMarketChartState extends State<DeepMarketChart> {
  int _total = 0;

  int _gain = 0;
  int _loss = 0;
  int _ref = 0;

  @override
  void initState() {
    super.initState();
    analyze();
  }

  void analyze() {
    int _sum = 0;
    for (var element in widget.seriesList.first.data) {
      _sum += element.sL;
      if (element.sortValue < 0) {
        _loss += element.sL;
      } else if (element.sortValue > 0) {
        _gain += element.sL;
      } else {
        _ref += element.sL;
      }
    }
    _total = _sum;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.seriesList == null || widget.seriesList.isEmpty) {
      return Container();
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(S.of(context).market_deep),
        const SizedBox(
          height: 5,
        ),
        Text(
          S.of(context).total_wvalue(_total),
          style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xffccccccc)),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: charts.BarChart(
                widget.seriesList,
                animate: true,
                primaryMeasureAxis: const charts.NumericAxisSpec(
                    renderSpec: charts.NoneRenderSpec()),
                domainAxis: charts.OrdinalAxisSpec(
                    renderSpec: charts.SmallTickRendererSpec(
                        // labelRotation: 45,

                        // Tick and Label styling here.
                        labelStyle: charts.TextStyleSpec(
                            fontSize: 7, // size in Pts.
                            color: charts.MaterialPalette.gray.shade500),

                        // Change the line colors to match text color.
                        lineStyle: const charts.LineStyleSpec(
                            color: charts.MaterialPalette.black))),
                barRendererDecorator: charts.BarLabelDecorator<String>(),
                defaultRenderer: charts.BarRendererConfig(
                    cornerStrategy: const charts.ConstCornerStrategy(5),
                    barRendererDecorator: charts.BarLabelDecorator(
                      labelPosition: charts.BarLabelPosition.outside,
                    )),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 5,
          child: Row(
            children: [
              buildQuantity(AppColors.semantic_03, _loss),
              const SizedBox(
                width: 5,
              ),
              buildQuantity(AppColors.semantic_02, _ref),
              const SizedBox(
                width: 5,
              ),
              buildQuantity(AppColors.semantic_01, _gain),
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Text(
              S.of(context).loss_wvalue(_loss),
              style:
                  const TextStyle(color: AppColors.semantic_03, fontSize: 10),
            ),
            const Spacer(),
            Text(
              S.of(context).gain_wvalue(_gain),
              style:
                  const TextStyle(color: AppColors.semantic_01, fontSize: 10),
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }

  Widget buildQuantity(Color color, int size) {
    if (size == null || size < 1) {
      return Container();
    } else {
      return Expanded(
        flex: size,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }
}
