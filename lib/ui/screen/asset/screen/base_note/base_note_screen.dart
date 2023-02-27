import 'dart:ui';

import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/asset/component/asset_per_type_widget.dart';
import 'package:dtnd/ui/screen/asset/component/total_asset_widget.dart';
import 'package:dtnd/ui/screen/asset/logic/investment_catalog.dart';
import 'package:dtnd/ui/screen/asset/logic/money_type.dart';
import 'package:dtnd/ui/screen/virtual_assistant/va_volatolity_warning/component/asset_chart.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/widget/appbar/simple_appbar.dart';
import 'package:flutter/material.dart';

class BaseNoteScreen extends StatefulWidget {
  const BaseNoteScreen({super.key});

  @override
  State<BaseNoteScreen> createState() => _BaseNoteScreenState();
}

class _BaseNoteScreenState extends State<BaseNoteScreen>
    with SingleTickerProviderStateMixin {
  final IDataCenterService dataCenterService = DataCenterService();
  late final TabController _tabController;

  late final ScrollController scrollController;

  final defaultCatalog = <String>[
    "ACB",
    "FPT",
    "VCB",
    "GAS",
    "TPB",
  ];

  final List<InvestmentCatalog> list = [];

  bool gettingCatalog = true;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    scrollController = ScrollController();
    super.initState();
    getData();
  }

  void getData() async {
    setState(() {
      gettingCatalog = true;
    });
    final _list =
        await dataCenterService.getStockModelsFromStockCodes(defaultCatalog);
    for (var element in (_list ?? [])) {
      list.add(InvestmentCatalog(stockModel: element));
    }
    setState(() {
      gettingCatalog = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = AppService.instance.themeMode.value;
    Widget body = RefreshIndicator(
      onRefresh: () async {},
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          },
        ),
        child: ListView(
          children: [
            const SizedBox(
              height: 215,
              child: AssetChart(),
            ),
            const Padding(
              padding: EdgeInsets.all(16),
              child: TotalAssetWidget(
                type: TotalAssetWidgetType.withBackGround,
              ),
            ),
            AssetPerTypeWidget(
              values: [
                MoneyType(
                    icon: AppImages.wallet_3,
                    label: S.of(context).total_asset,
                    value: "154.000.100đ"),
                MoneyType(
                    icon: AppImages.shield_tick,
                    label: S.of(context).safe_ratio,
                    value: "48.00%"),
                MoneyType(
                    icon: AppImages.timer_2,
                    label: S.of(context).cash_dividends,
                    value: "0d"),
                MoneyType(
                    icon: AppImages.money_change,
                    label: S.of(context).withdrawable_money,
                    value: "10.000.000 đ")
              ],
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
    return Scaffold(
      appBar: SimpleAppbar(
        title: S.of(context).base_note,
      ),
      body: Column(
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
                padding: EdgeInsets.zero,
                tabs: <Widget>[
                  Text(S.of(context).inday_ordnote),
                  Text(S.of(context).condition_ordnote),
                  Text(S.of(context).order_history),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                // IndayOrderPanel(),
                // Center(child: Text("asd")),
                // OrderHistoryTab(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
