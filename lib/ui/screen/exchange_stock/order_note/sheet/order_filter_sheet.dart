import 'package:dtnd/=models=/response/order_model/i_order_model.dart';
import 'package:dtnd/=models=/side.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/exchange_stock/order_note/data/order_filter_data.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/widget/button/single_color_text_button.dart';
import 'package:dtnd/ui/widget/checkbox/circle_checkbox_with_title.dart';
import 'package:dtnd/ui/widget/icon/sheet_header.dart';
import 'package:flutter/material.dart';

class OrderFilterSheet extends StatefulWidget {
  const OrderFilterSheet({super.key, this.data});
  final OrderFilterData? data;
  @override
  State<OrderFilterSheet> createState() => _OrderFilterSheetState();
}

class _OrderFilterSheetState extends State<OrderFilterSheet> {
  late final OrderFilterData orderFilterData;

  @override
  void initState() {
    super.initState();
    if (widget.data == null) {
      orderFilterData = OrderFilterData();
    } else {
      orderFilterData = widget.data!;
    }
  }

  void onSideChanged(Side? side) {
    orderFilterData.orderType = side;
  }

  void onOrderStatusChanged(OrderStatus? orderStatus) {
    orderFilterData.orderStatus = orderStatus;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeMode themeMode = AppService.instance.themeMode.value;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SheetHeader(
              implementBackButton: false,
              title: S.of(context).filter,
            ),
            const SizedBox(height: 20),
            _FilterField<Side>(
              title: S.of(context).order_type,
              values: const [null, ...Side.values],
              name: (Side? value) => value?.name(context) ?? S.of(context).all,
              onChanged: onSideChanged,
            ),
            const SizedBox(height: 20),
            _FilterField<OrderStatus>(
              title: S.of(context).order_type,
              values: const [null, ...OrderStatus.values],
              name: (OrderStatus? value) =>
                  value?.statusName(context) ?? S.of(context).all,
              onChanged: onOrderStatusChanged,
            ),
            const SizedBox(height: 20),
            SingleColorTextButton(
              color: AppColors.primary_01,
              text: "Áp dụng",
              onTap: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    );
  }
}

class _FilterField<T> extends StatefulWidget {
  const _FilterField(
      {this.onChanged,
      required this.values,
      required this.title,
      required this.name});
  final ValueChanged<T?>? onChanged;
  final List<T?> values;
  final String Function(T?) name;
  final String title;
  @override
  State<_FilterField<T>> createState() => __FilterFieldState<T>();
}

class __FilterFieldState<T> extends State<_FilterField<T>> {
  void onChanged(T? value, bool isCheck) {
    if (!isCheck) {}
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title),
        for (int i = 0; i < widget.values.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: CircleCheckboxWithTitle(
              title: widget.name.call(widget.values.elementAt(i)),
              onChanged: (isCheck) =>
                  onChanged(widget.values.elementAt(i), isCheck),
              doubleTapToUncheck: widget.values.elementAt(i) != null,
            ),
          )
      ],
    );
  }
}
