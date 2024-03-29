import 'dart:ui';

import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/l10n/generated/l10n.dart';
import 'package:dtnd/ui/screen/asset/component/asset_per_type_widget.dart';
import 'package:dtnd/ui/screen/asset/component/total_asset_widget.dart';
import 'package:dtnd/ui/screen/asset/logic/investment_catalog.dart';
import 'package:dtnd/ui/screen/asset/logic/money_type.dart';
import 'package:dtnd/ui/screen/virtual_assistant/va_volatolity_warning/component/asset_chart.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/widget/appbar/simple_appbar.dart';
import 'package:dtnd/ui/widget/tabbar/rounded_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

class DerivativeAssetScreen extends StatefulWidget {
  const DerivativeAssetScreen({super.key});

  @override
  State<DerivativeAssetScreen> createState() => _DerivativeAssetScreenState();
}

class _DerivativeAssetScreenState extends State<DerivativeAssetScreen>
    with SingleTickerProviderStateMixin {
  final IDataCenterService dataCenterService = DataCenterService();
  late final TabController _tabController;

  late final ScrollController scrollController;
  late final PanelController panelController;

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
    _tabController = TabController(length: 2, vsync: this);
    scrollController = ScrollController();
    panelController = PanelController();
    super.initState();
    getData();
  }

  void getData() async {
    setState(() {
      gettingCatalog = true;
    });
    final _list =
        await dataCenterService.getStocksModelsFromStockCodes(defaultCatalog);
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
                asset: "80.000.000đ",
                percent: 15,
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
        title: S.of(context).derivative,
        actions: [
          IconButton(
              onPressed: () {},
              icon: Image.asset(
                AppImages.element_equal,
                width: 24,
                height: 24,
              ))
        ],
      ),
      body: SlidingUpPanel(
        minHeight: 60,
        parallaxEnabled: false,
        maxHeight: MediaQuery.of(context).size.height - kToolbarHeight - 80,
        color: themeMode.isLight ? Colors.white : Colors.black,
        scrollController: scrollController,
        controller: panelController,
        body: body,
        header: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 60,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: ForceDraggableWidget(
                  child: SizedBox(
                    width: 39,
                    height: 4,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: AppColors.neutral_03,
                        borderRadius: BorderRadius.all(
                          Radius.circular(2),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              ForceDraggableWidget(
                child: RoundedTabbar(
                  controller: _tabController,
                  tabs: [
                    Text(S.of(context).catalog),
                    Text(S.of(context).right),
                  ],
                ),
              ),
            ],
          ),
        ),
        panelBuilder: () {
          return Padding(
            padding: const EdgeInsets.only(top: 60),
            child: TabBarView(
              controller: _tabController,
              // physics: PanelScrollPhysics(controller: panelController),
              // controller: scrollController,
              children: <Widget>[
                // ListView(
                //   physics:
                //       PanelScrollPhysics(controller: panelController),
                //   controller: scrollController,
                //   shrinkWrap: true,
                //   children: [
                //     TabTradingBoard(
                //       stockModel: widget.stockModel,
                //       scrollController: scrollController,
                //       panelController: panelController,
                //     ),
                //   ],
                // ),

                // ListView(
                //   padding: const EdgeInsets.all(16),
                //   controller: scrollController,
                //   children: [
                //     for (var e in list)
                //       Padding(
                //         padding: const EdgeInsets.symmetric(vertical: 16),
                //         child: InvestmentCatalogWidget(
                //           data: e,
                //         ),
                //       )
                //   ],
                // ),
                Center(
                  child: Text(S.of(context).Detailed_Mass),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
