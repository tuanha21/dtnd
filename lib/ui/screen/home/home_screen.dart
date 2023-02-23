import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';
import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/home/home_controller.dart';
import 'package:dtnd/ui/screen/home/widget/home_appbar_delegate.dart';
import 'package:dtnd/ui/screen/home/widget/home_interested_catalog.dart';
import 'package:dtnd/ui/screen/home/widget/home_market_overview.dart';
import 'package:dtnd/ui/screen/home/widget/home_market_today.dart';
import 'package:dtnd/ui/screen/home/widget/home_news.dart';
import 'package:dtnd/ui/screen/home/widget/home_section.dart';
import 'package:dtnd/ui/screen/home_base/widget/home_base_nav.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.navigateTab});
  final ValueChanged<HomeNav> navigateTab;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final IUserService userService = UserService();
  final HomeController homeController = HomeController();

  // @override
  // void initState() {
  //   homeController.init();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: HomeAppbarDelegate(homeController.appService,
              homeController.dataCenterService, userService),
        ),
        // SliverAppBar(
        //   pinned: true,
        //   expandedHeight: 400.0,
        //   leading: Text(
        //     "DTND",
        //     style: Theme.of(context)
        //         .textTheme
        //         .labelLarge
        //         ?.copyWith(fontWeight: FontWeight.w700),
        //   ),
        //   actions: [
        //     SvgPicture.asset(AppImages.search_appbar_icon),
        //     const SizedBox(
        //       width: 20,
        //     ),
        //     SvgPicture.asset(AppImages.notification_appbar_icon),
        //     const SizedBox(
        //       width: 16,
        //     ),
        //   ],
        //   // stretch: true,
        //   flexibleSpace: FlexibleSpaceBar(
        //     background: Image.asset(
        //       AppImages.home_appbar_bg,
        //       fit: BoxFit.fitWidth,
        //     ),
        //   ),
        // ),

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
            child: HomeInterestedCatalog(),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.only(bottom: 120),
          sliver: SliverToBoxAdapter(
            child: HomeSection(
              title: S.of(context).news,
              onTitleTap: () => HomeController().getNews(),
              onMore: () {},
              child: const HomeNews(),
            ),
          ),
        ),
      ],
    );
  }
}
