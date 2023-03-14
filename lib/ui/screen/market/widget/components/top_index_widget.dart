import 'dart:math';

import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/utilities/logger.dart';
import 'package:dtnd/utilities/time_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../=models=/response/indContrib.dart';
import '../../../../../generated/l10n.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'package:charts_flutter/src/text_element.dart' as chart_text;
import 'package:charts_flutter/src/text_style.dart' as chart_style;
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
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 32),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Text(
                'Top ngành ảnh hưởng đến INDEX',
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
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: AppColors.light_bg,
                          borderRadius: BorderRadius.circular(8)),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                          'Biểu đồ thể hiện đóng góp của ngành vào INDEX. Dữ liệu ngày ${TimeUtilities.parseDateToString(DateTime.now())}',
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
                list.sort((a, b) {
                  num numA = a['contribPoint'];
                  num numB = b['contribPoint'];
                  return numB.compareTo(numA);
                });
                return SizedBox(
                  height: 300,
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
                          data: list,
                        )
                      ],
                      animate: true,
                      domainAxis: const charts.OrdinalAxisSpec(
                        renderSpec: charts.SmallTickRendererSpec(
                            labelRotation: 45,
                            minimumPaddingBetweenLabelsPx: 0,
                            labelStyle: charts.TextStyleSpec(fontSize: 7),
                            lineStyle: charts.LineStyleSpec()),
                      ),
                      behaviors: [
                        charts.SelectNearest(
                            eventTrigger: charts.SelectionTrigger.tapAndDrag),
                        charts.LinePointHighlighter(
                            showHorizontalFollowLine:
                                charts.LinePointHighlighterFollowLineType.none,
                            showVerticalFollowLine: charts
                                .LinePointHighlighterFollowLineType.nearest),
                        charts.LinePointHighlighter(
                          symbolRenderer: _CustomTooltipRenderer(
                              _TooltipData.instance,
                              size: size),
                        ),
                      ],
                      selectionModels: [
                        charts.SelectionModelConfig(
                          updatedListener: (charts.SelectionModel model) {
                            if (model.hasDatumSelection) {
                              final selectedDatum = model.selectedDatum;
                              // logger.v(selectedDatum.first.datum.name);
                              final List<String> listData = [
                                "${selectedDatum.first.datum['name']}",
                                "Đóng góp vào Index: ${selectedDatum.first.datum['contribPoint'].toStringAsFixed(2)} (${selectedDatum.first.datum['value'].toStringAsFixed(2)}%)"
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

class _CustomTooltipRenderer extends charts.CircleSymbolRenderer {
  final Size size;
  final _TooltipData data;
  _CustomTooltipRenderer(this.data, {required this.size});

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
    final listElement = data.listData ?? [];
    int maxLenght = 0;
    for (String element in listElement) {
      if (element.length > maxLenght) {
        maxLenght = element.length;
      }
    }

    canvas.drawRect(
      Rectangle(
          bounds.left - bounds.width - 30,
          bounds.height - 10,
          bounds.width + (maxLenght * 4),
          bounds.height + (13 * listElement.length)),
      fill: charts.Color.fromOther(
          color: const charts.Color(a: 100, b: 0, g: 0, r: 0).darker),
    );

    chart_style.TextStyle textStyle = chart_style.TextStyle();

    textStyle.color = charts.Color.white;
    textStyle.fontSize = 8;
    for (var i = 0; i < listElement.length; i++) {
      canvas.drawText(
        chart_text.TextElement(listElement.elementAt(i), style: textStyle),
        (bounds.left - bounds.width - 25).round(),
        getHeight(i).round(),
      );
    }
  }

  int getHeight(int index) {
    return index * 8 + (index + 1) * 5;
  }
}

class _TooltipData {
  _TooltipData._intern();
  static final _TooltipData instance = _TooltipData._intern();
  List<String>? listData;

  void setData(List<String>? listData) {
    this.listData = listData;
  }
}
