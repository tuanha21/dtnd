// ignore_for_file: constant_identifier_names

import 'dart:async';

import 'package:dtnd/=models=/response/stock_model.dart';
import 'package:dtnd/config/service/app_services.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/exchange_stock/stock_order/sheet/stock_order_sheet.dart';
import 'package:dtnd/ui/screen/login/login_screen.dart';
import 'package:dtnd/ui/screen/stock_detail.dart/enum/detail_tab_enum.dart';
import 'package:dtnd/ui/screen/stock_detail.dart/tab/finance_index_tab.dart';
import 'package:dtnd/ui/screen/stock_detail.dart/tab/overview_tab.dart';
import 'package:dtnd/ui/screen/stock_detail.dart/widget/component/price_alert.dart';
import 'package:dtnd/ui/screen/stock_detail.dart/widget/component/stock_detail_appbar.dart';
import 'package:dtnd/ui/screen/stock_detail.dart/widget/financial_index.dart';
import 'package:dtnd/ui/screen/stock_detail.dart/widget/stock_detail_chart.dart';
import 'package:dtnd/ui/screen/stock_detail.dart/widget/stock_detail_news.dart';
import 'package:dtnd/ui/screen/stock_detail.dart/widget/tab_trading_board.dart';
import 'package:dtnd/ui/theme/app_color.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/widget/overlay/login_first_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';

import '../exchange_stock/stock_order/business/stock_order_cmd.dart';
import '../home/widget/home_section.dart';

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
  final IDataCenterService dataCenterService = DataCenterService();
  final IUserService userService = UserService();
  late final TabController _tabController;

  late final ScrollController scrollController;
  late final PanelController panelController;

  bool initialized = false;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    scrollController = ScrollController();
    panelController = PanelController();
    super.initState();
    initData();
  }

  void initData() async {
    await getStockIndayTradingHistory();
    // await getIndayMatchedOrders();
    // await getStockRankingFinancialIndex();
    await getSecurityBasicInfo();
    setState(() {
      initialized = true;
    });
  }

  Future<void> getStockIndayTradingHistory() async {
    widget.stockModel.stockTradingHistory.value = await dataCenterService
        .getStockIndayTradingHistory(widget.stockModel.stock.stockCode);
  }

  Future<void> getSecurityBasicInfo() async {
    widget.stockModel.securityBasicInfo.value = await dataCenterService
        .getSecurityBasicInfo(widget.stockModel.stock.stockCode);
  }

  Future<void> getStockRankingFinancialIndex() async {
    widget.stockModel.stockRankingFinancialIndex.value = await dataCenterService
        .getStockRankingFinancialIndex(widget.stockModel.stock.stockCode);
  }

  Future<void> getIndayMatchedOrders() async {
    final listMatchedOrder = await dataCenterService
        .getIndayMatchedOrders(widget.stockModel.stock.stockCode);
    widget.stockModel.updateListMatchedOrder(listMatchedOrder);
  }

  void _onFABTapped() async {
    // print("userService.isLogin ${userService.isLogin}");
    if (!userService.isLogin) {
      final toLogin = await showDialog<bool>(
        context: context,
        builder: (context) {
          return const LoginFirstCatalog();
        },
      );
      if (toLogin ?? false) {
        if (!mounted) return;
        final result = await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ));
        if (result) {
          return _onFABTapped();
        }
      }
    } else {
      // return StockOrderISheet(widget.stockModel).showSheet(context, );
      StockOrderISheet(widget.stockModel).show(
          context,
          StockOrderSheet(
            stockModel: widget.stockModel,
            orderData: null,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: StockDetailAppbar(stock: widget.stockModel.stock),
      body: Builder(builder: (context) {
        if (!initialized) {
          return Center(
            child: Text(S.of(context).loading),
          );
        }
        final themeMode = AppService.instance.themeMode.value;
        return NestedScrollView(
          // physics: PanelScrollPhysics(controller: panelController),
          // controller: ScrollController(),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverPersistentHeader(
                    pinned: true,
                    delegate: StockDetailAppbar(stockModel: widget.stockModel)),
              ),
            ];
          },
          body: SizedBox.expand(
            child: SlidingUpPanel(
              minHeight: 60,
              parallaxEnabled: false,
              maxHeight:
                  MediaQuery.of(context).size.height - kToolbarHeight - 80,
              color: themeMode.isLight ? Colors.white : Colors.black,
              scrollController: scrollController,
              controller: panelController,
              body: Builder(builder: (context) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CustomScrollView(
                    slivers: [
                      SliverOverlapInjector(
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                            context),
                      ),
                      SliverToBoxAdapter(
                        child: SizedBox(
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            child: StockDetailChart(
                                stockModel: widget.stockModel)),
                      ),
                      const SliverToBoxAdapter(child: PriceAlert()),
                      const SliverToBoxAdapter(child: SizedBox(height: 15)),
                      SliverToBoxAdapter(
                        child: HomeSection(
                          title: S.of(context).news_and_events,
                          child: StockDetailNews(
                            stockCode: widget.stockModel.stock.stockCode,
                          ),
                        ),
                      ),
                      const SliverToBoxAdapter(child: SizedBox(height: 120)),
                    ],
                  ),
                );
              }),
              header: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: ForceDraggableWidget(
                        child: SizedBox(
                          width: 39,
                          height: 4,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: AppColors.neutral_03,
                              borderRadius: BorderRadius.all(
                                Radius.circular(2),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    ForceDraggableWidget(
                      child: TabBar(
                        controller: _tabController,
                        isScrollable: true,
                        labelPadding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        padding: EdgeInsets.zero,
                        tabs: DetailTab.values
                            .map((e) => Text(e.getName(context)))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
              panelBuilder: () {
                return Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: TabBarView(
                    controller: _tabController,
                    // physics: PanelScrollPhysics(controller: panelController),
                    // controller: scrollController,
                    children: <Widget>[
                      // ListView(
                      //   physics:
                      //       PanelScrollPhysics(controller: panelController),
                      //   controller: scrollController,
                      //   shrinkWrap: true,
                      //   children: [
                      //     TabTradingBoard(
                      //       stockModel: widget.stockModel,
                      //       scrollController: scrollController,
                      //       panelController: panelController,
                      //     ),
                      //   ],
                      // ),
                      OverviewTab(
                        stockModel: widget.stockModel,
                        scrollController: scrollController,
                        panelController: panelController,
                      ),
                      const Center(
                        child: Text("Chi tiết kl"),
                      ),
                      FinanceIndexTab(
                        scrollController: scrollController,
                        panelController: panelController,
                        stockModel: widget.stockModel,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      }),
      floatingActionButton: SizedBox.square(
        dimension: 40,
        child: Material(
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(6)),
            onTap: _onFABTapped,
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
