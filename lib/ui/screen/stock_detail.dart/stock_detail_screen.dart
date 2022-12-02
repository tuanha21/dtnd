import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/stock_detail.dart/widget/choose_technical_trading.dart';
import 'package:dtnd/ui/screen/stock_detail.dart/widget/stock_detail_appbar.dart';
import 'package:dtnd/ui/screen/stock_detail.dart/widget/stock_detail_chart.dart';
import 'package:dtnd/ui/screen/stock_detail.dart/widget/stock_detail_overview.dart';
import 'package:dtnd/ui/screen/stock_detail.dart/widget/tab_trading_board.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
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

class _StockDetailScreenState extends State<StockDetailScreen>
    with SingleTickerProviderStateMixin {
  final DataCenterService dataCenterService = DataCenterService();
  late final TabController _tabController;

  bool initialized = false;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Builder(builder: (context) {
          if (!initialized) {
            return Center(
              child: Text(S.of(context).loading),
            );
          }
          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                  child: StockDetailOverview(stockModel: widget.stockModel),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      child: StockDetailChart(stockModel: widget.stockModel)),
                ),
                SliverToBoxAdapter(
                  child: PreferredSize(
                    preferredSize: const Size.fromHeight(kToolbarHeight),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TabBar(
                        controller: _tabController,
                        isScrollable: true,
                        labelPadding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 6),
                        padding: EdgeInsets.zero,
                        tabs: <Widget>[
                          Text(S.of(context).trading_board),
                          Text(S.of(context).matched_order_detail),
                        ],
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              controller: _tabController,
              children: <Widget>[
                CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: TabTradingBoard(
                        stockModel: widget.stockModel,
                      ),
                    ),
                  ],
                ),
                const Center(
                  child: Text("Chi tiết kl"),
                )
              ],
            ),
          );
        }),
      ),
      floatingActionButton: SizedBox.square(
        dimension: 40,
        child: Material(
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          child: InkWell(
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
            onTap: () => showModalBottomSheet<TechnicalTrading>(
              context: context,
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20))),
              builder: (BuildContext context) {
                return Wrap(
                  children: [
                    TechnicalTradings(
                      onChoosen: (value) => Navigator.of(context).pop(value),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
