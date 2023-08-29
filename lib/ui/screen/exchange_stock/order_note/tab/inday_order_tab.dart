import 'package:dtnd/=models=/response/order_model/base_order_model.dart';
import 'package:dtnd/=models=/ui_model/user_cmd.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/ui/screen/exchange_stock/order_note/data/order_filter_data.dart';
import 'package:dtnd/ui/screen/exchange_stock/order_note/flow/flow.dart';
import 'package:dtnd/ui/screen/exchange_stock/order_note/sheet/order_filter_flow.dart';
import 'package:dtnd/ui/screen/exchange_stock/order_note/sheet/order_filter_sheet.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/component/order_record_widget.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/sheet/cancel_order_sheet.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/sheet/change_stock_order_sheet.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/widget/empty_list_widget.dart';
import 'package:flutter/material.dart';

import '../../../../../config/service/app_services.dart';
import '../../../../../generated/l10n.dart';

class IndayOrderTab extends StatefulWidget {
  const IndayOrderTab({super.key});

  @override
  State<IndayOrderTab> createState() => _IndayOrderTabState();
}

class _IndayOrderTabState extends State<IndayOrderTab> {
  final IUserService userService = UserService();
  List<BaseOrderModel>? listOrder;
  List<BaseOrderModel>? listOrderShow;
  OrderFilterData? orderFilterData;
  bool isLoading = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(_scrollListener);
    super.initState();
    getIndayOrder();
  }

  Future<void> getIndayOrder({int? recordPerPage}) async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 1));

    listOrder = await userService.getIndayOrder(
        accountCode: "${userService.token.value!.user}9",
        recordPerPage: recordPerPage);
    listOrderShow = List<BaseOrderModel>.from(listOrder ?? []);
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void filter(OrderFilterData data) {
    orderFilterData = data;
    listOrderShow = List<BaseOrderModel>.from(listOrder ?? []);
    List<BaseOrderModel> toRemove = [];
    if (data.orderType != null) {
      for (var i = 0; i < listOrderShow!.length; i++) {
        if (listOrderShow!.elementAt(i).side != data.orderType) {
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
      // Đã cuộn xuống dưới cùng
      getIndayOrder(recordPerPage: listOrderShow!.length + 5);
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
                        child: Image.asset(AppImages.filter_icon)),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          listOrderShow?.isEmpty == false
              ? Expanded(child: Builder(
                  builder: (context) {
                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: themeMode.isLight ? Colors.white : AppColors.text_black_1,
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: ListView.builder(
                          shrinkWrap: true,
                          controller: _scrollController,
                          itemCount: listOrderShow!.length + 1,
                          itemBuilder: (BuildContext context, int index) {
                            if (index < listOrderShow!.length) {
                              return Column(
                                children: [
                                  index != 0
                                      ? const Divider(height: 1)
                                      : Container(),
                                  OrderRecordWidget(
                                    data: listOrderShow!.elementAt(index),
                                    onChange: () async {
                                      ChangeStockOrderISheet(
                                              listOrderShow!.elementAt(index))
                                          .show(
                                              context,
                                              ChangeStockOrderSheet(
                                                  data: listOrderShow!
                                                      .elementAt(index)))
                                          .then((value) => getIndayOrder());
                                    },
                                    onCancel: () async {
                                      CancelStockOrderISheet(
                                              listOrderShow!.elementAt(index))
                                          .show(
                                              context,
                                              CancelStockOrderSheet(
                                                  data: listOrderShow!
                                                      .elementAt(index)))
                                          .then((value) => getIndayOrder());
                                    },
                                  )
                                ],
                              );
                            } else if (index == listOrderShow!.length &&
                                isLoading) {
                              return _buildLoader();
                            } else {
                              return const SizedBox.shrink();
                            }
                          }),
                    );
                  },
                ))
              : const Padding(
                  padding: EdgeInsets.only(top: 100),
                  child: EmptyListWidget(),
                )
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
