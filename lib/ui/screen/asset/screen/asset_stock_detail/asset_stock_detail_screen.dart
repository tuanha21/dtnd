import 'package:dtnd/=models=/response/account/portfolio_status_model.dart';
import 'package:dtnd/=models=/response/share_earned_model.dart';
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
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/ui/widget/button/single_color_text_button.dart';
import 'package:dtnd/ui/widget/empty_list_widget.dart';
import 'package:dtnd/ui/widget/overlay/login_first_dialog.dart';
import 'package:dtnd/ui/widget/picker/datetime_picker_widget.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:dtnd/utilities/time_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  late final TextEditingController fromdayController;
  late final TextEditingController todayController;
  late final AssetStockDetailController assetStockDetailController;
  late final TabController tabController;
  StockModel? stockModel;
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    assetStockDetailController =
        AssetStockDetailController(stockCode: widget.stockCode);
    fromdayController = TextEditingController(
        text: TimeUtilities.commonTimeFormat
            .format(DateTime.now().subtract(const Duration(days: 7))));
    todayController = TextEditingController(
        text: TimeUtilities.commonTimeFormat.format(DateTime.now()));
    assetStockDetailController.getAllShareEarned(
        fromdayController.text, todayController.text);
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
    return Scaffold(
      appBar: AssetStockDetailAppbar(
        stockCode: widget.stockCode,
        stockModel: stockModel,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        height: 48,
        child: Row(
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
                                  "CP thưởng": NumUtils.formatInteger(
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
                                      widget.porfolioStock.marketValue)
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
                        UnclosedDealTab(
                          stockCode: widget.stockCode,
                        ),
                        Column(
                          children: [
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                    child: DateTimePickerWidget(
                                  controller: fromdayController,
                                  labelText: S.of(context).from_day,
                                  onChanged: (value) =>
                                      assetStockDetailController
                                          .getAllShareEarned(
                                              fromdayController.text,
                                              todayController.text),
                                )),
                                const SizedBox(width: 16),
                                Expanded(
                                    child: DateTimePickerWidget(
                                  controller: todayController,
                                  labelText: S.of(context).to_day,
                                  onChanged: (value) =>
                                      assetStockDetailController
                                          .getAllShareEarned(
                                              fromdayController.text,
                                              todayController.text),
                                ))
                              ],
                            ),
                            const SizedBox(height: 8),
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
                                      Obx(() {
                                        // print(assetStockDetailController
                                        //     .shareEarnedModel
                                        //     .value
                                        //     ?.cEARNEDVALUE);
                                        return Text(
                                          "${NumUtils.formatInteger(assetStockDetailController.shareEarnedModel.value?.cEARNEDVALUE ?? 0)}đ",
                                          style: textTheme.labelMedium,
                                        );
                                      }),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Obx(() {
                              // print(assetStockDetailController
                              //     .shareEarnedModel.value?.listDetail.length);
                              if (assetStockDetailController.shareEarnedModel
                                      .value?.listDetail.isEmpty ??
                                  true) {
                                return const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  child: EmptyListWidget(),
                                );
                              }
                              return Container(
                                padding: const EdgeInsets.all(16),
                                decoration: const BoxDecoration(
                                    color: AppColors.neutral_06,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12))),
                                child: Column(
                                  children: [
                                    for (ShareEarnedDetailModel detail
                                        in assetStockDetailController
                                            .shareEarnedModel.value!.listDetail)
                                      Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  SizedBox.square(
                                                      dimension: 20,
                                                      child: Image.asset(
                                                          AppImages
                                                              .calendar_2)),
                                                  const SizedBox(width: 8),
                                                  Text(detail.cTRADINGDATE ??
                                                      "-"),
                                                ],
                                              ),
                                              Text(
                                                "Đã khớp",
                                                style: AppTextStyle
                                                    .bodyMedium_14
                                                    .copyWith(
                                                        color: AppColors
                                                            .semantic_01),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 6),
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    S.of(context).volumn,
                                                    style: AppTextStyle
                                                        .labelSmall_10
                                                        .copyWith(
                                                      color:
                                                          AppColors.neutral_03,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  Text(
                                                    NumUtils.formatInteger(
                                                        detail.cSHAREVOLUME ??
                                                            0),
                                                    style: AppTextStyle
                                                        .labelSmall_10,
                                                  )
                                                ],
                                              )),
                                              Expanded(
                                                  child: Column(
                                                children: [
                                                  Text(
                                                    "Giá bán",
                                                    style: AppTextStyle
                                                        .labelSmall_10
                                                        .copyWith(
                                                      color:
                                                          AppColors.neutral_03,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  Text(
                                                    NumUtils.formatInteger(
                                                        (detail.cSHAREPRICE ??
                                                                0) /
                                                            1000),
                                                    style: AppTextStyle
                                                        .labelSmall_10,
                                                  )
                                                ],
                                              )),
                                              Expanded(
                                                  child: Column(
                                                children: [
                                                  Text(
                                                    "Giá vốn",
                                                    style: AppTextStyle
                                                        .labelSmall_10
                                                        .copyWith(
                                                      color:
                                                          AppColors.neutral_03,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  Text(
                                                    NumUtils.formatInteger(
                                                        (detail.cAVERAGEPRICE ??
                                                                0) /
                                                            1000),
                                                    style: AppTextStyle
                                                        .labelSmall_10,
                                                  )
                                                ],
                                              )),
                                              Expanded(
                                                  child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    "Lãi/lỗ",
                                                    style: AppTextStyle
                                                        .labelSmall_10
                                                        .copyWith(
                                                      color:
                                                          AppColors.neutral_03,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  Text(
                                                    NumUtils.formatInteger(
                                                        (detail.cEARNEDVALUE ??
                                                            0)),
                                                    style: AppTextStyle
                                                        .labelSmall_10,
                                                  )
                                                ],
                                              ))
                                            ],
                                          ),
                                        ],
                                      )
                                  ],
                                ),
                              );
                            })
                          ],
                        ),
                        Column(
                          children: const [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: EmptyListWidget(),
                            )
                          ],
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
