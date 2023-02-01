import 'package:dtnd/=models=/response/index_board.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../../../../../generated/l10n.dart';
import '../../../../theme/app_color.dart';

class MoneyChart extends StatefulWidget {
  final double height;
  final Future<List<IndexBoard>> indexBoard;

  const MoneyChart({super.key, this.height = 150, required this.indexBoard});

  @override
  State<MoneyChart> createState() => _MoneyChartState();
}

class _MoneyChartState extends State<MoneyChart> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text('Dòng tiền',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700)),
        ),
        SizedBox(
          height: widget.height,
          width: MediaQuery.of(context).size.width,
          child: FutureBuilder<List<IndexBoard>>(
              future: widget.indexBoard,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    child: Text(S.of(context).loading),
                  );
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  var list = snapshot.data;
                  return Padding(
                    padding: const EdgeInsets.only(left: 0, right: 20),
                    child: charts.NumericComboChart(
                      List<charts.Series<IndexBoard, num>>.generate(
                          list!.length,
                          (index) => charts.Series<IndexBoard, num>(
                                id: 'chart1',
                                colorFn: (_, __) =>
                                    charts.ColorUtil.fromDartColor(
                                        AppColors.semantic_01),
                                domainFn: (IndexBoard indexBoard, int? index) =>
                                    index!,
                                measureFn: (IndexBoard sales, _) {
                                  return sales.totalBuyActivelyValues;
                                },
                                data: list,
                              )..setAttribute(charts.measureAxisIdKey,
                                  "secondaryMeasureAxisId")),
                      defaultRenderer: charts.LineRendererConfig(
                          includeArea: true, stacked: true),
                      domainAxis: domainSpec(list),
                      secondaryMeasureAxis: axisSpec(),
                    ),
                  );
                }
                return const SizedBox();
              }),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text('Độ rộng thị trường',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700)),
        ),
        const SizedBox(height: 5),
        SizedBox(
          height: widget.height,
          width: MediaQuery.of(context).size.width,
          child: FutureBuilder<List<IndexBoard>>(
              future: widget.indexBoard,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(
                    child: Text(S.of(context).loading),
                  );
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  var list = snapshot.data;
                  return Padding(
                    padding: const EdgeInsets.only(left: 0, right: 20),
                    child: charts.NumericComboChart(
                      _createSampleData(list!),
                      defaultRenderer: charts.LineRendererConfig(
                          includeArea: true, stacked: true),
                      animate: true,
                      secondaryMeasureAxis: const charts.NumericAxisSpec(
                        viewport: charts.NumericExtents(0, 100),
                        tickProviderSpec: charts.BasicNumericTickProviderSpec(
                          desiredTickCount: 5,
                          dataIsInWholeNumbers: true,
                          zeroBound: true
                        ),
                      ),
                      domainAxis: domainSpec(list),
                    ),
                  );
                }
                return const SizedBox();
              }),
        ),
      ],
    );
  }

  List<charts.Series<IndexBoard, num>> _createSampleData(
      List<IndexBoard> list) {
    return [
      charts.Series<IndexBoard, num>(
          id: 'Declines',
          // colorFn specifies that the line will be red.
          colorFn: (_, __) =>
              charts.ColorUtil.fromDartColor(AppColors.semantic_03),
          // areaColorFn specifies that the area skirt will be light red.
          areaColorFn: (_, __) =>
              charts.ColorUtil.fromDartColor(AppColors.semantic_03),
          domainFn: (IndexBoard sales, index) => index!,
          measureFn: (IndexBoard sales, _) {
            return sales.declines;
          },
          data: list)..setAttribute(charts.measureAxisIdKey,
          "secondaryMeasureAxisId"),
      charts.Series<IndexBoard, num>(
        id: 'NoChanges',
        // colorFn specifies that the line will be green.
        colorFn: (_, __) =>
            charts.ColorUtil.fromDartColor(AppColors.semantic_02),
        // areaColorFn specifies that the area skirt will be light green.
        areaColorFn: (_, __) =>
            charts.ColorUtil.fromDartColor(AppColors.semantic_02),
        domainFn: (IndexBoard sales, index) => index!,
        measureFn: (IndexBoard sales, _) => sales.noChanges,
        data: list,
      )..setAttribute(charts.measureAxisIdKey,
          "secondaryMeasureAxisId"),
      charts.Series<IndexBoard, num>(
        id: 'Advances',
        // colorFn specifies that the line will be blue.
        colorFn: (_, __) =>
            charts.ColorUtil.fromDartColor(AppColors.semantic_01),

        // areaColorFn specifies that the area skirt will be light blue.
        areaColorFn: (_, __) =>
            charts.ColorUtil.fromDartColor(AppColors.semantic_01),
        domainFn: (IndexBoard sales, index) => index!,
        measureFn: (IndexBoard sales, _) => sales.advances,
        data: list,
      )..setAttribute(charts.measureAxisIdKey,
          "secondaryMeasureAxisId"),
    ];
  }

  charts.NumericAxisSpec domainSpec(List<IndexBoard> list) {
    return charts.NumericAxisSpec(
        tickFormatterSpec: charts.BasicNumericTickFormatterSpec((index) {
          if (index! < list.length) {
            String formattedDate =
                DateFormat('HH:mm').format(list[index.toInt()].dateTime!);
            return formattedDate;
          }
          return "";
        }),
        renderSpec: const charts.GridlineRendererSpec(
            axisLineStyle: charts.LineStyleSpec(
              dashPattern: [4],
              thickness: 0,
              color: charts.Color(r: 74, g: 85, b: 104),
            ),
            labelStyle: charts.TextStyleSpec(fontSize: 9),
            lineStyle: charts.LineStyleSpec(dashPattern: [4])));
  }

  charts.NumericAxisSpec axisSpec() {
    return charts.NumericAxisSpec(
      showAxisLine: true,
      tickFormatterSpec: charts.BasicNumericTickFormatterSpec((measure) {
        if (measure! > 10000000 || measure < -10000000) {
          return "${NumUtils.formatInteger((measure / 1000000))}M";
        }
        if (measure > 10000 || measure < -10000) {
          return "${NumUtils.formatInteger((measure / 1000))}K";
        }
        return NumUtils.formatInteger(measure);
      }),
      tickProviderSpec: const charts.BasicNumericTickProviderSpec(
          dataIsInWholeNumbers: false, desiredTickCount: 4, zeroBound: false),
      renderSpec: const charts.GridlineRendererSpec(
          axisLineStyle: charts.LineStyleSpec(
            dashPattern: [4],
            thickness: 0,
            color: charts.Color(r: 74, g: 85, b: 104),
          ),
          labelStyle: charts.TextStyleSpec(fontSize: 9),
          lineStyle: charts.LineStyleSpec(dashPattern: [4])),
    );
  }
}
