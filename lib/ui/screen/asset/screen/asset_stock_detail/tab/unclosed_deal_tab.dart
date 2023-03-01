import 'package:dtnd/=models=/response/order_history_model.dart';
import 'package:dtnd/data/i_exchange_service.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/exchange_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/ui/screen/asset/screen/asset_stock_detail/component/unclosed_deal_element.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/utilities/logger.dart';
import 'package:flutter/material.dart';

class UnclosedDealTab extends StatefulWidget {
  const UnclosedDealTab({super.key, required this.stockCode});
  final String stockCode;
  @override
  State<UnclosedDealTab> createState() => _UnclosedDealTabState();
}

class _UnclosedDealTabState extends State<UnclosedDealTab> {
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
        stockCode: widget.stockCode);
    logger.v(res);
    if (res.isNotEmpty) {
      list.addAll(res);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: AppColors.neutral_06),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Deal chưa khớp",
                    style: textTheme.labelMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "0",
                    style: textTheme.labelMedium,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Tổng giá vốn",
                    style: textTheme.labelMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "0",
                    style: textTheme.labelMedium,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Lãi/lỗ chưa đóng",
                    style: textTheme.labelMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
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
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
              color: AppColors.neutral_06,
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Column(
            children: [
              for (OrderHistoryModel model in list)
                UnclosedDealElement(model: model)
            ],
          ),
        )
      ],
    );
  }
}
