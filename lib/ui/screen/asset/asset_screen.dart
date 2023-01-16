import 'dart:ui';

import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/generated/l10n.dart';
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
import 'package:dtnd/ui/widget/section/simple_appbar.dart';
import 'package:flutter/material.dart';

class AssetScreen extends StatefulWidget {
  const AssetScreen({super.key});

  @override
  State<AssetScreen> createState() => _AssetScreenState();
}

class _AssetScreenState extends State<AssetScreen> {
  final IUserService userService = UserService();

  void rebuild() => setState(() {});

  void changeChart() {
    setState(() {
      showTotalAsset = !showTotalAsset;
    });
  }

  bool showTotalAsset = true;

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
              const Padding(
                padding: EdgeInsets.all(16),
                child: TotalAssetWidget(),
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
              AssetPerTypeWidget(
                values: [
                  MoneyType(
                      icon: AppImages.wallet_3,
                      label: S.of(context).investment_value,
                      value: "10.000.000 đ"),
                  MoneyType(
                      icon: AppImages.money_2,
                      label: S.of(context).cash,
                      value: "10.000.000 đ"),
                  MoneyType(
                      icon: AppImages.timer_2,
                      label: S.of(context).sold_returning_money,
                      value: "10.000.000 đ"),
                  MoneyType(
                      icon: AppImages.money_change,
                      label: S.of(context).withdrawable_money,
                      value: "10.000.000 đ")
                ],
              ),
              const SizedBox(height: 16),
              const AccountTypeAssetWidget(),
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
