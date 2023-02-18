import 'package:dtnd/=models=/response/account/portfolio_status_model.dart';
import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/asset/component/asset_grid_element.dart';
import 'package:dtnd/ui/screen/asset/screen/asset_stock_detail/component/asset_stock_detail_appbar.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';

import 'component/asset_stock_detail_overview.dart';

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
  late final TabController tabController;
  StockModel? stockModel;
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
    getData(widget.stockCode);
  }

  Future<void> getData(String stockCode) async {
    final data =
        await dataCenterService.getStockModelsFromStockCodes([stockCode]);
    if (data?.isNotEmpty ?? false) {
      setState(() {
        stockModel = data!.first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AssetStockDetailAppbar(
        stockCode: widget.stockCode,
        stockModel: stockModel,
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
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                color: AppColors.neutral_06,
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
                                  S.of(context).net_assets:
                                      NumUtils.formatInteger(
                                          widget.porfolioStock.rightVol)
                                }),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 2),
                        Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: AssetGridElement(element: {
                                  S.of(context).available_vol:
                                      NumUtils.formatInteger(
                                          widget.porfolioStock.avaiableVol)
                                }),
                              ),
                              const SizedBox(height: 2),
                              Expanded(
                                child: AssetGridElement(element: {
                                  S.of(context).mk_value: NumUtils.formatDouble(
                                      widget.porfolioStock.marketPrice)
                                }),
                              ),
                            ],
                          ),
                        ),
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
                        S.of(context).sold_returning_vol: null,
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
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    color: Colors.white),
                child: Column(
                  children: [
                    TabBar(
                      controller: tabController,
                      isScrollable: false,
                      labelStyle: textTheme.titleSmall,
                      labelPadding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 4),
                      tabs: const [
                        Text(
                          "Deal chưa khớp",
                        ),
                        Text(
                          "Deal đã khớp",
                        ),
                        Text("Lịch sử"),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: TabBarView(controller: tabController, children: [
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  color: AppColors.neutral_06),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Deal chưa khớp",
                                        style: textTheme.labelMedium?.copyWith(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        "0",
                                        style: textTheme.labelMedium,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Tổng giá vốn",
                                        style: textTheme.labelMedium?.copyWith(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        "0",
                                        style: textTheme.labelMedium,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Lãi/lỗ chưa đóng",
                                        style: textTheme.labelMedium?.copyWith(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        "0",
                                        style: textTheme.labelMedium,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  color: AppColors.neutral_06),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Tổng lãi/lỗ đã đóng",
                                        style: textTheme.labelMedium?.copyWith(
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        "0",
                                        style: textTheme.labelMedium,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [],
                        )
                      ]),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
