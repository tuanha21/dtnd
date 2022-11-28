import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/stock_detail.dart/widget/stock_detail_appbar.dart';
import 'package:dtnd/ui/screen/stock_detail.dart/widget/stock_detail_chart.dart';
import 'package:dtnd/ui/screen/stock_detail.dart/widget/stock_detail_overview.dart';
import 'package:dtnd/ui/screen/stock_detail.dart/widget/stock_detail_tab.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/widget/svg_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
    widget.stockModel.stockTradingHistory.value = await dataCenterService
        .getStockIndayTradingHistory(widget.stockModel.stock.stockCode);
    setState(() {
      initialized = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StockDetailAppbar(stock: widget.stockModel.stock),
      floatingActionButton: SizedBox.square(
        dimension: 40,
        child: InkWell(
          onTap: () => Navigator.of(context).pop(),
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          child: Ink(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              color: AppColors.primary_01,
            ),
            child: SvgPicture.asset(
              AppImages.arrange_circle,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Builder(builder: (context) {
            if (!initialized) {
              return Center(
                child: Text(S.of(context).loading),
              );
            }
            return Column(
              children: [
                StockDetailOverview(stockModel: widget.stockModel),
                SizedBox(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: StockDetailChart(stockModel: widget.stockModel)),
                StockDetailTab(
                  stockModel: widget.stockModel,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
