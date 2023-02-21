import 'package:dtnd/=models=/response/account/base_margin_account_model.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/asset/component/investment_catalog_widget.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/i_data_center_service.dart';
import '../../../../data/i_user_service.dart';
import '../../../../data/implementations/data_center_service.dart';
import '../../../../data/implementations/user_service.dart';
import '../../../widget/tabbar/rounded_tabbar.dart';
import 'buy_right_widget.dart';

class PortfolioAndRightPanel extends StatefulWidget {
  const PortfolioAndRightPanel({super.key});

  @override
  State<PortfolioAndRightPanel> createState() => _PortfolioAndRightPanelState();
}

class _PortfolioAndRightPanelState extends State<PortfolioAndRightPanel>
    with SingleTickerProviderStateMixin {
  final IUserService userService = UserService();
  final IDataCenterService dataCenterService = DataCenterService();
  late final TabController _tabController;

  void rebuild() => setState(() {});

  void changeChart() {
    setState(() {
      showTotalAsset = !showTotalAsset;
    });
  }

  bool showTotalAsset = true;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    _tabController.addListener(() {
      if (_tabController.index != _tabController.previousIndex) {
        setState(() {});
      }
    });
    // userService.listAccountModel.listen((model) {
    //   if (model != null && data == null) {
    //     setState(() {
    //       data = model.firstWhereOrNull(
    //               (element) => element.runtimeType == BaseMarginAccountModel)
    //           as BaseMarginAccountModel?;
    //     });
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 40,
            child: RoundedTabbar(
              isScrollable: false,
              controller: _tabController,
              tabs: [
                Text(S.of(context).catalog),
                Text(S.of(context).right),
              ],
            ),
          ),
          if (_tabController.index == 0)
            Container(
              height: 88,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Obx(() {
                      final data = userService.listAccountModel.value
                              ?.firstWhereOrNull((element) =>
                                  element.runtimeType == BaseMarginAccountModel)
                          as BaseMarginAccountModel?;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Tổng danh mục",
                            style: textTheme.labelMedium?.copyWith(
                              color: AppColors.neutral_03,
                            ),
                          ),
                          Text(
                            "${NumUtils.formatDouble(data?.portfolioStatus?.marketValue)}đ",
                            style: textTheme.titleSmall,
                          ),
                        ],
                      );
                    }),
                  ),
                  Expanded(
                    child: Obx(() {
                      final data = userService.listAccountModel.value
                              ?.firstWhereOrNull((element) =>
                                  element.runtimeType == BaseMarginAccountModel)
                          as BaseMarginAccountModel?;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Lãi/lỗ chưa đóng",
                            style: textTheme.labelMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.neutral_03,
                            ),
                          ),
                          Flexible(
                            child: Row(
                              children: [
                                if (data?.portfolioStatus?.prefixIcon != null)
                                  Image.asset(
                                    data?.portfolioStatus?.prefixIcon ?? "",
                                    width: 10,
                                    color: data?.portfolioStatus?.color,
                                  ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: FittedBox(
                                    child: Text(
                                      "${NumUtils.formatDouble(data?.portfolioStatus?.gainLossValue)}đ (${data?.portfolioStatus?.gainLossPer?.trim()})",
                                      overflow: TextOverflow.ellipsis,
                                      style: textTheme.titleSmall!.copyWith(
                                          color: data?.portfolioStatus?.color),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
                  )
                ],
              ),
            ),
          Obx(() {
            final data = userService.listAccountModel.value?.firstWhereOrNull(
                    (element) => element.runtimeType == BaseMarginAccountModel)
                as BaseMarginAccountModel?;

            if (_tabController.index == 0) {
              return Column(
                children: [
                  for (int i = 0;
                      i < (data?.portfolioStatus?.porfolioStocks?.length ?? 0);
                      i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: InvestmentCatalogWidget(
                        data:
                            data!.portfolioStatus!.porfolioStocks!.elementAt(i),
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
            } else {
              return Column(
                children: [
                  for (int i = 0;
                      i < (data?.listUnexecutedRight?.length ?? 0);
                      i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: BuyRightWidget(
                        data: data!.listUnexecutedRight!.elementAt(i),
                      ),
                    )
                ],
              );
            }
          }),
        ],
      ),
    );
  }
}
