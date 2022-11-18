import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/ui/screen/stock_detail.dart/widget/stock_detail_appbar.dart';
import 'package:dtnd/ui/screen/stock_detail.dart/widget/stock_detail_overview.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StockDetailAppbar(stock: widget.stockModel.stock),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              StockDetailOverview(stockModel: widget.stockModel),
            ],
          ),
        ),
      ),
    );
  }
}
