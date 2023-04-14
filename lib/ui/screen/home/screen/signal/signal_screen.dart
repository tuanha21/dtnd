import 'package:dtnd/=models=/response/stock.dart';
import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/=models=/response/top_signal_detail_model.dart';
import 'package:dtnd/=models=/response/top_signal_history_model.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/ui/screen/home/screen/signal/component/signal_effective.dart';
import 'package:dtnd/utilities/logger.dart';
import 'package:flutter/material.dart';

import 'component/signal_appbar.dart';
import 'component/signal_chart.dart';
import 'component/signal_overview.dart';
import 'component/signal_trading_history.dart';

class SignalScreen extends StatefulWidget {
  const SignalScreen(
      {super.key,
      required this.stockModel,
      required this.code,
      required this.type,
      this.defaulPeriod,
      this.defaulday});

  final String code;
  final String type;
  final StockModel? stockModel;
  final String? defaulPeriod;
  final int? defaulday;

  @override
  State<SignalScreen> createState() => _SignalScreenState();
}

class _SignalScreenState extends State<SignalScreen> {
  final IDataCenterService dataCenterService = DataCenterService();

  TopSignalDetailModel? data;
  List<TopSignalHistoryModel>? listHis;
  Stock? stock;

  @override
  void initState() {
    super.initState();
    getData();
    stock = dataCenterService.getStockFromStockCode(widget.code);
  }

  Future<void> getData() async {
    data = await dataCenterService.getTopSignalDetail(widget.code, widget.type);
    logger.v(data);
    listHis = await dataCenterService.getTopSignalHistory(
        widget.code, widget.type,
        day: widget.defaulday ?? 90);
    setState(() {});
  }

  Future<void> changePeriod(ValuePerPeriod? period) async {
    if (period != null) {
      listHis = await dataCenterService.getTopSignalHistory(
          widget.code, widget.type,
          day: period.day.toInt());
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: SignalAppbar(
        stock: stock,
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          SignalOverview(
            detail: data,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: SignalChart(
              data: data,
              stockModel: widget.stockModel,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            child: SignalEffective(
              code: widget.code,
              type: widget.type,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Row(
              children: [
                Text(
                  "Lịch sử giao dịch",
                  style: textTheme.bodyLarge
                      ?.copyWith(fontWeight: FontWeight.w700),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SignalTradingHistory(
              onChanged: changePeriod,
              listHis: listHis,
              data: data,
              defaulPeriod: widget.defaulPeriod,
            ),
          ),
          const SizedBox(
            height: 16,
          )
        ],
      ),
    );
  }
}
