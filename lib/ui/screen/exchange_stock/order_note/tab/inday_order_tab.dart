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
  @override
  void initState() {
    super.initState();
    getIndayOrder();
  }

  Future<void> getIndayOrder() async {
    listOrder = await userService.getIndayOrder(
        accountCode: "${userService.token.value!.user}9", recordPerPage: 10);
    listOrderShow = List<BaseOrderModel>.from(listOrder ?? []);
    if (mounted) {
      setState(() {});
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
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
     return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Loại lệnh",
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
         listOrderShow?.isEmpty == false ?
          Expanded(child: Builder(
            builder: (context) {
              return ListView(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    child: Column(
                      children: [
                        for (int i = 0; i < (listOrderShow?.length ?? 0); i++)
                          Column(
                            children: [
                              i != 0 ? const Divider(height: 1) : Container(),
                              OrderRecordWidget(
                                data: listOrderShow!.elementAt(i),
                                onChange: () async {
                                  ChangeStockOrderISheet(
                                          listOrderShow!.elementAt(i))
                                      .show(
                                          context,
                                          ChangeStockOrderSheet(
                                              data:
                                                  listOrderShow!.elementAt(i)))
                                      .then((value) => getIndayOrder());
                                },
                                onCancel: () async {
                                  CancelStockOrderISheet(
                                          listOrderShow!.elementAt(i))
                                      .show(
                                          context,
                                          CancelStockOrderSheet(
                                              data:
                                                  listOrderShow!.elementAt(i)))
                                      .then((value) => getIndayOrder());
                                },
                              )
                            ],
                          )
                      ],
                    ),
                  ),
                ],
              );
            },
          )) : const Padding(
            padding: EdgeInsets.only(top: 100),
            child: EmptyListWidget(),
          )
        ],
      ),
    );
  }
}
