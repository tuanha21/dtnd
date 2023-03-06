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
import 'package:dtnd/ui/widget/empty_list_widget.dart';
import 'package:dtnd/ui/widget/picker/datetime_picker_widget.dart';
import 'package:dtnd/utilities/time_utils.dart';
import 'package:flutter/material.dart';

class OrderHistoryTab extends StatefulWidget {
  const OrderHistoryTab({super.key});

  @override
  State<OrderHistoryTab> createState() => _OrderHistoryTabState();
}

class _OrderHistoryTabState extends State<OrderHistoryTab> {
  final IUserService userService = UserService();
  final IExchangeService exchangeService = ExchangeService();

  late final TextEditingController fromdayController;
  late final TextEditingController todayController;

  List<OrderHistoryModel>? listOrder;
  List<OrderHistoryModel>? listOrderShow;
  OrderFilterData? orderFilterData;

  @override
  void initState() {
    fromdayController = TextEditingController(
        text: TimeUtilities.commonTimeFormat
            .format(DateTime.now().subtract(const Duration(days: 1))));
    todayController = TextEditingController(
        text: TimeUtilities.commonTimeFormat.format(DateTime.now()));
    super.initState();
    getData();
  }

  Future<void> getData({DateTime? fromDay, DateTime? toDay}) async {
    final from =
        fromDay ?? TimeUtilities.commonTimeFormat.parse(fromdayController.text);
    final to =
        toDay ?? TimeUtilities.commonTimeFormat.parse(todayController.text);
    listOrder = await exchangeService.getOrdersHistory(userService,
        fromDay: from, toDay: to);
    listOrderShow = List<OrderHistoryModel>.from(listOrder ?? []);
    if (mounted) {
      setState(() {});
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
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Column(
        children: [
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                  child: DateTimePickerWidget(
                controller: fromdayController,
                labelText: S.of(context).from_day,
                firstDate:
                    TimeUtilities.getPreviousDateTime(TimeUtilities.month(3)),
                onChanged: (value) => getData(fromDay: value),
              )),
              const SizedBox(width: 16),
              Expanded(
                  child: DateTimePickerWidget(
                controller: todayController,
                labelText: S.of(context).to_day,
                onChanged: (value) => getData(toDay: value),
              ))
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
                        child: Image.asset(AppImages.filter_icon)),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(child: Builder(
            builder: (context) {
              // final List<Widget> records = [];
              // if (listOrderShow?.isNotEmpty ?? false) {
              //   for (OrderHistoryModel record in listOrderShow!) {
              //     records.add(OrderRecordWidget(
              //       data: record,
              //     ));
              //   }
              // }
              if (listOrderShow?.isEmpty ?? true) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: EmptyListWidget(),
                );
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
                        for (int i = 0; i < (listOrderShow?.length ?? 0); i++)
                          Column(
                            children: [
                              i != 0 ? const Divider(height: 1) : Container(),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: OrderHistoryElement(
                                    model: listOrderShow!.elementAt(i)),
                              ),
                            ],
                          )
                      ],
                    ),
                  ),
                ],
              );
            },
          ))
        ],
      ),
    );
  }
}
