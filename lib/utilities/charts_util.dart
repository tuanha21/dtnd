import 'dart:math';
import 'dart:ui';

import 'package:charts_flutter/flutter.dart' as charts;

import 'package:charts_flutter/src/text_element.dart' as chart_text;
import 'package:charts_flutter/src/text_style.dart' as chart_style;
import 'package:dtnd/ui/theme/app_color.dart';

class CustomTooltipRenderer<T extends TooltipData>
    extends charts.CircleSymbolRenderer {
  final Size size;
  final T data;
  final int fontSize;
  CustomTooltipRenderer(
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

    final rectWidth = maxSize.width + 10;
    num rectLeft = bounds.left - (rectWidth / 2);
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
        rectLeft,
        bounds.height - 8,
        rectWidth,
        bounds.height + ((maxSize.height) * listTextElement.length),
      ),
      fill: charts.ColorUtil.fromDartColor(AppColors.neutral_03),
    );
    for (var i = 0; i < listTextElement.length; i++) {
      canvas.drawText(
        listTextElement.elementAt(i),
        rectLeft.toInt() + 5,
        ((listTextElement.elementAt(i).textPainter?.size.height ?? 0) * i + 5)
            .round(),
      );
    }
  }
}

abstract class TooltipData {
  List<String>? listData;

  void setData(List<String>? listData) {
    this.listData = listData;
  }
}

class NumValue {
  final num value;
  const NumValue(this.value);
}
