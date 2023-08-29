import 'package:dtnd/=models=/response/order_history_model.dart';
import 'package:dtnd/=models=/ui_model/user_cmd.dart';
import 'package:dtnd/data/i_exchange_service.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/exchange_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/exchange_stock/order_note/component/order_history_element.dart';
import 'package:dtnd/ui/screen/exchange_stock/order_note/data/order_filter_data.dart';
import 'package:dtnd/ui/screen/exchange_stock/order_note/sheet/order_filter_flow.dart';
import 'package:dtnd/ui/screen/exchange_stock/order_note/sheet/order_filter_sheet.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/widget/calendar/day_input.dart';
import 'package:dtnd/ui/widget/empty_list_widget.dart';
import 'package:dtnd/utilities/time_utils.dart';
import 'package:flutter/material.dart';

import '../../../../../config/service/app_services.dart';

class OrderHistoryTab extends StatefulWidget {
  const OrderHistoryTab({super.key});

  @override
  State<OrderHistoryTab> createState() => _OrderHistoryTabState();
}

class _OrderHistoryTabState extends State<OrderHistoryTab> {
  final IUserService userService = UserService();
  final IExchangeService exchangeService = ExchangeService();

  late DateTime fromDay;
  late DateTime toDay;
  late DateTime firstDay;
  late DateTime lastDay;

  List<OrderHistoryModel>? listOrder;
  List<OrderHistoryModel>? listOrderShow;
  OrderFilterData? orderFilterData;

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

  Future<void> getData(
      {DateTime? fromDay, DateTime? toDay, int? recordPerPage}) async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 1));

    listOrder = await exchangeService.getOrdersHistory(userService,
        fromDay: fromDay, toDay: toDay, recordPerPage: recordPerPage);
    listOrderShow = List<OrderHistoryModel>.from(listOrder ?? []);
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void filter(OrderFilterData data) {
    orderFilterData = data;
    listOrderShow = List<OrderHistoryModel>.from(listOrder ?? []);
    List<OrderHistoryModel> toRemove = [];
    if (data.orderType != null) {
      for (var i = 0; i < listOrderShow!.length; i++) {
        if (listOrderShow!.elementAt(i).side == data.orderType) {
          toRemove.add(listOrderShow!.elementAt(i));
        }
      }
      listOrderShow!.removeWhere((e) => toRemove.contains(e));
    }
    toRemove = [];
    if (data.orderStatus != null) {
      for (var i = 0; i < listOrderShow!.length; i++) {
        if (!(data.orderStatus!
            .contains(listOrderShow!.elementAt(i).orderStatus))) {
          toRemove.add(listOrderShow!.elementAt(i));
        }
      }
      listOrderShow!.removeWhere((e) => toRemove.contains(e));
    }
    setState(() {});
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      getData(recordPerPage: listOrderShow!.length + 5);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final ThemeMode themeMode = AppService.instance.themeMode.value;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Column(
        children: [
          const SizedBox(height: 8),
          Row(
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
                  }),
              const SizedBox(
                width: 16,
                child: Text('-'),
              ),
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
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).order_type,
                style: textTheme.titleSmall,
              ),
              Material(
                borderRadius: const BorderRadius.all(Radius.circular(6)),
                child: InkWell(
                  onTap: () {
                    IOrderFilterISheet()
                        .show(
                            context,
                            OrderFilterSheet(
                              data: orderFilterData,
                            ))
                        .then((value) {
                      if (value is NextCmd) {
                        filter(value.data);
                      }
                    });
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                  child: Ink(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: AppColors.primary_03,
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                    child: SizedBox.square(
                        dimension: 16,
                        child: Image.asset(AppImages.filter_icon,
                            color: themeMode.isLight
                                ? null
                                : AppColors.neutral_01)),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(child: Builder(
            builder: (context) {
              if (listOrderShow?.isEmpty ?? true) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: EmptyListWidget(),
                );
              }
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: themeMode.isLight
                        ? Colors.white
                        : AppColors.text_black_1,
                    borderRadius: const BorderRadius.all(Radius.circular(12))),
                child: ListView.builder(
                  shrinkWrap: true,
                  controller: _scrollController,
                  itemCount: listOrderShow!.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index < listOrderShow!.length) {
                      return Column(
                        children: [
                          index != 0
                              ? const Divider(
                                  height: 1,
                                  color: AppColors.neutral_03,
                                )
                              : Container(),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: OrderHistoryElement(
                                model: listOrderShow!.elementAt(index)),
                          ),
                        ],
                      );
                    } else if (index == listOrderShow!.length && isLoading) {
                      return _buildLoader();
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              );
            },
          ))
        ],
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
