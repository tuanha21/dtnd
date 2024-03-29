import 'dart:ui';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:dtnd/=models=/index.dart';
import 'package:dtnd/=models=/response/market/index_detail.dart';
import 'package:dtnd/=models=/response/market/index_model.dart';
import 'package:dtnd/=models=/response/market/world_index_model.dart';
import 'package:dtnd/data/implementations/network_service.dart';
import 'package:dtnd/l10n/generated/l10n.dart' as s;
import 'package:dtnd/l10n/generated/l10n.dart';
import 'package:dtnd/ui/screen/home/home_controller.dart';
import 'package:dtnd/ui/screen/home/widget/commodity_item.dart';
import 'package:dtnd/ui/screen/home/widget/world_index.dart';
import 'package:dtnd/ui/screen/stock_detail/widget/k_chart.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:k_chart/chart_translations.dart';
import 'package:k_chart/flutter_k_chart.dart' as kcharts;
import 'package:k_chart/k_chart_widget.dart';

import '../../../../config/service/app_services.dart';

class HomeMarketToday extends StatefulWidget {
  const HomeMarketToday({super.key});

  @override
  State<HomeMarketToday> createState() => _HomeMarketTodayState();
}

class _HomeMarketTodayState extends State<HomeMarketToday>
    with SingleTickerProviderStateMixin {
  final HomeController homeController = HomeController();
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ObxValue<Rx<bool>>((initialized) {
      if (!initialized.value) {
        return Center(
          child: Text(s.S.of(context).loading),
        );
      }
      return Column(
        children: [
          PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                labelPadding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                onTap: (value) async {
                  setState(() {});
                },
                tabs: <Widget>[
                  Text(S.of(context).vietnam),
                  Text(S.of(context).world),
                  Text(S.of(context).commodities),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          if (_tabController.index == 0)
            SizedBox.fromSize(
              size: Size(MediaQuery.of(context).size.width, 80),
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse,
                  },
                ),
                child: Obx(() {
                  final cindex = homeController.currentIndexModel.value?.index;
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: homeController.listIndexs.length,
                    itemBuilder: (context, index) => HomeIndexItem(
                      data: homeController.listIndexs.elementAt(index),
                      selectedIndex: cindex,
                      onSelected: homeController.changeIndex,
                    ),
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(
                      width: 8,
                    ),
                  );
                }),
              ),
            )
          else if (_tabController.index == 2)
            SizedBox.fromSize(
              size: Size(MediaQuery.of(context).size.width, 76),
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse,
                  },
                ),
                child: Obx(() {
                  final cindex = homeController.currentCommodityModel.value;
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: homeController.worldIndex.length,
                    itemBuilder: (context, index) => CommodityItem(
                      data: homeController.commodities.elementAt(index),
                      selectedSymbol: cindex,
                      onSelected: homeController.changeCommodity,
                    ),
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(
                      width: 8,
                    ),
                  );
                }),
              ),
            )
          else
            SizedBox.fromSize(
              size: Size(MediaQuery.of(context).size.width, 76),
              child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(
                  dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse,
                  },
                ),
                child: Obx(() {
                  final cindex =
                      homeController.currentWorldIndexModel.value?.iDSYMBOL;
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: homeController.worldIndex.length,
                    itemBuilder: (context, index) => HomeWorldIndexItem(
                      data: homeController.worldIndex.elementAt(index),
                      selectedSymbol: cindex,
                      onSelected: homeController.changeWorldIndex,
                    ),
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(
                      width: 8,
                    ),
                  );
                }),
              ),
            ),
          if (_tabController.index == 0)
            Obx(
              () {
                if (homeController.currentIndexModel.value
                        ?.stockDayTradingHistory.value ==
                    null) {
                  return Container();
                }
                homeController.currentIndexModel.value?.indexDetail.vol.value;
                final locale = Localizations.localeOf(context);
                final languageTag =
                    '${locale.languageCode}_${locale.countryCode}';
                final Map<String, ChartTranslations> kChartTranslations = {
                  languageTag: ChartTranslations(
                    date: S.of(context).date_translations,
                    open: S.of(context).open_translations,
                    high: S.of(context).high_translations,
                    low: S.of(context).low_translations,
                    close: S.of(context).close_translations,
                    changeAmount: S.of(context).changeAmount_translations,
                    change: S.of(context).change_translations,
                    volumn: S.of(context).volumn_translations,
                  ),
                };
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: SizedBox.fromSize(
                    size: Size(MediaQuery.of(context).size.width, 250),
                    child: KChart(
                      showNowPrice: true,
                      isLine: true,
                      showMA: true,
                      mainState: MainState.MA,
                      dateTimeFormat: const [kcharts.dd, "/", kcharts.mm],
                      translations: kChartTranslations,
                      code: homeController.currentIndexModel.value!.index.name,
                      stockTradingHistory: homeController.currentIndexModel
                          .value!.stockDayTradingHistory.value!,
                      vol: homeController
                              .currentIndexModel.value!.indexDetail.vol.value
                              ?.toDouble() ??
                          0,
                    ),
                  ),
                );
              },
            )
          else if (_tabController.index == 2)
            Container()
          else
            Obx(() {
              final cwIndex = homeController.currentWorldIndexModel.value;
              if (cwIndex == null) {
                return Container();
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: FutureBuilder<List<WorldIndexData>?>(
                  future: cwIndex.getHistoryData(NetworkService.instance),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return SizedBox(
                        height: 250,
                        child: charts.TimeSeriesChart(
                          [
                            charts.Series<WorldIndexData, DateTime>(
                              id: 'Headcount',
                              domainFn: (WorldIndexData row, _) =>
                                  row.dateTime!,
                              measureFn: (WorldIndexData row, _) => row.value,
                              data: snapshot.data!,
                            )
                          ],
                          animate: false,
                          behaviors: [
                            charts.RangeAnnotation([
                              if (cwIndex.openPoint != null)
                                charts.LineAnnotationSegment(cwIndex.openPoint!,
                                    charts.RangeAnnotationAxisType.measure,
                                    endLabel: NumUtils.formatDouble(
                                        cwIndex.openPoint),
                                    // startLabel: 'Measure 1 End',
                                    dashPattern: [5, 5],
                                    color:
                                        charts.MaterialPalette.gray.shade300),
                            ]),
                          ],
                          // Provide a tickProviderSpec which does NOT require that zero is
                          // included.
                          primaryMeasureAxis: const charts.NumericAxisSpec(
                              renderSpec: charts.NoneRenderSpec(),
                              tickProviderSpec:
                                  charts.BasicNumericTickProviderSpec(
                                      zeroBound: false)),
                          domainAxis: const charts.DateTimeAxisSpec(
                            // Make sure that we draw the domain axis line.
                            // But don't draw anything else.
                            renderSpec: charts.SmallTickRendererSpec(
                                // labelRotation: 45,
                                // Tick and Label styling here.
                                labelOffsetFromAxisPx: 10,
                                // minimumPaddingBetweenLabelsPx: 5,
                                // labelCollisionOffsetFromAxisPx: 5,
                                // labelCollisionOffsetFromTickPx: 5,
                                // labelOffsetFromTickPx: 5,
                                // Change the line colors to match text color.
                                lineStyle: charts.LineStyleSpec(
                                    color: charts.MaterialPalette.transparent)),
                            tickFormatterSpec:
                                charts.AutoDateTimeTickFormatterSpec(
                                    day:
                                        charts.TimeFormatterSpec(
                                            format: 'dd',
                                            transitionFormat: 'MM-dd-yyyy'),
                                    month:
                                        charts.TimeFormatterSpec(
                                            format: 'MM',
                                            transitionFormat: 'MM-dd-yyyy'),
                                    year: charts.TimeFormatterSpec(
                                        format: 'yyyy',
                                        transitionFormat: 'MM-dd-yyyy')),
                            showAxisLine: false,
                          ),
                          layoutConfig: charts.LayoutConfig(
                            leftMarginSpec: charts.MarginSpec.fixedPixel(0),
                            topMarginSpec: charts.MarginSpec.fixedPixel(16),
                            rightMarginSpec: charts.MarginSpec.fixedPixel(0),
                            bottomMarginSpec: charts.MarginSpec.fixedPixel(16),
                          ),
                          defaultRenderer:
                              charts.LineRendererConfig(includeArea: true),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              );
            })
        ],
      );
    }, homeController.indexInitialized);
  }
}

