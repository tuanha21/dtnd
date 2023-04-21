import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/market/market_controller.dart';
import 'package:dtnd/ui/screen/market/widget/tabs/interested_tab.dart';
import 'package:dtnd/ui/screen/market/widget/tabs/market_analysis_tab.dart';
import 'package:dtnd/ui/screen/market/widget/tabs/market_industry_tab.dart';
import 'package:dtnd/ui/screen/market/widget/tabs/market_overview_tab.dart';
import 'package:dtnd/ui/widget/my_appbar.dart';
import 'package:flutter/material.dart';
import '../../../=models=/response/stock.dart';
import '../../../data/i_data_center_service.dart';
import '../../../data/implementations/data_center_service.dart';
import '../../theme/app_image.dart';
import '../search/search_screen.dart';
import '../stock_detail/stock_detail_screen.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key});

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen>
    with SingleTickerProviderStateMixin {
  final MarketController marketController = MarketController();
  late final TabController _tabController;

  final IDataCenterService dataCenterService = DataCenterService();

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    marketController.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        // backgroundColor: AppColors.linear_01,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                builder: (context) => const SearchScreen(),
              ))
                  .then(
                (value) async {
                  if (value is Stock) {
                    dataCenterService
                        .getStocksModelsFromStockCodes([value.stockCode]).then(
                      (stockModels) {
                        if (stockModels != null) {
                          return Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => StockDetailScreen(
                                stockModel: stockModels.first,
                              ),
                            ),
                          );
                        }
                      },
                    );
                  }
                },
              );
            },
            child: SizedBox.square(
              dimension: 26,
              child: Image.asset(
                AppImages.home_icon_search_normal,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          SizedBox.square(
            dimension: 26,
            child: Image.asset(
              AppImages.home_icon_notification,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
      body: Column(
        children: [
          PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                labelPadding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                padding: const EdgeInsets.only(top: 8),
                tabs: <Widget>[
                  Text(S.of(context).overview),
                  Text(S.of(context).interested),
                  Text(S.of(context).Institution),
                  Text(S.of(context).cash_flow),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                MarketOverviewTab(),
                InterestedTab(),
                MarketAnalysisTab(),
                MarketIndustryTab(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
