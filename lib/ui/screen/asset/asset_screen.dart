import 'dart:ui';

import 'package:dtnd/=models=/response/account/base_margin_account_model.dart';
import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/asset/component/account_asset_overview_widget.dart';
import 'package:dtnd/ui/screen/asset/component/account_type_asset_widget.dart';
import 'package:dtnd/ui/screen/asset/component/asset_distribution_chart.dart';
import 'package:dtnd/ui/screen/asset/component/asset_per_type_widget.dart';
import 'package:dtnd/ui/screen/asset/component/total_asset_widget.dart';
import 'package:dtnd/ui/screen/asset/logic/money_type.dart';
import 'package:dtnd/ui/screen/market/widget/components/not_signin_catalog_widget.dart';
import 'package:dtnd/ui/screen/virtual_assistant/va_volatolity_warning/component/asset_chart.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/widget/icon/icon_button.dart';
import 'package:dtnd/ui/widget/my_appbar.dart';
import 'package:dtnd/utilities/logger.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widget/tabbar/rounded_tabbar.dart';
import 'component/account_right_widget.dart';
import 'component/investment_catalog_widget.dart';
import 'logic/investment_catalog.dart';

class AssetScreen extends StatefulWidget {
  const AssetScreen({super.key});

  @override
  State<AssetScreen> createState() => _AssetScreenState();
}

class _AssetScreenState extends State<AssetScreen>
    with SingleTickerProviderStateMixin {
  final IUserService userService = UserService();
  final IDataCenterService dataCenterService = DataCenterService();
  late final TabController _tabController;

  late final ScrollController scrollController;
  void rebuild() => setState(() {});

  void changeChart() {
    setState(() {
      showTotalAsset = !showTotalAsset;
    });
  }

  bool showTotalAsset = true;

  bool gettingCatalog = true;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (!userService.isLogin) {
      child = Center(
        child: NotSigninCatalogWidget(
          afterLogin: rebuild,
        ),
      );
    } else {
      final textTheme = Theme.of(context).textTheme;
      Widget chart;
      if (showTotalAsset) {
        chart = const AssetChart(
          lineColor: AppColors.graph_7,
        );
      } else {
        chart = const AssetDistributionChart();
      }
      child = RefreshIndicator(
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
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    AppIconButton(
                      icon: AppImages.arrow_swap,
                      onPressed: changeChart,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      showTotalAsset
                          ? S.of(context).total_asset
                          : S.of(context).asset_distribution,
                      style: textTheme.bodyMedium!.copyWith(
                        color: AppColors.primary_01,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 215,
                child: chart,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Obx(() {
                  if (userService.listAccountModel.value?.isNotEmpty ?? false) {
                    logger.v(userService.listAccountModel.value);
                    final data = userService.listAccountModel.value!
                            .firstWhereOrNull((element) =>
                                element.runtimeType == BaseMarginAccountModel)
                        as BaseMarginAccountModel?;
                    logger.v(data);
                    return AccountAssetOverviewWidget(
                      data: data,
                    );
                  } else {
                    return const AccountAssetOverviewWidget();
                  }
                }),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).asset,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                    Container(),
                  ],
                ),
              ),
              Obx(() {
                if (userService.listAccountModel.value?.isNotEmpty ?? false) {
                  final data = userService.listAccountModel.value!.firstWhere(
                          (element) =>
                              element.runtimeType == BaseMarginAccountModel)
                      as BaseMarginAccountModel;
                  return AssetPerTypeWidget(
                    values: [
                      MoneyType(
                          icon: AppImages.wallet_3,
                          label: S.of(context).investment_value,
                          value:
                              "${NumUtils.formatDouble((data.equity ?? 0) - (data.cashBalance ?? 0) - (data.debt ?? 0))} đ"),
                      MoneyType(
                          icon: AppImages.money_2,
                          label: S.of(context).cash,
                          value:
                              "${NumUtils.formatDouble(data.cashBalance ?? 0)} đ"),
                      MoneyType(
                          icon: AppImages.timer_2,
                          label: S.of(context).sold_returning_money,
                          value: "${NumUtils.formatDouble(data.apT0 ?? 0)} đ"),
                      MoneyType(
                          icon: AppImages.money_change,
                          label: S.of(context).withdrawable_money,
                          value:
                              "${NumUtils.formatDouble(data.withdrawalCash ?? 0)} đ")
                    ],
                  );
                } else {
                  return AssetPerTypeWidget(
                    values: [
                      MoneyType(
                          icon: AppImages.wallet_3,
                          label: S.of(context).investment_value,
                          value: "-"),
                      MoneyType(
                          icon: AppImages.money_2,
                          label: S.of(context).cash,
                          value: "-"),
                      MoneyType(
                          icon: AppImages.timer_2,
                          label: S.of(context).sold_returning_money,
                          value: "-"),
                      MoneyType(
                          icon: AppImages.money_change,
                          label: S.of(context).withdrawable_money,
                          value: "-")
                    ],
                  );
                }
              }),
              const SizedBox(height: 16),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: Column(
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(vertical: 6),
                    //   child: SizedBox(
                    //     width: 39,
                    //     height: 4,
                    //     child: Container(
                    //       decoration: const BoxDecoration(
                    //         color: AppColors.neutral_03,
                    //         borderRadius: BorderRadius.all(
                    //           Radius.circular(2),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    RoundedTabbar(
                      controller: _tabController,
                      tabs: [
                        Text(S.of(context).catalog),
                        Text(S.of(context).right),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Obx(() {
                  final data = userService.listAccountModel.value
                          ?.firstWhereOrNull((element) =>
                              element.runtimeType == BaseMarginAccountModel)
                      as BaseMarginAccountModel?;
                  return Column(
                    children: [
                      for (int i = 0;
                          i <
                              (data?.portfolioStatus?.porfolioStocks?.length ??
                                  0);
                          i++)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: InvestmentCatalogWidget(
                            data: data!.portfolioStatus!.porfolioStocks!
                                .elementAt(i),
                            volPc: (data.portfolioStatus!.porfolioStocks!
                                        .elementAt(i)
                                        .marketValue ??
                                    0) /
                                (data.portfolioStatus!.marketValue ?? 1) *
                                100,
                          ),
                        )
                    ],
                  );
                }),
              ),
              // TabBarView(
              //   controller: _tabController,
              //   // physics: PanelScrollPhysics(controller: panelController),
              //   // controller: scrollController,
              //   children: <Widget>[
              //     Column(
              //       children: [
              //         for (var e in list)
              //           Padding(
              //             padding: const EdgeInsets.symmetric(vertical: 16),
              //             child: InvestmentCatalogWidget(
              //               data: e,
              //             ),
              //           )
              //       ],
              //     ),
              //     Column(
              //       children: [
              //         for (int i = 0; i < 3; i++)
              //           Padding(
              //             padding: const EdgeInsets.symmetric(vertical: 6),
              //             child: AccountRightWidget(
              //               index: i,
              //             ),
              //           )
              //       ],
              //     ),
              //   ],
              // ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      );
    }
    return Scaffold(
      appBar: const MyAppBar(),
      body: child,
    );
  }
}
