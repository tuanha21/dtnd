import 'dart:math';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_flutter/src/text_element.dart' as chart_text;
import 'package:charts_flutter/src/text_style.dart' as chart_style;
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/utilities/charts_util.dart';
import 'package:dtnd/utilities/time_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../=models=/response/market/ind_contrib.dart';
import '../../../../../config/service/app_services.dart';
import '../../../../../l10n/generated/l10n.dart';
import '../../../../theme/app_color.dart';

class TopIndexWidgetChart extends StatefulWidget {
  final Future<IndContrib> topIndex;

  const TopIndexWidgetChart({Key? key, required this.topIndex})
      : super(key: key);

  @override
  State<TopIndexWidgetChart> createState() => _TopIndexWidgetChartState();
}

class _TopIndexWidgetChartState extends State<TopIndexWidgetChart> {
  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    final themeMode = AppService.instance.themeMode.value;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 32),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Text(
                S.of(context).top_industry_affecting_INDEX,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium
                    ?.copyWith(fontWeight: FontWeight.w700, fontSize: 14),
              ),
              const SizedBox(
                width: 4,
              ),
              GestureDetector(
                onTap: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => Dialog(
                    backgroundColor: themeMode.isLight
                        ? AppColors.light_bg
                        : AppColors.neutral_01,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: themeMode.isLight
                              ? AppColors.light_bg
                              : AppColors.neutral_01,
                          borderRadius: BorderRadius.circular(8)),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                          '${S.of(context).the_chart_show} ${TimeUtilities.parseDateToString(DateTime.now())}',
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.w400, fontSize: 14)),
                    ),
                  ),
                ),
                child: SvgPicture.asset(
                  AppImages.infoCircle,
                ),
              )
            ],
          ),
        ),
        FutureBuilder<IndContrib>(
            future: widget.topIndex,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                  child: Text(S.of(context).loading),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data == null) return const SizedBox();
                var list = snapshot.data!.listMapValue;
                list
                  ..removeWhere(
                      (element) => element['contribPoint'].abs() < 0.01)
                  ..sort((a, b) {
                    num numA = a['contribPoint'];
                    num numB = b['contribPoint'];
                    return numB.compareTo(numA);
                  });
                return SizedBox(
                  height: list.length * 30,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: charts.BarChart(
                      [
                        charts.Series<Map<String, dynamic>, String>(
                          id: 'Sales',
                          colorFn: (_, __) =>
                              charts.MaterialPalette.blue.shadeDefault,
                          domainFn: (Map<String, dynamic> model, _) =>
                              model['name'],
                          measureFn: (Map<String, dynamic> model, _) =>
                              model['contribPoint'],
                          fillColorFn: (Map<String, dynamic> model, _) =>
                              charts.ColorUtil.fromDartColor(
                                  model['contribPoint'] > 0
                                      ? AppColors.semantic_01
                                      : AppColors.semantic_03),
                          labelAccessorFn: (Map<String, dynamic> model, _) =>
                              "${model['contribPoint'].toStringAsFixed(2)}",
                          data: list,
                          // seriesColor: charts.ColorUtil.fromDartColor(AppColors.yellow),
                        )..setAttribute(
                            charts.measureAxisIdKey, "secondaryMeasureAxisId")
                      ],
                      animate: true,
                      vertical: false,
                      primaryMeasureAxis: const charts.NumericAxisSpec(
                          showAxisLine: false,
                          renderSpec: charts.NoneRenderSpec()),
                      // secondaryMeasureAxis: const charts.NumericAxisSpec(
                      //     showAxisLine: false,
                      //     renderSpec: charts.NoneRenderSpec()),
                      domainAxis: charts.OrdinalAxisSpec(
                        showAxisLine: false,
                        renderSpec: charts.SmallTickRendererSpec(
                          // labelRotation: 45,
                          minimumPaddingBetweenLabelsPx: 0,
                          labelStyle: charts.TextStyleSpec(
                            fontSize: 10,
                            color: themeMode.isLight
                                ? null
                                : charts.ColorUtil.fromDartColor(
                                    AppColors.neutral_07),
                          ),
                          lineStyle: charts.LineStyleSpec(
                            color: themeMode.isLight
                                ? null
                                : charts.ColorUtil.fromDartColor(
                                    AppColors.neutral_02),
                          ),
                        ),
                      ),
                      secondaryMeasureAxis: charts.NumericAxisSpec(
                        renderSpec: charts.GridlineRendererSpec(
                          labelStyle: charts.TextStyleSpec(
                              color: themeMode.isLight
                                  ? null
                                  : charts.ColorUtil.fromDartColor(
                                      AppColors.neutral_07)),
                          lineStyle: charts.LineStyleSpec(
                            color: themeMode.isLight
                                ? null
                                : charts.ColorUtil.fromDartColor(
                                    AppColors.neutral_02),
                          ),
                        ),
                      ),
                      barRendererDecorator: charts.BarLabelDecorator<String>(),
                      behaviors: [
                        charts.SelectNearest(
                            eventTrigger: charts.SelectionTrigger.tapAndDrag),
                        // charts.LinePointHighlighter(
                        //     showHorizontalFollowLine:
                        //         charts.LinePointHighlighterFollowLineType.nearest,
                        //     showVerticalFollowLine: charts
                        //         .LinePointHighlighterFollowLineType.none),
                        // charts.LinePointHighlighter(
                        //   symbolRenderer: CustomTooltipRenderer(
                        //       _TooltipData.instance,
                        //       size: size),
                        // ),
                      ],
                      selectionModels: [
                        charts.SelectionModelConfig(
                          updatedListener: (charts.SelectionModel model) {
                            if (model.hasDatumSelection) {
                              final selectedDatum = model.selectedDatum;
                              // logger.v(selectedDatum.first.datum.name);
                              final List<String> listData = [
                                "${selectedDatum.first.datum['name']}",
                                "Đóng góp vào Index: ${selectedDatum.first.datum['contribPoint'].toStringAsFixed(2)} điểm (${selectedDatum.first.datum['value'].toStringAsFixed(2)}%)"
                              ];
                              _TooltipData.instance.setData(listData);
                            }
                          },
                        ),
                      ],
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

class _CustomTooltipRenderer<T extends TooltipData>
    extends charts.CircleSymbolRenderer {
  final Size size;
  final T data;
  final int fontSize;

  _CustomTooltipRenderer(
    this.data, {
    required this.size,
    this.fontSize = 10,
  });

  @override
  void paint(charts.ChartCanvas canvas, Rectangle<num> bounds,
      {List<int>? dashPattern,
      charts.Color? fillColor,
      charts.FillPatternType? fillPattern,
      charts.Color? strokeColor,
      double? strokeWidthPx}) {
    super.paint(canvas, bounds,
        dashPattern: dashPattern,
        fillColor: fillColor,
        strokeColor: strokeColor,
        strokeWidthPx: strokeWidthPx);

    chart_style.TextStyle textStyle = chart_style.TextStyle();

    textStyle.color = charts.Color.white;
    textStyle.fontSize = fontSize;
    final listTextElement = (data.listData ?? [])
        .map((e) => chart_text.TextElement(e, style: textStyle))
        .toList();
    Size maxSize = Size.zero;
    for (chart_text.TextElement element in listTextElement) {
      if ((element.textPainter?.size.width ?? 0) > maxSize.width) {
        maxSize = element.textPainter!.size;
      }
    }
    // print(bounds.bottom);
    // print(bounds.top);

    final rectWidth = maxSize.height + 10;
    num rectLeft = bounds.bottom - (rectWidth / 2);
    final rectRight = rectLeft + rectWidth;
    if (rectLeft < 0) {
      rectLeft = 0;
    } else if (rectRight > size.width) {
      rectLeft = size.width - rectWidth;
    }

    canvas.drawRect(
      // Rectangle(
      //   bounds.left,
      //   bounds.top,
      //   bounds.width,
      //   bounds.height,
      // ),
      Rectangle(
        bounds.left - rectWidth - 16,
        0,
        bounds.height + ((maxSize.height) * listTextElement.length),
        size.width / 3 * 2 - 56,
      ),
      fill: charts.ColorUtil.fromDartColor(AppColors.neutral_03),
    );
    for (var i = 0; i < listTextElement.length; i++) {
      canvas.drawText(
        listTextElement.elementAt(i),
        bounds.left.round() -
            ((maxSize.height) * listTextElement.length).round() +
            ((listTextElement.elementAt(i).textPainter?.size.height ?? 0) * i +
                    5)
                .round() -
            13,
        (size.width / 3 * 2 - 61).round(),
        rotation: 3 * pi / 2,
      );
    }
  }
}
