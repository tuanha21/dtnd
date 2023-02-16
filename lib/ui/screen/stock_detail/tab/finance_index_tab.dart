import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/stock_detail/widget/component/benefit_chart.dart';
import 'package:dtnd/ui/screen/stock_detail/widget/financial_index.dart';
import 'package:flutter/material.dart';

class FinanceIndexTab extends StatefulWidget {
  const FinanceIndexTab({
    super.key,
    required this.stockModel,
  });
  final StockModel stockModel;
  @override
  State<FinanceIndexTab> createState() => _FinanceIndexTabState();
}

class _FinanceIndexTabState extends State<FinanceIndexTab> {
  final IDataCenterService dataCenterService = DataCenterService();
  bool initialized = false;
  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() async {
    if (widget.stockModel.stockFinancialIndex.isEmpty) {
      await getStockFinancialIndex();
    }
    setState(() {
      initialized = true;
    });
  }

  Future<void> getStockFinancialIndex() async {
    widget.stockModel.changeStockFinancialIndex(await dataCenterService
        .getStockFinancialIndex(widget.stockModel.stock.stockCode));
  }

  @override
  Widget build(BuildContext context) {
    Widget benefitChart;
    if (widget.stockModel.stockFinancialIndex.isEmpty) {
      benefitChart = Container();
    } else {
      benefitChart = BenefitChart(
        listStockFinancialIndex: widget.stockModel.stockFinancialIndex,
      );
    }
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            const SizedBox(height: 20),
            FinancialIndex(
              stockModel: widget.stockModel,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  S.of(context).index,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                Container()
              ],
            ),
            const SizedBox(height: 20),
            benefitChart,
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
