import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../=models=/fake/summary_model.dart';
import '../../../../../generated/l10n.dart';
import '../../../../theme/app_color.dart';
import '../../../../theme/app_image.dart';
import '../../../../widget/appbar/simple_appbar.dart';

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

    return SafeArea(
      child: Scaffold(
        appBar: SimpleAppbar(
          title: 'Market summary',
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Center(
                child: Material(
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                  child: InkWell(
                    onTap: () {},
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                    child: Ink(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: AppColors.primary_03,
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      ),
                      child: const Icon(Icons.share),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Text(widget.data.contentFull!.title.toString()),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text("Top giao dịch nước ngoài"),
                        SvgPicture.asset(
                          AppImages.infoCircle,
                        ),
                      ],
                    ),
                    Text("Đơn vị: Tỷ đồng")
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [Text("Top mua ròng"), Text("Top bán ròng")],
              ),
              const SizedBox(
                height: 10,
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
                          list?.sort((a, b) {
                            num? numA = a["value"];
                            num? numB = b["value"];
                            return numB!.compareTo(numA!);
                          });
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
                                      labelStyle:
                                          charts.TextStyleSpec(fontSize: 10),
                                      lineStyle: charts.LineStyleSpec(),
                                    ),
                                  ),
                                  barRendererDecorator:
                                      charts.BarLabelDecorator<String>(
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
                                  labelPosition: charts.BarLabelPosition
                                      .outside, // Đặt vị trí hiển thị chữ trong các thanh bar
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
              Text("THÔNG TIN PHÁI SINH"),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Text("VN30F2307"),
                        Row(
                          children: [Text("1,132.4"), Text("+7.20 ()")],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Text("VN30F2307"),
                        Row(
                          children: [Text("1,132.4"), Text("+7.20 ()")],
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