class HomeIndexItem extends StatelessWidget {
  const HomeIndexItem(
      {super.key, required this.data, this.selectedIndex, this.onSelected});

  final IndexModel data;
  final Index? selectedIndex;
  final ValueChanged<Index>? onSelected;

  @override
  Widget build(BuildContext context) {
    final themeMode = AppService.instance.themeMode.value;

    BoxBorder? border;
    if (selectedIndex != null && data.index == selectedIndex) {
      border = Border.all(color: AppColors.neutral_04);
    }
    VoidCallback? onTap;
    if (onSelected != null) {
      onTap = () {
        onSelected?.call(data.index);
      };
    }
    return Material(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: Ink(
          width: 148,
          height: 64,
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            border: border,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            color: themeMode.isLight
                ? AppColors.neutral_07
                : AppColors.text_black_1,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data.index.exchangeName,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: themeMode.isLight
                            ? AppColors.text_black_1
                            : AppColors.neutral_07),
                  ),
                  Obx(() {
                    return SizedBox.square(
                      dimension: 20,
                      child: HomeIndexItemChart(data: [
                        data.indexDetail.upQuant.toInt(),
                        data.indexDetail.downQuant.toInt(),
                        data.indexDetail.refQuant.toInt(),
                      ]),
                    );
                  }),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() {
                    return Text(
                      "${data.indexDetail.cIndex.value}",
                      style: AppTextStyle.labelMedium_12.copyWith(
                        fontWeight: FontWeight.w600,
                        color: data.indexDetail.color,
                      ),
                    );
                  }),
                  Obx(() {
                    return Text(
                      "${data.indexDetail.change} (${data.indexDetail.changePc})",
                      style: AppTextStyle.bodySmall_8.copyWith(
                        fontWeight: FontWeight.w600,
                        color: data.indexDetail.color,
                      ),
                    );
                  }),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() => SizedBox.square(
                        dimension: 12,
                        child: Image.asset(AppImages.home_icon_clock,
                            color: data.indexDetail.status.value.color),
                      )),
                  Obx(() {
                    return Text(
                      "${NumUtils.formatInteger(
                        (data.indexDetail.value.value ?? 0) ~/ 1000,
                      )} ${S.of(context).billion_lowercase}",
                      style: AppTextStyle.labelSmall_11.copyWith(
                        fontWeight: FontWeight.w600,
                        color: themeMode.isLight
                            ? AppColors.text_black_1
                            : AppColors.neutral_07,
                      ),
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeIndexItemChart extends StatelessWidget {
  const HomeIndexItemChart({
    super.key,
    this.data,
  });

  final List<int>? data;

  List<charts.Series<int, int>> toSeries(List<int> chartData) {
    return [
      charts.Series<int, int>(
          id: 'Analyse',
          domainFn: (datum, index) => index ?? 0,
          measureFn: (datum, index) => datum,
          colorFn: (datum, index) {
            switch (index) {
              case 0:
                return charts.ColorUtil.fromDartColor(AppColors.semantic_01);
              case 1:
                return charts.ColorUtil.fromDartColor(AppColors.semantic_03);
              default:
                return charts.ColorUtil.fromDartColor(AppColors.semantic_02);
            }
          },
          data: chartData),
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return Container();
    }
    return charts.PieChart(
      toSeries(data!),
      animate: false,
      defaultRenderer: charts.ArcRendererConfig<int>(strokeWidthPx: 0.1),
      layoutConfig: charts.LayoutConfig(
        leftMarginSpec: charts.MarginSpec.fixedPixel(0),
        topMarginSpec: charts.MarginSpec.fixedPixel(0),
        rightMarginSpec: charts.MarginSpec.fixedPixel(0),
        bottomMarginSpec: charts.MarginSpec.fixedPixel(0),
      ),
    );
  }
}
