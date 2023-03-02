import 'package:dtnd/=models=/response/order_model/base_order_model.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/component/order_record_widget.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/sheet/cancel_order_sheet.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/sheet/change_stock_order_sheet.dart';
import 'package:flutter/material.dart';

import '../flow/flow.dart';

class IndayOrderPanel extends StatefulWidget {
  const IndayOrderPanel({super.key});

  @override
  State<IndayOrderPanel> createState() => _IndayOrderPanelState();
}

class _IndayOrderPanelState extends State<IndayOrderPanel> {
  final IUserService userService = UserService();
  List<BaseOrderModel>? listOrder;
  @override
  void initState() {
    super.initState();
    getIndayOrder();
  }

  Future<void> getIndayOrder() async {
    listOrder = await userService.getIndayOrder(
        accountCode: "${userService.token.value!.user}6", recordPerPage: 10);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> records = [];
    if (listOrder?.isNotEmpty ?? false) {
      for (BaseOrderModel record in listOrder!) {
        records.add(OrderRecordWidget(
          data: record,
        ));
      }
    }
    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Column(
            children: [
              for (int i = 0; i < (listOrder?.length ?? 0); i++)
                Column(
                  children: [
                    i != 0 ? const Divider(height: 1) : Container(),
                    OrderRecordWidget(
                      data: listOrder!.elementAt(i),
                      onChange: () async {
                        ChangeStockOrderISheet(listOrder!.elementAt(i))
                            .show(
                                context,
                                ChangeStockOrderSheet(
                                    data: listOrder!.elementAt(i)))
                            .then((value) => getIndayOrder());
                      },
                      onCancel: () async {
                        CancelStockOrderISheet(listOrder!.elementAt(i))
                            .show(
                                context,
                                CancelStockOrderSheet(
                                    data: listOrder!.elementAt(i)))
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
  }
}
