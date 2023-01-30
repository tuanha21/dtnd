import 'dart:ui';

import 'package:dtnd/=models=/index.dart';
import 'package:dtnd/=models=/response/index_model.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/generated/l10n.dart' as s;
import 'package:dtnd/ui/screen/home/home_controller.dart';
import 'package:dtnd/ui/screen/stock_detail/widget/k_chart.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class HomeMarketToday extends StatefulWidget {
  const HomeMarketToday({super.key});

  @override
  State<HomeMarketToday> createState() => _HomeMarketTodayState();
}

class _HomeMarketTodayState extends State<HomeMarketToday> {
  final HomeController homeController = HomeController();

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
          SizedBox.fromSize(
            size: Size(MediaQuery.of(context).size.width, 64),
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                dragDevices: {
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse,
                },
              ),
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: homeController.listIndexs.length,
                itemBuilder: (context, index) => HomeIndexItem(
                  data: homeController.listIndexs.elementAt(index),
                ),
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                  width: 8,
                ),
              ),
            ),
          ),
          Builder(
            builder: (context) {
              if (homeController.currentIndexModel.stockTradingHistory.value ==
                  null) {
                return Container();
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox.fromSize(
                  size: Size(MediaQuery.of(context).size.width, 250),
                  child: KChart(indexModel: homeController.currentIndexModel),
                ),
              );
            },
          )
        ],
      );
    }, homeController.initialized);
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
      border = Border.all(color: AppColors.neutral_03);
    }
    VoidCallback? onTap;
    if (onSelected != null) {
      onTap = () => onSelected?.call(data.index);
    }
    return Obx(() {
      return Material(
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
              color: data.indexDetail.bgColor(themeMode),
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
                    Builder(builder: (context) {
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
          ),
        ),
      );
    });
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
