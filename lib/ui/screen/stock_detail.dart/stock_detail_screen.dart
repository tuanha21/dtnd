import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/ui/screen/stock_detail.dart/widget/stock_detail_appbar.dart';
import 'package:dtnd/ui/screen/stock_detail.dart/widget/stock_detail_chart.dart';
import 'package:dtnd/ui/screen/stock_detail.dart/widget/stock_detail_overview.dart';
import 'package:dtnd/ui/screen/stock_detail.dart/widget/stock_detail_tab.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:flutter/material.dart';

class StockDetailScreen extends StatefulWidget {
  const StockDetailScreen({
    Key? key,
    required this.stockModel,
  }) : super(key: key);
  final StockModel stockModel;
  @override
  State<StockDetailScreen> createState() => _StockDetailScreenState();
}

class _StockDetailScreenState extends State<StockDetailScreen> {
  final DataCenterService dataCenterService = DataCenterService();

  bool initialized = false;
  @override
  void initState() {
    super.initState();
    if (widget.stockModel.listStockTrade == null) {
      getStockIndayTradingHistory();
    } else {
      setState(() {
        initialized = true;
      });
    }
  }

  void getStockIndayTradingHistory() async {
    widget.stockModel.stockTradingHistory = await dataCenterService
        .getStockIndayTradingHistory(widget.stockModel.stock.stockCode);
    setState(() {
      initialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StockDetailAppbar(stock: widget.stockModel.stock),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              StockDetailOverview(stockModel: widget.stockModel),
              Builder(builder: (context) {
                if (initialized) {
                  return SizedBox(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      child: StockDetailChart(stockModel: widget.stockModel));
                } else {
                  return Container();
                }
              }),
              StockDetailTab(),
            ],
          ),
        ),
      ),
    );
  }
}
