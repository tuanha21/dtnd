import 'package:dtnd/=models=/response/account/portfolio_status_model.dart';
import 'package:dtnd/=models=/response/stock.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/ui/widget/empty_list_widget.dart';
import 'package:dtnd/ui/widget/icon/stock_icon.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../=models=/response/account/base_margin_plus_account_model.dart';

class OrderOwnedStockPanel extends StatefulWidget {
  const OrderOwnedStockPanel({super.key, this.onSell});

  final ValueChanged<PorfolioStock>? onSell;

  @override
  State<OrderOwnedStockPanel> createState() => _OrderOwnedStockPanelState();
}

class _OrderOwnedStockPanelState extends State<OrderOwnedStockPanel> {
  final IUserService userService = UserService();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final data = userService.listAccountModel.value?.firstWhereOrNull(
              (element) => element.runtimeType == BaseMarginPlusAccountModel)
          as BaseMarginPlusAccountModel?;

      final List<PorfolioStock> portfolioStocks =
          data?.portfolioStatus?.porfolioStocks ?? [];
      return portfolioStocks.isNotEmpty
          ? ListView(
              shrinkWrap: true,
              children: [
                for (PorfolioStock porfolioStock in portfolioStocks)
                  OrderOwnedStockWidget(
                    portfolioStock: porfolioStock,
                    onSell: widget.onSell,
                  )
              ],
            )
          : const Padding(
              padding: EdgeInsets.only(top: 50),
              child: EmptyListWidget(),
            );
    });
  }
}

class OrderOwnedStockWidget extends StatefulWidget {
  const OrderOwnedStockWidget(
      {super.key, required this.portfolioStock, this.onSell});

  final PorfolioStock portfolioStock;
  final ValueChanged<PorfolioStock>? onSell;

  @override
  State<OrderOwnedStockWidget> createState() => _OrderOwnedStockWidgetState();
}

class _OrderOwnedStockWidgetState extends State<OrderOwnedStockWidget> {
  Stock? stock;

  @override
  void initState() {
    super.initState();
    stock = DataCenterService().getStocksBySym(widget.portfolioStock.symbol);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Row(
          children: [
            StockIcon(stockCode: widget.portfolioStock.symbol),
            const SizedBox(width: 8),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.portfolioStock.symbol,
                  style: textTheme.titleSmall,
                ),
                Text(
                  stock?.nameShort ?? "-",
                  style: AppTextStyle.labelSmall_10
                      .copyWith(color: AppColors.neutral_03),
                ),
              ],
            )),
            Material(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              child: InkWell(
                  onTap: () => widget.onSell?.call(widget.portfolioStock),
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  child: Ink(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                    decoration: const BoxDecoration(
                      color: AppColors.semantic_03,
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    child: Text(
                      "BÁN",
                      style: AppTextStyle.labelSmall_10.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  )),
            )
          ],
        ),
        const SizedBox(height: 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "KL có thể bán",
                  style: AppTextStyle.labelSmall_10
                      .copyWith(color: AppColors.neutral_03),
                ),
                Text(
                  NumUtils.formatInteger(
                      widget.portfolioStock.avaiableVol ?? 0),
                  style: textTheme.labelMedium,
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  S.of(context).profit_and_loss,
                  style: AppTextStyle.labelSmall_10
                      .copyWith(color: AppColors.neutral_03),
                ),
                Row(
                  children: [
                    Text(
                      NumUtils.formatInteger(
                          widget.portfolioStock.gainLossValue ?? 0),
                      style: AppTextStyle.labelMedium_12
                          .copyWith(color: widget.portfolioStock.color),
                    ),
                    const SizedBox(width: 3),
                    widget.portfolioStock.prefixIcon(size: 10),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '%${S.of(context).profit_and_loss}',
                  style: AppTextStyle.labelSmall_10
                      .copyWith(color: AppColors.neutral_03),
                ),
                Row(
                  children: [
                    Text(
                      widget.portfolioStock.gainLossPer ?? "-%",
                      style: AppTextStyle.labelSmall_10.copyWith(
                          color: widget.portfolioStock.color,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Divider(),
        ),
      ],
    );
  }
}
