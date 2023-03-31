import 'package:dtnd/=models=/response/order_model/i_order_model.dart';
import 'package:dtnd/=models=/side.dart';
import 'package:dtnd/=models=/ui_model/user_cmd.dart';
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
  final List<Side?> listSides = [null, ...Side.values];
  final List<OrderStatus?> listStatuss = [null, ...OrderStatus.values];
  late final List<bool> listSideSelect;
  late final List<bool> listStatusSelect;
  @override
  void initState() {
    initListSide();
    initListStatus();
    super.initState();
  }

  void initListSide() {
    listSideSelect = List.filled(Side.values.length + 1, false);
    if (widget.data?.orderType != null) {
      listSideSelect[listSides
          .indexWhere((element) => element == widget.data!.orderType)] = true;
    } else {
      listSideSelect[0] = true;
    }
  }

  void initListStatus() {
    listStatusSelect = List.filled(OrderStatus.values.length + 1, false);
    if (widget.data?.orderStatus != null) {
      for (OrderStatus status in widget.data!.orderStatus!) {
        listStatusSelect[
            listStatuss.indexWhere((element) => element == status)] = true;
      }
    } else {
      listStatusSelect[0] = true;
    }
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
              listSelect: listSideSelect,
              title: S.of(context).order_type,
              values: listSides,
              name: (Side? value) => value?.name(context) ?? S.of(context).all,
            ),
            const SizedBox(height: 20),
            _FilterField<OrderStatus>(
              listSelect: listStatusSelect,
              title: "Trạng thái lệnh",
              values: listStatuss,
              name: (OrderStatus? value) =>
                  value?.statusName(context) ?? S.of(context).all,
            ),
            const SizedBox(height: 20),
            SingleColorTextButton(
              color: AppColors.primary_01,
              text: "Áp dụng",
              onTap: () {
                OrderFilterData orderFilterData = OrderFilterData();
                if (!listSideSelect.first) {
                  for (var i = 0; i < listSideSelect.length; i++) {
                    if (listSideSelect.elementAt(i)) {
                      orderFilterData.orderType = listSides.elementAt(i);
                    }
                  }
                }

                if (!listStatusSelect.first) {
                  orderFilterData.orderStatus = [];
                  for (var i = 0; i < listStatusSelect.length; i++) {
                    if (listStatusSelect.elementAt(i)) {
                      orderFilterData.orderStatus!
                          .add(listStatuss.elementAt(i)!);
                    }
                  }
                }
                Navigator.of(context).pop(NextCmd(orderFilterData));
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
      {required this.listSelect,
      required this.values,
      required this.title,
      required this.name});
  final List<bool> listSelect;
  final List<T?> values;
  final String Function(T?) name;
  final String title;
  @override
  State<_FilterField<T>> createState() => __FilterFieldState<T>();
}

class __FilterFieldState<T> extends State<_FilterField<T>> {
  void onChanged(int index) {
    switch (index) {
      case 0:
        setState(() {
          if (!widget.listSelect[0]) {
            for (var i = 1; i < widget.listSelect.length; i++) {
              widget.listSelect[i] = false;
            }
            widget.listSelect[0] = true;
          }
        });

        break;
      default:
        setState(() {
          widget.listSelect[index] = !widget.listSelect[index];
          if (widget.listSelect[0]) {
            widget.listSelect[0] = false;
          }
        });
        int count = 0;
        for (var i = 1; i < widget.listSelect.length; i++) {
          if (widget.listSelect.elementAt(i)) {
            count++;
          }
        }
        if (count == widget.listSelect.length - 1) {
          setState(() {
            for (var i = 1; i < widget.listSelect.length; i++) {
              widget.listSelect[i] = false;
            }
            widget.listSelect[0] = true;
          });
        }
    }
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
              onCheck: () => onChanged(i),
              ischeck: widget.listSelect.elementAt(i),
            ),
          )
      ],
    );
  }
}
