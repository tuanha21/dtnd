import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/=models=/response/top_signal_detail_model.dart';
import 'package:dtnd/=models=/response/top_signal_stock_model.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/ui/screen/virtual_assistant/signal/component/signal_effective.dart';
import 'package:flutter/material.dart';

import 'component/signal_appbar.dart';
import 'component/signal_chart.dart';
import 'component/signal_overview.dart';
import 'component/signal_trading_history.dart';

class SignalScreen extends StatefulWidget {
  const SignalScreen({super.key, required this.data});
  final TopSignalStockModel data;
  @override
  State<SignalScreen> createState() => _SignalScreenState();
}

class _SignalScreenState extends State<SignalScreen> {
  final IDataCenterService dataCenterService = DataCenterService();

  TopSignalDetailModel? data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  Future<void> getData() async {
    data = await dataCenterService.getTopSignalDetail(
        widget.data.cSHARECODE, widget.data.cTYPE!);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SignalAppbar(
        stock: widget.data.stockModel.stock,
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          SignalOverview(
            data: widget.data,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: SignalEffective(
              data: data,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: SignalChart(
              stockModel: widget.data.stockModel,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: SignalTradingHistory(),
          ),
        ],
      ),
    );
  }
}
