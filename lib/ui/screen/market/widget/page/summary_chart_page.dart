import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../=models=/fake/summary_model.dart';
import '../../../../../l10n/generated/l10n.dart';
import '../../../../../utilities/num_utils.dart';
import '../../../../theme/app_color.dart';
import '../../../../theme/app_image.dart';

class SummaryChartPage extends StatefulWidget {
  const SummaryChartPage({Key? key, required this.data}) : super(key: key);
  final SummaryModel data;

  @override
  State<SummaryChartPage> createState() => _SummaryChartPageState();
}

class _SummaryChartPageState extends State<SummaryChartPage> {
  @override
  Widget build(BuildContext context) {
    List<TopBuyNetValue>? topBuyNetValues =
        widget.data.contentFull?.foreignRoomSummary?.topBuyNetValue;

    List<Map<String, dynamic>>? topBuyNetValuesMap =
        topBuyNetValues?.map((item) => item.toJson()).toList();

    List<TopSeLLNetValue>? topSeLLNetValues =
        widget.data.contentFull?.foreignRoomSummary?.topSeLLNetValue;

    List<Map<String, dynamic>>? topSeLLNetValuesMap =
        topSeLLNetValues?.map((item) => item.toJson()).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.app_bar_summary,
        centerTitle: true,
        title: const Text(
          'Market summary',
          style: TextStyle(fontSize: 17, color: AppColors.bg_1),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.chevron_left,
            color: AppColors.light_bg,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: InkWell(
                onTap: () {},
                borderRadius: const BorderRadius.all(Radius.circular(6)),
                child: const Icon(
                  Icons.share,
                  color: AppColors.bg_share_summary,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        height: double.infinity,
        color: AppColors.bg_2,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text(
                  widget.data.contentFull!.indexSummaries![0].summary
                      .toString(),
                  style: const TextStyle(color: AppColors.text_summary)),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text(
                        "Top giao dịch nước ngoài",
                        style: TextStyle(color: AppColors.bg_1, fontSize: 16),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      SvgPicture.asset(
                        AppImages.infoCircle,
                        color: AppColors.bg_1,
                        width: 15,
                        height: 15,
                      ),
                    ],
                  ),
                  const Text("Đơn vị: Tỷ đồng",
                      style: TextStyle(
                          color: AppColors.text_summary, fontSize: 10))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        size: 10,
                        color: AppColors.semantic_01,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Top mua ròng",
                          style: TextStyle(color: AppColors.text_summary)),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        size: 10,
                        color: AppColors.semantic_03,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Top bán ròng",
                          style: TextStyle(color: AppColors.text_summary))
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Flexible(
                    child: FutureBuilder<List<Map<String, dynamic>>>(
                      future: Future.value(topBuyNetValuesMap),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return SizedBox(
                            child: Text(S.of(context).loading),
                          );
                        }
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.data == null) return const SizedBox();
                          var list = topBuyNetValuesMap;
                          list?.sort(
                            (a, b) {
                              num? numA = a["value"];
                              num? numB = b["value"];
                              return numB!.compareTo(numA!);
                            },
                          );
                          return Directionality(
                            textDirection: TextDirection.rtl,
                            child: SizedBox(
                              height: list!.length * 30,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: charts.BarChart(
                                  [
                                    charts.Series<Map<String, dynamic>, String>(
                                      id: 'security',
                                      colorFn: (_, __) => charts
                                          .MaterialPalette.blue.shadeDefault,
                                      domainFn:
                                          (Map<String, dynamic> model, _) =>
                                              model['security'],
                                      measureFn:
                                          (Map<String, dynamic> model, _) =>
                                              model['value'],
                                      fillColorFn:
                                          (Map<String, dynamic> model, _) =>
                                              charts.ColorUtil.fromDartColor(
                                        model['value'] > 0
                                            ? AppColors.semantic_01
                                            : AppColors.semantic_03,
                                      ),
                                      labelAccessorFn: (Map<String, dynamic>
                                                  model,
                                              _) =>
                                          "${model['value'].toStringAsFixed(2)}",
                                      data: list,
                                    )
                                  ],
                                  animate: true,
                                  vertical: false,
                                  primaryMeasureAxis:
                                      const charts.NumericAxisSpec(
                                    showAxisLine: false,
                                    renderSpec: charts.NoneRenderSpec(),
                                  ),
                                  secondaryMeasureAxis:
                                      const charts.NumericAxisSpec(
                                    showAxisLine: false,
                                    renderSpec: charts.NoneRenderSpec(),
                                  ),
                                  domainAxis: const charts.OrdinalAxisSpec(
                                    showAxisLine: false,
                                    renderSpec: charts.SmallTickRendererSpec(
                                      minimumPaddingBetweenLabelsPx: 0,
                                      labelJustification:
                                          charts.TickLabelJustification.outside,
                                      labelStyle:
                                          charts.TextStyleSpec(fontSize: 10),
                                      lineStyle: charts.LineStyleSpec(),
                                    ),
                                  ),
                                  barRendererDecorator:
                                      charts.BarLabelDecorator<String>(
                                    labelPosition:
                                        charts.BarLabelPosition.outside,
                                    labelPadding: 4,
                                    insideLabelStyleSpec: charts.TextStyleSpec(
                                      fontSize: 10,
                                      color: charts.ColorUtil.fromDartColor(
                                          Colors.white),
                                    ),
                                    outsideLabelStyleSpec: charts.TextStyleSpec(
                                      fontSize: 10,
                                      color: charts.ColorUtil.fromDartColor(
                                        AppColors.semantic_01,
                                      ),
                                    ),
                                  ),
                                  behaviors: [
                                    charts.SelectNearest(
                                        eventTrigger:
                                            charts.SelectionTrigger.tapAndDrag),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                  Flexible(
                    child: FutureBuilder<List<Map<String, dynamic>>>(
                      future: Future.value(topSeLLNetValuesMap),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return SizedBox(
                            child: Text(S.of(context).loading),
                          );
                        }
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.data == null) return const SizedBox();
                          var list = topSeLLNetValuesMap;
                          list?.sort((a, b) {
                            num? numA = a["value"];
                            num? numB = b["value"];
                            return numB!.compareTo(numA!);
                          });
                          return SizedBox(
                            height: list!.length * 30,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: charts.BarChart(
                                [
                                  charts.Series<Map<String, dynamic>, String>(
                                    id: 'security',
                                    colorFn: (_, __) => charts
                                        .MaterialPalette.blue.shadeDefault,
                                    domainFn: (Map<String, dynamic> model, _) =>
                                        model['security'],
                                    measureFn:
                                        (Map<String, dynamic> model, _) =>
                                            model['value'],
                                    fillColorFn:
                                        (Map<String, dynamic> model, _) =>
                                            charts.ColorUtil.fromDartColor(
                                      model['value'] > 0
                                          ? AppColors.semantic_03
                                          : AppColors.semantic_03,
                                    ),
                                    labelAccessorFn: (Map<String, dynamic>
                                                model,
                                            _) =>
                                        "${model['value'].toStringAsFixed(2)}",
                                    data: list,
                                  )
                                ],
                                animate: true,
                                vertical: false,
                                primaryMeasureAxis:
                                    const charts.NumericAxisSpec(
                                  showAxisLine: false,
                                  renderSpec: charts.NoneRenderSpec(),
                                ),
                                domainAxis: const charts.OrdinalAxisSpec(
                                  showAxisLine: false,
                                  renderSpec: charts.SmallTickRendererSpec(
                                    minimumPaddingBetweenLabelsPx: 1,
                                    labelStyle:
                                        charts.TextStyleSpec(fontSize: 10),
                                    lineStyle: charts.LineStyleSpec(),
                                  ),
                                ),
                                barRendererDecorator:
                                    charts.BarLabelDecorator<String>(
                                  labelPosition:
                                      charts.BarLabelPosition.outside,
                                  insideLabelStyleSpec: charts.TextStyleSpec(
                                    fontSize: 10,
                                    color: charts.ColorUtil.fromDartColor(
                                        AppColors.neutral_07),
                                  ),
                                  outsideLabelStyleSpec: charts.TextStyleSpec(
                                    fontSize: 10,
                                    color: charts.ColorUtil.fromDartColor(
                                        AppColors.semantic_03),
                                  ),
                                ),
                                behaviors: [
                                  charts.SelectNearest(
                                      eventTrigger:
                                          charts.SelectionTrigger.tapAndDrag),
                                ],
                              ),
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "THÔNG TIN PHÁI SINH",
                    style: TextStyle(
                        color: AppColors.neutral_07,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.normal),
                  )),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  itemData(widget.data.contentFull!.derivativesSummaries![0]),
                  const SizedBox(
                    width: 12,
                  ),
                  itemData(widget.data.contentFull!.derivativesSummaries![1]),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget itemData(DerivativesSummaries data) {
    return Flexible(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.semantic_01,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: AppColors.bg_icon_summary,
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.code.toString(),
                    style: const TextStyle(color: AppColors.semantic_01),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        data.value.toString(),
                        style: const TextStyle(
                            color: AppColors.bg_1, fontSize: 16),
                      ),
                      Text(
                          "  +${data.changedValue}(+${data.changedPercentage}%)",
                          style: const TextStyle(
                              color: AppColors.bg_1, fontSize: 11))
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Text(
                        "KL : ",
                        style: TextStyle(
                            color: AppColors.text_summary, fontSize: 12),
                      ),
                      Text(
                          "${NumUtils.formatInteger(data.totalSharesTraded)} HĐ",
                          style: const TextStyle(
                              color: AppColors.bg_1, fontSize: 12)),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Độ lệch (Basis): ",
                        style: TextStyle(
                            color: AppColors.text_summary, fontSize: 12),
                      ),
                      Text(NumUtils.formatInteger(data.biasPrice),
                          style: const TextStyle(
                              color: AppColors.bg_1, fontSize: 12)),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Lũy kế ròng NN : ",
                        style: TextStyle(
                            color: AppColors.text_summary, fontSize: 12),
                      ),
                      Flexible(
                        child: Text(
                          "${NumUtils.formatInteger(data.foreignAccumulatedNetValue)} HĐ",
                          style: const TextStyle(
                              color: AppColors.bg_1, fontSize: 12),
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Column(
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: LinearProgressIndicator(
                              value: 1 / (data.lowestPrice!.toInt() / 1000),
                              backgroundColor: Colors.grey,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                  AppColors.semantic_01),
                            ),
                          ),
                          // FractionallySizedBox(
                          //   alignment: Alignment(
                          //     0,
                          //     1 / (data.lowestPrice!.toInt() / 1000),
                          //   ),
                          //   child: const Icon(
                          //     Icons.arrow_drop_down,
                          //     color: Colors.green,
                          //   ),
                          // ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            NumUtils.formatDouble(data.lowestPrice?.toInt()),
                            style: const TextStyle(color: Colors.white),
                          ),
                          Text(
                            NumUtils.formatDouble(data.highestPrice?.toInt()),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
