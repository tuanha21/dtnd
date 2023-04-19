import 'dart:ui';

import 'package:dtnd/=models=/response/account/base_margin_plus_account_model.dart';
import 'package:dtnd/=models=/response/stock.dart';
import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/i_local_storage_service.dart';
import 'package:dtnd/data/i_network_service.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/data/implementations/local_storage_service.dart';
import 'package:dtnd/data/implementations/network_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/asset/component/account_asset_overview_widget.dart';
import 'package:dtnd/ui/screen/asset/component/asset_distribution_chart.dart';
import 'package:dtnd/ui/screen/asset/screen/margin_debt/margin_debt_screen.dart';
import 'package:dtnd/ui/screen/asset/screen/executed_profit_loss/realized_profit_loss.dart';
import 'package:dtnd/ui/screen/asset/sheet/extensions_sheet.dart';
import 'package:dtnd/ui/screen/exchange_stock/order_note/screen/order_note_screen.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/business/stock_order_flow.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/sheet/stock_order_sheet.dart';
import 'package:dtnd/ui/screen/login/login_screen.dart';
import 'package:dtnd/ui/screen/market/widget/components/not_signin_catalog_widget.dart';
import 'package:dtnd/ui/screen/search/search_screen.dart';
import 'package:dtnd/ui/screen/stock_detail/stock_detail_screen.dart';
import 'package:dtnd/ui/screen/virtual_assistant/va_volatolity_warning/component/asset_chart.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/widget/dropdown/custom_dropdown_button.dart';
import 'package:dtnd/ui/widget/icon/icon_button.dart';
import 'package:dtnd/ui/widget/my_appbar.dart';
import 'package:dtnd/ui/widget/overlay/login_first_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../widget/overlay/custom_dialog.dart';
import 'component/portfolio_and_right_panel.dart';
import 'sheet/sheet_flow.dart';

class AssetScreen extends StatefulWidget {
  const AssetScreen({
    super.key,
  });
  @override
  State<AssetScreen> createState() => _AssetScreenState();
}

