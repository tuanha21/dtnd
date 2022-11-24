import 'dart:ui';

import 'package:dtnd/=models=/index.dart';
import 'package:dtnd/=models=/response/index_model.dart';
import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/utilities/extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class HomeMarketToday extends StatefulWidget {
  const HomeMarketToday({super.key});

  @override
  State<HomeMarketToday> createState() => _HomeMarketTodayState();
}

class _HomeMarketTodayState extends State<HomeMarketToday> {
  final IDataCenterService dataCenterService = DataCenterService();

  late final Set<IndexModel> listIndexs;

  bool initialized = false;

  @override
  void initState() {
    super.initState();
    getListIndexs();
  }

  Future<void> getListIndexs() async {
    listIndexs = await dataCenterService.getListIndex();
    setState(() {
      initialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: Size(MediaQuery.of(context).size.width, 64),
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          },
        ),
        child: Builder(builder: (context) {
          if (!initialized) {
            return Center(
              child: Text(S.of(context).loading),
            );
          }
          return ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: listIndexs.length,
            itemBuilder: (context, index) => HomeIndexItem(
              data: listIndexs.elementAt(index),
            ),
            separatorBuilder: (BuildContext context, int index) =>
                const SizedBox(
              width: 8,
            ),
          );
        }),
      ),
    );
  }
}

class HomeIndexItem extends StatelessWidget {
  const HomeIndexItem({super.key, required this.data});
  final IndexModel data;
  @override
  Widget build(BuildContext context) {
    return SizedBox.fromSize(
      size: const Size(148, 64),
      child: ObxValue<Rx<ThemeMode>>(
        (themeMode) {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              color: data.indexDetail.bgColor(themeMode.value),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      data.index.exchangeName,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    SizedBox.square(
                      dimension: 20,
                      child: HomeIndexItemChart(data: [
                        data.indexDetail.upQuant.toInt(),
                        data.indexDetail.downQuant.toInt(),
                        data.indexDetail.refQuant.toInt(),
                      ]),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${data.indexDetail.cIndex.value}",
                      style: AppTextStyle.labelMedium_12.copyWith(
                        fontWeight: FontWeight.w600,
                        color: data.indexDetail.color,
                      ),
                    ),
                    Text(
                      "${data.indexDetail.change} (${data.indexDetail.changePc})",
                      style: AppTextStyle.bodySmall_8.copyWith(
                        fontWeight: FontWeight.w600,
                        color: data.indexDetail.color,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        AppService.instance.themeMode,
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
