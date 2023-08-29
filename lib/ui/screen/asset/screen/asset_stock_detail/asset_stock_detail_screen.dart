import 'package:dtnd/=models=/response/account/portfolio_status_model.dart';
import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/asset/component/asset_grid_element.dart';
import 'package:dtnd/ui/screen/asset/screen/asset_stock_detail/asset_stock_detail_controller.dart';
import 'package:dtnd/ui/screen/asset/screen/asset_stock_detail/component/asset_stock_detail_appbar.dart';
import 'package:dtnd/ui/screen/asset/screen/asset_stock_detail/tab/unclosed_deal_tab.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/business/stock_order_flow.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/sheet/stock_order_sheet.dart';
import 'package:dtnd/ui/screen/login/login_screen.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/widget/button/single_color_text_button.dart';
import 'package:dtnd/ui/widget/overlay/login_first_dialog.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';

import '../../../../../config/service/app_services.dart';
import 'component/asset_stock_detail_overview.dart';
import 'tab/closed_deal_tab.dart';
import 'tab/history_tab.dart';

class AssetStockDetailScreen extends StatefulWidget {
  const AssetStockDetailScreen({
    super.key,
    required this.stockCode,
    required this.porfolioStock,
  });

  final String stockCode;
  final PorfolioStock porfolioStock;

  @override
  State<AssetStockDetailScreen> createState() => _AssetStockDetailScreenState();
}

class _AssetStockDetailScreenState extends State<AssetStockDetailScreen>
    with SingleTickerProviderStateMixin {
  final IDataCenterService dataCenterService = DataCenterService();
  late final AssetStockDetailController assetStockDetailController;
  late final TabController tabController;
  StockModel? stockModel;

  late DateTime fromDay;
  late DateTime toDay;
  late DateTime firstDay;
  late DateTime lastDay;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    assetStockDetailController =
        AssetStockDetailController(stockCode: widget.stockCode);

    super.initState();
    getData(widget.stockCode);
  }

  Future<void> getData(String stockCode) async {
    final data =
        await dataCenterService.getStocksModelsFromStockCodes([stockCode]);
    if (data?.isNotEmpty ?? false) {
      setState(() {
        stockModel = data!.first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final ThemeMode themeMode = AppService.instance.themeMode.value;

    return Scaffold(
      appBar: AssetStockDetailAppbar(
        stockCode: widget.stockCode,
        stockModel: stockModel,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        height: 78,
        child: Column(
          children: [
            Row(
              children: [
                Builder(
                  builder: (context) {
                    if ((widget.porfolioStock.avaiableVol ?? 0) > 0) {
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: SingleColorTextButton(
                              onTap: () async {
                                if (!UserService().isLogin) {
                                  final toLogin = await showDialog<bool>(
                                    context: context,
                                    builder: (context) {
                                      return const LoginFirstDialog();
                                    },
                                  );
                                  if (toLogin ?? false) {
                                    if (!mounted) return;
                                    await Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => const LoginScreen(),
                                    ));
                                  }
                                } else {
                                  final model = await dataCenterService
                                      .getStocksModelsFromStockCodes(
                                          [widget.stockCode]);
                                  if ((model?.isNotEmpty ?? false) && mounted) {
                                    StockOrderISheet(model!.first).show(
                                        context,
                                        StockOrderSheet(
                                          stockModel: model.first,
                                          orderData: null,
                                        ));
                                  }
                                }
                              },
                              text: S.of(context).sell,
                              color: AppColors.semantic_03),
                        ),
                      );
                    }
                    return Container();
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: AssetStockDetailOverview(
              stockModel: stockModel,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 106,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                color: themeMode.isLight ? AppColors.neutral_06 : AppColors.bg_share_inside_nav,
              ),
              child: Row(
                children: [
                  Flexible(
                    flex: 3,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: AssetGridElement(element: {
                                  S.of(context).volumn: NumUtils.formatInteger(
                                      widget.porfolioStock.actualVol)
                                }),
                              ),
                              const SizedBox(height: 2),
                              Expanded(
                                child: AssetGridElement(element: {
                                  S.of(context).bonus_sh : NumUtils.formatInteger(
                                      widget.porfolioStock.rightVol)
                                }),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 2),
                        // Expanded(
                        //   child: Column(
                        //     children: [
                        //       Expanded(
                        //         child: AssetGridElement(element: {
                        //           S.of(context).available_vol:
                        //               NumUtils.formatInteger(
                        //                   widget.porfolioStock.avaiableVol)
                        //         }),
                        //       ),
                        //       const SizedBox(height: 2),
                        //       Expanded(
                        //         child: AssetGridElement(element: {
                        //           S.of(context).avg_price: NumUtils.formatDouble(
                        //               widget.porfolioStock.avgPrice)
                        //         }),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 2),
                  Flexible(
                    flex: 2,
                    child: AssetGridElement(
                      subPadding: const EdgeInsets.symmetric(horizontal: 16),
                      contentPadding: const EdgeInsets.only(top: 4, bottom: 10),
                      element: {
                        S.of(context).bought_returning_vol: null,
                      },
                      subElements: {
                        "T0": NumUtils.formatDouble(
                            widget.porfolioStock.buyT0, "-"),
                        "T1": NumUtils.formatDouble(
                            widget.porfolioStock.buyT1, "-"),
                        "T2": NumUtils.formatDouble(
                            widget.porfolioStock.buyT2, "-"),
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    color: themeMode.isLight ? Colors.white : AppColors.bg_share_inside_nav),
                child: Column(
                  children: [
                    TabBar(
                      controller: tabController,
                      isScrollable: false,
                      labelStyle: textTheme.titleSmall,
                      labelPadding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 4),
                      tabs:  [
                        Text(
                          S.of(context).Open_command,
                        ),
                        Text(
                          S.of(context).Close_command,
                        ),
                        Text(S.of(context).history),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: TabBarView(controller: tabController, children: [
                        UnclosedDealTab(
                          stockCode: widget.stockCode,
                        ),
                        ClosedDealTab(
                          stockCode: widget.stockCode,
                        ),
                        HistoryTab(
                          stockCode: widget.stockCode,
                        )
                        // Column(
                        //   children: const [
                        //     Padding(
                        //       padding: EdgeInsets.symmetric(vertical: 16),
                        //       child: EmptyListWidget(),
                        //     )
                        //   ],
                        // )
                      ]),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
