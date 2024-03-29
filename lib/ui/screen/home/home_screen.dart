import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/l10n/generated/l10n.dart';
import 'package:dtnd/ui/screen/home/home_controller.dart';
import 'package:dtnd/ui/screen/home/widget/home_appbar_delegate.dart';
import 'package:dtnd/ui/screen/home/widget/home_top_signal_stocks.dart';
import 'package:dtnd/ui/screen/home/widget/home_market_overview.dart';
import 'package:dtnd/ui/screen/home/widget/home_market_today.dart';
import 'package:dtnd/ui/screen/home/widget/home_news.dart';
import 'package:dtnd/ui/screen/home/widget/home_section.dart';
import 'package:dtnd/ui/screen/home_base/widget/home_base_nav.dart';
import 'package:dtnd/ui/screen/news_detail/list_news_flow.dart';
import 'package:dtnd/ui/screen/news_detail/list_news_sheet.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.navigateTab});
  final ValueChanged<HomeNav> navigateTab;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
// with AutomaticKeepAliveClientMixin
{
  final IUserService userService = UserService();

  final HomeController homeController = HomeController();

  @override
  void initState() {
    homeController.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await userService.refreshAssets();
        await homeController.getTopSignal();
        await homeController.getWorldIndex();
        await homeController.getCommodities();
      },
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: HomeAppbarDelegate(
                homeController.appService,
                homeController.dataCenterService,
                userService,
                widget.navigateTab),
          ),
          SliverToBoxAdapter(
            child: HomeSection(
              title: S.of(context).market_today,
              onMoreDot: () => widget.navigateTab.call(HomeNav.market),
              child: const HomeMarketToday(),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 24),
            sliver: SliverToBoxAdapter(
              child: HomeSection(
                title: S.of(context).market_overview,
                child: const HomeMarketOverview(),
              ),
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 24),
            sliver: SliverToBoxAdapter(
              child: HomeTopSignalStocks(),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 120),
            sliver: SliverToBoxAdapter(
              child: HomeSection(
                title: S.of(context).news,
                onTitleTap: () => HomeController().getNews(),
                onMore: () {
                  const ListNewsISheet()
                      .show(context, const ListNewsSheet(), wrap: false);
                },
                child: const HomeNews(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    homeController.loadTime?.cancel();
  }

  // @override
  // // TODO: implement wantKeepAlive
  // bool get wantKeepAlive => true;
}
