import 'package:dtnd/=models=/response/share_transaction_model.dart';
import 'package:dtnd/data/i_exchange_service.dart';
import 'package:dtnd/data/implementations/exchange_service.dart';
import 'package:dtnd/ui/screen/account/component/share_transaction_component.dart';
import 'package:dtnd/ui/widget/calendar/day_input.dart';
import 'package:dtnd/ui/widget/empty_list_widget.dart';
import 'package:dtnd/ui/widget/icon/sheet_header.dart';
import 'package:dtnd/utilities/time_utils.dart';
import 'package:flutter/material.dart';

class ShareStatementSheet extends StatefulWidget {
  const ShareStatementSheet({super.key});

  @override
  State<ShareStatementSheet> createState() => _ShareStatementSheetState();
}

class _ShareStatementSheetState extends State<ShareStatementSheet> {
  final IExchangeService exchangeService = ExchangeService();

  final List<ShareTransactionModel> list = [];
  late DateTime fromDay;
  late DateTime toDay;
  late DateTime firstDay;
  late DateTime lastDay;
  @override
  void initState() {
    fromDay = TimeUtilities.getPreviousDateTime(TimeUtilities.month(1));
    toDay = DateTime.now();
    firstDay = TimeUtilities.getPreviousDateTime(TimeUtilities.month(3));
    lastDay = toDay;
    super.initState();
    getData();
  }

  Future<void> getData() async {
    final res = await exchangeService.getShareTransactions(
      fromDay: fromDay,
      toDay: toDay,
    );
    list.clear();
    list.addAll(res);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SheetHeader(
              title: "Sao kê chứng khoán",
              backData: null,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DayInput(
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
                  DayInput(
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
              if (list.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    EmptyListWidget(),
                  ],
                );
              } else {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return ShareTransactionComponent(
                      data: list.elementAt(index),
                    );
                  },
                );
              }
            }))
          ],
        ),
      ),
    );
  }
}
