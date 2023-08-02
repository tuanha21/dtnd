import 'package:dtnd/=models=/response/account/i_account.dart';
import 'package:dtnd/data/implementations/network_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/asset/component/investment_catalog_widget.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/ui/widget/empty_list_widget.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../=models=/response/account/base_margin_plus_account_model.dart';
import '../../../../config/service/app_services.dart';
import '../../../../data/i_data_center_service.dart';
import '../../../../data/i_user_service.dart';
import '../../../../data/implementations/data_center_service.dart';
import '../../../../data/implementations/user_service.dart';
import '../../../widget/tabbar/rounded_tabbar.dart';
import 'buy_right_widget.dart';

class PortfolioAndRightPanel extends StatefulWidget {
  const PortfolioAndRightPanel({super.key, this.account});

  final IAccountModel? account;

  @override
  State<PortfolioAndRightPanel> createState() => _PortfolioAndRightPanelState();
}

class _PortfolioAndRightPanelState extends State<PortfolioAndRightPanel>
    with SingleTickerProviderStateMixin {
  final IUserService userService = UserService();
  final IDataCenterService dataCenterService = DataCenterService();
  late final TabController _tabController;

  void changeChart() {
    setState(() {
      showTotalAsset = !showTotalAsset;
    });
  }

  bool showTotalAsset = true;
  bool showProfitAndLoss = false;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    _tabController.addListener(() {
      if (_tabController.index != _tabController.previousIndex) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // final textTheme = Theme.of(context).textTheme;
    final themeMode = AppService.instance.themeMode.value;
    final ThemeData themeData = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: themeMode.isLight ? AppColors.neutral_07 : AppColors.text_black_1,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
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
              height: 56,
              decoration: BoxDecoration(
                color: themeMode.isLight ? AppColors.neutral_07 : AppColors.text_black_1,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              child: Obx(() {
                final data = userService.defaultAccount.value
                    as BaseMarginPlusAccountModel?;
                if (data?.portfolioStatus?.porfolioStocks?.isNotEmpty ??
                    false) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            S.of(context).total_unclosed_profit_loss,
                            style: AppTextStyle.labelMedium_12.copyWith(
                              color: AppColors.neutral_03,
                            ),
                          ),
                          const SizedBox(width: 4),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                showProfitAndLoss = !showProfitAndLoss;
                              });
                            },
                            child: Icon(
                              showProfitAndLoss
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              size: 16,
                              weight: 300,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          if (data?.portfolioStatus?.prefixIcon != null)
                            Image.asset(
                              data?.portfolioStatus?.prefixIcon ?? "",
                              width: 10,
                              color: data?.portfolioStatus?.color,
                            ),
                          const SizedBox(width: 6),
                          Text(
                            "${showProfitAndLoss ? NumUtils.formatDouble(data?.portfolioStatus?.gainLossValue) : "********"}đ (${data?.portfolioStatus?.gainLossPer?.trim() ?? "-"})",
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyle.titleSmall_14
                                .copyWith(color: data?.portfolioStatus?.color),
                          ),
                        ],
                      ),
                    ],
                  );
                } else {
                  return Container();
                }
              }),
            ),
          Obx(() {
            final account =
                userService.defaultAccount.value as BaseMarginPlusAccountModel?;

            if (_tabController.index == 0) {
              if (account?.portfolioStatus?.porfolioStocks?.isEmpty ?? true) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: EmptyListWidget(),
                );
              }
              return Column(
                children: [
                  for (int i = 0;
                      i <
                          (account?.portfolioStatus?.porfolioStocks?.length ??
                              0);
                      i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: InvestmentCatalogWidget(
                        showFullMode: showProfitAndLoss,
                        data: account!.portfolioStatus!.porfolioStocks!
                            .elementAt(i),
                        volPc: (account.portfolioStatus!.porfolioStocks!
                                    .elementAt(i)
                                    .marketValue ??
                                0) /
                            (account.portfolioStatus!.marketValue ?? 1) *
                            100,
                      ),
                    )
                ],
              );
            } else {
              if (account?.listUnexecutedBuyRight.isEmpty ?? true) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: EmptyListWidget(),
                );
              }

              return Column(
                children: [
                  for (int i = 0;
                      i < (account?.listUnexecutedBuyRight.length ?? 0);
                      i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: BuyRightWidget(
                        accountModel: account!,
                        data: account.listUnexecutedBuyRight.elementAt(i),
                        onSuccessExecute: () => account.getListUnexecutedRight(
                            userService, NetworkService()),
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
