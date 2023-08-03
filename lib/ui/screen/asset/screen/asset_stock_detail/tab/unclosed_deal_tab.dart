import 'package:dtnd/=models=/response/order_history_model.dart';
import 'package:dtnd/=models=/side.dart';
import 'package:dtnd/data/i_exchange_service.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/exchange_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/ui/screen/asset/screen/asset_stock_detail/component/unclosed_deal_element.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/widget/empty_list_widget.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';

import '../../../../../../config/service/app_services.dart';
import '../../../../../../generated/l10n.dart';

class UnclosedDealTab extends StatefulWidget {
  const UnclosedDealTab({super.key, required this.stockCode});

  final String stockCode;

  @override
  State<UnclosedDealTab> createState() => _UnclosedDealTabState();
}

class _UnclosedDealTabState extends State<UnclosedDealTab>
    with AutomaticKeepAliveClientMixin {
  final IUserService userService = UserService();
  final IExchangeService exchangeService = ExchangeService();

  final List<OrderHistoryModel> list = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    list.clear();
    final res = await exchangeService.getOrdersHistory(userService,
        stockCode: widget.stockCode, status: "M");
    // logger.v(res);
    if (res.isNotEmpty) {
      for (OrderHistoryModel data in res) {
        if (data.side == Side.buy) {
          list.add(data);
        }
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final textTheme = Theme.of(context).textTheme;
    final portfolioStocks =
        userService.defaultAccount.value?.portfolioStatus?.porfolioStocks;

    final gainLossValue = portfolioStocks
        ?.firstWhere((element) => element.symbol == widget.stockCode)
        .gainLossValue;

    final actualVol = portfolioStocks
        ?.firstWhere((element) => element.symbol == widget.stockCode)
        .actualVol;
    final ThemeMode themeMode = AppService.instance.themeMode.value;

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                color: themeMode.isLight ? AppColors.neutral_06 : AppColors.text_black_1),
            child: Column(
              children: [
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text(
                //       "Deal chưa khớp",
                //       style: textTheme.labelMedium
                //           ?.copyWith(fontWeight: FontWeight.w600),
                //     ),
                //     Text(
                //       "0",
                //       style: textTheme.labelMedium,
                //     ),
                //   ],
                // ),
                // const SizedBox(height: 8),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text(
                //       "Tổng giá vốn",
                //       style: textTheme.labelMedium
                //           ?.copyWith(fontWeight: FontWeight.w600),
                //     ),
                //     Text(
                //       "0",
                //       style: textTheme.labelMedium,
                //     ),
                //   ],
                // ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).total_unclosed_profit_loss,
                      style: textTheme.labelMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '${NumUtils.formatDouble(gainLossValue)}đ',
                      style: textTheme.labelMedium,
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 6),
          actualVol != 0
              ? Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: themeMode.isLight ? AppColors.neutral_06 : AppColors.text_black_1,
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: Column(
                    children: [
                      if (list.isEmpty)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: EmptyListWidget(),
                        ),
                      for (int i = 0; i < list.length; i++)
                        Column(
                          children: [
                            if (i != 0)
                              const Divider(
                                height: 17,
                              ),
                            UnclosedDealElement(model: list.elementAt(i)),
                          ],
                        )
                    ],
                  ),
                )
              : const EmptyListWidget(),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