class _AssetScreenState extends State<AssetScreen>
    with SingleTickerProviderStateMixin {
  final IUserService userService = UserService();
  final IDataCenterService dataCenterService = DataCenterService();
  final INetworkService networkService = NetworkService();
  final ILocalStorageService localStorageService = LocalStorageService();

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

    return Scaffold(
      appBar: MyAppBar(
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                builder: (context) => const SearchScreen(),
              ))
                  .then((value) async {
                if (value is Stock) {
                  dataCenterService.getStocksModelsFromStockCodes(
                      [value.stockCode]).then((stockModels) {
                    if (stockModels != null) {
                      return Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => StockDetailScreen(
                          stockModel: stockModels.first,
                        ),
                      ));
                    }
                  });
                }
              });
            },
            child: SizedBox.square(
                dimension: 26,
                child: Image.asset(
                  AppImages.home_icon_search_normal,
                )),
          ),
          const SizedBox(
            width: 20,
          ),
          SizedBox.square(
              dimension: 26,
              child: Image.asset(
                AppImages.home_icon_notification,
              )),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
      body: Obx(() {
        if (userService.token.value == null) {
          child = Center(
            child: NotSigninCatalogWidget(
              afterLogin: rebuild,
              localStorageService: localStorageService,
            ),
          );
        } else {
          final textTheme = Theme.of(context).textTheme;
          Widget chart;
          if (showTotalAsset) {
            chart = Obx(() {
              final data = userService.listAccountModel.value?.firstWhereOrNull(
                      (element) =>
                          element.runtimeType == BaseMarginPlusAccountModel)
                  as BaseMarginPlusAccountModel?;

              return AssetChart(
                datas: data?.listAssetChart,
              );
            });
          } else {
            chart = Obx(() {
              final data = userService.listAccountModel.value?.firstWhereOrNull(
                      (element) =>
                          element.runtimeType == BaseMarginPlusAccountModel)
                  as BaseMarginPlusAccountModel?;
              List<ChartData> datas = [
                ChartData(
                    S.of(context).money,
                    (data?.cashBalance ?? 0) *
                        100 /
                        ((data?.cashBalance ?? 0) +
                            (data?.portfolioStatus?.marketValue ?? 0))),
                ChartData(
                    S.of(context).stock,
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
                                onTap: () => const ExtensionsISheet()
                                    .show(context, const ExtensionsSheet())
                                    .then(
                                  (value) {
                                    switch (value.runtimeType) {
                                      case ToBaseNoteCmd:
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const OrderNoteScreen(),
                                          ),
                                        );
                                        break;
                                      case ToOrderHistoryCmd:
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const OrderNoteScreen(
                                                    defaultab: 1),
                                          ),
                                        );
                                        break;
                                      case ToProfitAndLossCmd:
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const RealizedProfitLoss(),
                                          ),
                                        );
                                        break;
                                      case ToMarginDebt:
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const MarginDebtScreen(),
                                          ),
                                        );
                                        break;
                                      default:
                                        break;
                                    }
                                  },
                                ),
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
                    child: Obx(
                      () {
                        if (userService.listAccountModel.value?.isNotEmpty ??
                            false) {
                          final data = userService.defaultAccount.value
                              as BaseMarginPlusAccountModel?;
                          return AccountAssetOverviewWidget(
                            data: data,
                          );
                        } else {
                          return const AccountAssetOverviewWidget();
                        }
                      },
                    ),
                  ),
                  const PortfolioAndRightPanel(),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          );
        }
        return child;
      }),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 60),
        child: SizedBox.square(
          dimension: 40,
          child: Material(
            borderRadius: const BorderRadius.all(Radius.circular(6)),
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              onTap: _onFABTapped,
              child: Ink(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                  color: AppColors.primary_01,
                ),
                child: SvgPicture.asset(
                  AppImages.arrange_circle,
                ),
                // child: SvgPicture.asset(
                //   AppImages.arrange_circle,
                // ),
              ),
            ),
          ),
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void _onFABTapped() async {
    if (!userService.isLogin) {
      final toLogin = await showDialog<bool>(
        context: context,
        builder: (context) {
          return const LoginFirstDialog();
        },
      );
      if (toLogin ?? false) {
        if (!mounted) return;
        await Navigator.of(context)
            .push<bool>(MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ))
            .then((result) async {
          if ((result ?? false)) {
            setState(() {});
            if (!localStorageService.biometricsRegistered) {
              final reg = await showDialog<bool>(
                context: context,
                builder: (context) {
                  return CustomDialog(
                    textButtonAction: S.of(context).ok,
                    textButtonExit: S.of(context).Later,
                    title: S.of(context).biometric_authentication,
                    content: S.of(context).login_with_biometric,
                    action: () {
                      Navigator.of(context).pop();
                    },
                    type: TypeAlert.notification,
                  );
                },
              );
              if (reg ?? false) {
                if (!mounted) return;
                final auth = await localStorageService
                    .biometricsValidate()
                    .onError((error, stackTrace) => false);
                if (auth) {
                  await localStorageService.registerBiometrics();
                }
              }
            }
            return _onFABTapped();
          }
        });
      }
    } else {
      final list =
          await dataCenterService.getStocksModelsFromStockCodes(["AAA"]);
      final StockModel? aaa;
      if (list?.isNotEmpty ?? false) {
        aaa = list!.first;
      } else {
        aaa = null;
      }
      if (mounted) {}
      // return StockOrderISheet(widget.stockModel).showSheet(context, );
      StockOrderISheet(null)
          .show(
              context,
              StockOrderSheet(
                stockModel: aaa,
                orderData: null,
              ))
          .then((value) => userService.defaultAccount.value
              ?.refreshAsset(userService, networkService));
    }
  }
}
