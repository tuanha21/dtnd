import 'dart:convert';
import 'dart:ui';

import 'package:dtnd/=models=/fake/brief_model.dart';
import 'package:dtnd/=models=/fake/summary_model.dart';
import 'package:dtnd/=models=/index.dart';
import 'package:dtnd/=models=/response/index_model.dart';
import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/i_local_storage_service.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/market/market_controller.dart';
import 'package:dtnd/ui/screen/market/widget/components/index_item.dart';
import 'package:dtnd/ui/screen/market/widget/page/brief_page.dart';
import 'package:dtnd/ui/screen/stock_detail/stock_detail_screen.dart';
import 'package:dtnd/ui/screen/stock_detail/widget/k_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:k_chart/chart_translations.dart';

import 'package:dtnd/=models=/response/index_detail.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/data/implementations/local_storage_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';

import '../page/summary_chart_page.dart';
import 'market_noti_card.dart';

Future<Map> readJsonFile(String filePath) async {
  var fileContent = await rootBundle.loadString(filePath);

  var map = jsonDecode(fileContent);
  return map;
}

class IndexChart extends StatefulWidget {
  const IndexChart({super.key});

  @override
  State<IndexChart> createState() => _IndexChartState();
}

class _IndexChartState extends State<IndexChart> {
  final IDataCenterService dataCenterService = DataCenterService();
  final ILocalStorageService localStorageService = LocalStorageService();
  final IUserService userService = UserService();
  final MarketController marketController = MarketController();

  Future<List<IndexDetailResponse>> listIndexRes = Future.value([]);

  @override
  void initState() {
    listIndexRes = dataCenterService.getListIndexDetail();
    super.initState();
  }

  void changeIndex(Index index) async {
    if (marketController.loadingIndex.value) {
      return;
    }
    await marketController.changeSelectedIndex(index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox.fromSize(
            size: Size(MediaQuery.of(context).size.width, 250),
            child: Obx(() {
              if (marketController.currentChartData.value == null) {
                return Center(
                  child: Text(S.of(context).loading),
                );
              }
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
              return KChart(
                isLine: true,
                showNowPrice: true,
                translations: kChartTranslations,
                code: marketController.currentIndexModel.value!.index.chartCode,
                stockTradingHistory: marketController.currentChartData.value!,
                vol: marketController
                        .currentIndexModel.value?.indexDetail.vol.value
                        ?.toDouble() ??
                    0,
              );
            }),
          ),
        ),
        ObxValue<Rx<bool>>(
          (initialized) {
            if (!initialized.value) {
              return Center(
                child: Text(S.of(context).loading),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox.fromSize(
                size: Size(MediaQuery.of(context).size.width, 80),
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(
                    dragDevices: {
                      PointerDeviceKind.touch,
                      PointerDeviceKind.mouse,
                    },
                  ),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: marketController.listIndexs.length,
                    itemBuilder: (context, index) =>
                        ObxValue<Rx<IndexModel?>>((currentIndexModel) {
                      return MarketIndexItem(
                        data:
                            marketController.listIndexs.elementAt(index).first,
                        selectedIndex: currentIndexModel.value?.index,
                        onSelected: changeIndex,
                      );
                    }, marketController.currentIndexModel),
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(
                      width: 8,
                    ),
                  ),
                ),
              ),
            );
          },
          marketController.initialized,
        ),
        FutureBuilder<Map>(
          future: readJsonFile("./assets/fake_data/data_loz.json"),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            }
            final Map data = snapshot.data!;
            final BriefModel briefModel = BriefModel.fromJson(data['brief']);
            final SummaryModel summaryModel =
                SummaryModel.fromJson(data['summary']);
            return Column(
              children: [
                MarketNotiCard(
                  title: briefModel.title!,
                  date: briefModel.regDateTime!,
                  onTap: () => Navigator.of(context)
                      .push(MaterialPageRoute(
                    builder: (context) => BriefPage(data: briefModel),
                  ))
                      .then((value) {
                    if (value is StockModel) {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            StockDetailScreen(stockModel: value),
                      ));
                      return;
                    }
                  }),
                ),
                MarketNotiCard(
                  title: summaryModel.title!,
                  date: summaryModel.regDateTime!,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>  SummaryChartPage(data: summaryModel),
                    ),
                  ),
                ),
              ],
            );
          },
        )
        // MarketNotiCard(title: ,)
      ],
    );
  }
}
