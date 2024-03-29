import 'package:dtnd/=models=/response/account/cash_transaction_model.dart';
import 'package:dtnd/data/i_exchange_service.dart';
import 'package:dtnd/data/implementations/exchange_service.dart';
import 'package:dtnd/l10n/generated/l10n.dart';
import 'package:dtnd/ui/screen/account/component/cash_transaction_component.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/theme/app_textstyle.dart';
import 'package:dtnd/ui/widget/appbar/simple_appbar.dart';
import 'package:dtnd/ui/widget/calendar/day_input.dart';
import 'package:dtnd/ui/widget/empty_list_widget.dart';
import 'package:dtnd/utilities/num_utils.dart';
import 'package:dtnd/utilities/time_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/service/app_services.dart';

class MoneyStatementSheet extends StatefulWidget {
  const MoneyStatementSheet({super.key});

  @override
  State<MoneyStatementSheet> createState() => _MoneyStatementSheetState();
}

class _MoneyStatementSheetState extends State<MoneyStatementSheet> {
  final IExchangeService exchangeService = ExchangeService();

  final List<CashTransactionHistoryModel> list = [];
  TotalCashTransactionModel? total;
  late DateTime fromDay;
  late DateTime toDay;
  late DateTime firstDay;
  late DateTime lastDay;
  bool isLoading = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    fromDay = TimeUtilities.getPreviousDateTime(TimeUtilities.month(1));
    toDay = DateTime.now();
    firstDay = TimeUtilities.getPreviousDateTime(TimeUtilities.month(3));
    lastDay = toDay;
    _scrollController.addListener(_scrollListener);
    super.initState();
    getData();
  }

  Future<void> getData({int? recordPerPage}) async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 1));
    final res = await exchangeService.getCashTransactions(
      fromDay: fromDay,
      toDay: toDay,
    );
    list.clear();
    total = res.total;
    list.addAll(res.listHistory.reversed);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(
        _scrollListener); // Hủy lắng nghe sự kiện cuộn khi dispose
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      // Đã cuộn xuống dưới cùng
      getData(
          recordPerPage: list.length +
              5); // Gọi hàm getData với recordPerPage tăng thêm 5 đơn vị
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final ThemeMode themeMode = AppService.instance.themeMode.value;

    return Scaffold(
      appBar: SimpleAppbar(
        title: S.of(context).money_statement,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(height: 1).paddingZero,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DayInput(
                    color: themeMode.isLight
                        ? AppColors.neutral_06
                        : AppColors.text_black_1,
                    initialDay: fromDay,
                    firstDay: firstDay,
                    lastDay: lastDay,
                    onChanged: (value) {
                      setState(() {
                        fromDay = value;
                      });
                      getData();
                    },
                  ),
                  const Text("-"),
                  DayInput(
                    color: themeMode.isLight
                        ? AppColors.neutral_06
                        : AppColors.text_black_1,
                    initialDay: toDay,
                    firstDay: firstDay,
                    lastDay: lastDay,
                    onChanged: (value) {
                      setState(() {
                        toDay = value;
                      });
                      getData();
                    },
                  )
                ],
              ),
            ),
            Expanded(child: Builder(builder: (context) {
              if (list.isEmpty || total == null) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    EmptyListWidget(),
                  ],
                );
              } else {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SizedBox.square(
                                dimension: 40,
                                child:
                                    Image.asset(AppImages.blue_chart_star_icon),
                              ),
                              const SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    S.of(context).opening_balance,
                                    style: AppTextStyle.labelMedium_12.copyWith(
                                      color: AppColors.neutral_03,
                                    ),
                                  ),
                                  Text(
                                    NumUtils.formatInteger(
                                        total!.cCASHFISRTBALANCE ?? 0),
                                    style: textTheme.titleSmall,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                S.of(context).closing_balance,
                                style: AppTextStyle.labelMedium_12.copyWith(
                                  color: AppColors.neutral_03,
                                ),
                              ),
                              Text(
                                NumUtils.formatInteger(
                                    total!.cCASHCLOSEBALANCE ?? 0),
                                style: textTheme.titleSmall,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        controller: _scrollController,
                        shrinkWrap: true,
                        itemCount: list.length + 1,
                        itemBuilder: (context, index) {
                          if (index < list.length) {
                            return CashTransactionComponent(
                              data: list.elementAt(index),
                            );
                          } else if (index == list.length && isLoading) {
                            return _buildLoader();
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      ),
                    ),
                  ],
                );
              }
            }))
          ],
        ),
      ),
    );
  }
}

Widget _buildLoader() {
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.symmetric(vertical: 16.0),
    child: const CircularProgressIndicator(),
  );
}
