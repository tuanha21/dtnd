import 'package:dtnd/=models=/response/share_transaction_model.dart';
import 'package:dtnd/data/i_exchange_service.dart';
import 'package:dtnd/data/implementations/exchange_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/account/component/share_transaction_component.dart';
import 'package:dtnd/ui/widget/appbar/simple_appbar.dart';
import 'package:dtnd/ui/widget/calendar/day_input.dart';
import 'package:dtnd/ui/widget/empty_list_widget.dart';
import 'package:dtnd/utilities/time_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  bool isLoading = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    fromDay = TimeUtilities.getPreviousDateTime(TimeUtilities.month(1));
    toDay = DateTime.now();
    firstDay = TimeUtilities.getPreviousDateTime(TimeUtilities.month(3));
    lastDay = toDay;
    _scrollController.addListener(_scrollListener); // Lắng nghe sự kiện cuộn
    super.initState();
    getData();
  }

  Future<void> getData({int? recordPerPage}) async {
    setState(() {
      isLoading = true; // Đánh dấu đang tải dữ liệu
    });
    await Future.delayed(const Duration(seconds: 1));
    final res = await exchangeService.getShareTransactions(
        fromDay: fromDay, toDay: toDay, recordPerPage: recordPerPage);
    list.clear();
    list.addAll(res);
    setState(() {
      isLoading = false; // Kết thúc tải dữ liệu
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
    return Scaffold(
      appBar: SimpleAppbar(
        title: S.of(context).stock_statement,
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
                return const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    EmptyListWidget(),
                  ],
                );
              } else {
                return ListView.builder(
                  controller: _scrollController,
                  shrinkWrap: true,
                  itemCount: list.length + 1,
                  itemBuilder: (context, index) {
                    if (index < list.length) {
                      return ShareTransactionComponent(
                        data: list.elementAt(index),
                      );
                    } else if (index == list.length && isLoading) {
                      return _buildLoader();
                    } else {
                      return const SizedBox.shrink();
                    }
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

Widget _buildLoader() {
  return Container(
    alignment: Alignment.center,
    padding: const EdgeInsets.symmetric(vertical: 16.0),
    child: const CircularProgressIndicator(),
  );
}
