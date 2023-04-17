import 'package:dtnd/=models=/response/stock.dart';
import 'package:dtnd/data/i_data_center_service.dart';
import 'package:dtnd/data/implementations/data_center_service.dart';
import 'package:dtnd/ui/screen/search/search_screen.dart';
import 'package:dtnd/ui/screen/stock_detail/stock_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../generated/l10n.dart';

import '../../theme/app_image.dart';
import '../../widget/my_appbar.dart';
import 'community_tab.dart';
import 'copy_trade_tab.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final IDataCenterService dataCenterService = DataCenterService();

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                builder: (context) => const SearchScreen(),
              ))
                  .then((value) async {
                if (value is Stock) {
                  dataCenterService.getStocksModelsFromStockCodes(
                      [value.stockCode]).then((stockModels) {
                    if (stockModels != null) {
                      return Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => StockDetailScreen(
                          stockModel: stockModels.first,
                        ),
                      ));
                    }
                  });
                }
              });
            },
            child: SizedBox.square(
                dimension: 26,
                child: Image.asset(
                  AppImages.home_icon_search_normal,
                )),
          ),
          const SizedBox(
            width: 20,
          ),
          SizedBox.square(
              dimension: 26,
              child: Image.asset(
                AppImages.home_icon_notification,
              )),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            TabBar(
              controller: _tabController,
              isScrollable: false,
              labelPadding:
                  const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
              padding: EdgeInsets.zero,
              tabs: <Widget>[
                Text(S.of(context).community),
                Text(S.of(context).copytrade)
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: TabBarView(controller: _tabController, children: const [
                CommunityTab(),
                CopyTradeTab(),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
