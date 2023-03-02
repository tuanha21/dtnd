import 'dart:ui';

import 'package:dtnd/=models=/response/account/base_margin_account_model.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/asset/component/account_asset_overview_widget.dart';
import 'package:dtnd/ui/screen/asset/component/asset_distribution_chart.dart';
import 'package:dtnd/ui/screen/asset/sheet/extensions_sheet.dart';
import 'package:dtnd/ui/screen/market/widget/components/not_signin_catalog_widget.dart';
import 'package:dtnd/ui/screen/virtual_assistant/va_volatolity_warning/component/asset_chart.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/widget/dropdown/custom_dropdown_button.dart';
import 'package:dtnd/ui/widget/icon/icon_button.dart';
import 'package:dtnd/ui/widget/my_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'component/portfolio_and_right_panel.dart';
import 'sheet/sheet_config.dart';

class AssetScreen extends StatefulWidget {
  const AssetScreen({super.key});

  @override
  State<AssetScreen> createState() => _AssetScreenState();
}

class _AssetScreenState extends State<AssetScreen>
    with SingleTickerProviderStateMixin {
  final IUserService userService = UserService();
  final IDataCenterService dataCenterService = DataCenterService();

  void rebuild() => setState(() {});

  void changeChart() {
    setState(() {
      showTotalAsset = !showTotalAsset;
    });
  }

  bool showTotalAsset = true;

  // @override
  // void initState() {
  //   super.initState();
  // }

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
        chart = Obx(() {
          // final data = userService.listAccountModel.value?.firstWhereOrNull(
          //         (element) => element.runtimeType == BaseMarginAccountModel)
          //     as BaseMarginAccountModel?;
          final data = userService.listAccountModel.value?.firstWhereOrNull(
                  (element) => element.runtimeType == BaseMarginAccountModel)
              as BaseMarginAccountModel?;
          return AssetChart(
            datas: data?.listAssetChart,
          );
        });
      } else {
        chart = Obx(() {
          // final data = userService.listAccountModel.value?.firstWhereOrNull(
          //         (element) => element.runtimeType == BaseMarginAccountModel)
          //     as BaseMarginAccountModel?;
          final data = userService.listAccountModel.value?.firstWhereOrNull(
                  (element) => element.runtimeType == BaseMarginAccountModel)
              as BaseMarginAccountModel?;
          List<ChartData> datas = [
            ChartData(
                "Tiền",
                (data?.cashBalance ?? 0) *
                    100 /
                    ((data?.cashBalance ?? 0) +
                        (data?.portfolioStatus?.marketValue ?? 0))),
            ChartData(
                "Cổ phiếu",
                (data?.portfolioStatus?.marketValue ?? 0) *
                    100 /
                    ((data?.cashBalance ?? 0) +
                        (data?.portfolioStatus?.marketValue ?? 0))),
          ];
          return AssetDistributionChart(
            datas: datas,
            total: (data?.cashBalance ?? 0) +
                (data?.portfolioStatus?.marketValue ?? 0),
          );
        });
      }
      child = RefreshIndicator(
        onRefresh: userService.refreshAssets,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
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
                    Row(
                      children: [
                        const CustomDropDownButton(
                          items: [
                            "Tài khoản Demo",
                            "Tài khoản liên kết",
                          ],
                        ),
                        const SizedBox(width: 8),
                        Material(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6)),
                          child: InkWell(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(6)),
                            onTap: () {
                              const ExtensionsISheet()
                                  .show(context, const ExtensionsSheet());
                            },
                            child: Ink(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: AppColors.primary_03,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(6)),
                              ),
                              child: SizedBox.square(
                                dimension: 20,
                                child: Image.asset(
                                  AppImages.asset_menu_icon,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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
                    final data = userService.listAccountModel.value!
                            .firstWhereOrNull((element) =>
                                element.runtimeType == BaseMarginAccountModel)
                        as BaseMarginAccountModel?;
                    return AccountAssetOverviewWidget(
                      data: data,
                    );
                  } else {
                    return const AccountAssetOverviewWidget();
                  }
                }),
              ),
              const PortfolioAndRightPanel(),
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
