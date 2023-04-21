import 'package:dtnd/=models=/response/order_model/base_order_model.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/ui/widget/empty_list_widget.dart';
import 'package:flutter/material.dart';

import 'order_record_widget.dart';

class OrderOrderNotePanel extends StatefulWidget {
  const OrderOrderNotePanel(
      {super.key,
      required this.onChangedOrder,
      required this.onCancelledOrder});
  final ValueChanged<BaseOrderModel> onChangedOrder;
  final ValueChanged<BaseOrderModel> onCancelledOrder;
  @override
  State<OrderOrderNotePanel> createState() => _OrderOrderNotePanelState();
}

class _OrderOrderNotePanelState extends State<OrderOrderNotePanel> {
  final IUserService userService = UserService();
  List<BaseOrderModel>? listOrder;
  @override
  void initState() {
    super.initState();
    getIndayOrder();
  }

  Future<void> getIndayOrder() async {
    listOrder = await userService.getIndayOrder(
        accountCode: userService.token.value!.defaultAcc, recordPerPage: 3);
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
          onChange: () => widget.onChangedOrder.call(record),
          onCancel: () => widget.onCancelledOrder.call(record),
        ));
      }
    }
    return Column(
      children: records.isNotEmpty
          ? records
          : [
              const Padding(
                padding: EdgeInsets.only(top: 50),
                child: EmptyListWidget(),
              )
            ],
    );
  }
}
