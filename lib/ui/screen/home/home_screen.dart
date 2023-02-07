import 'dart:ui';

import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/home/home_controller.dart';
import 'package:dtnd/ui/screen/home/widget/asset_card.dart';
import 'package:dtnd/ui/screen/home/widget/home_appbar_delegate.dart';
import 'package:dtnd/ui/screen/home/widget/home_interested_catalog.dart';
import 'package:dtnd/ui/screen/home/widget/home_market_overview.dart';
import 'package:dtnd/ui/screen/home/widget/home_market_today.dart';
import 'package:dtnd/ui/screen/home/widget/home_news.dart';
import 'package:dtnd/ui/screen/home/widget/home_quick_access.dart';
import 'package:dtnd/ui/screen/home/widget/home_section.dart';
import 'package:dtnd/ui/screen/home_base/widget/home_base_nav.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/widget/my_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.navigateTab});
  final ValueChanged<HomeNav> navigateTab;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
          delegate: HomeAppbarDelegate(
              homeController.appService, homeController.dataCenterService),
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

  Widget builder(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "DTND",
        actions: [
          SvgPicture.asset(AppImages.search_appbar_icon),
          const SizedBox(
            width: 20,
          ),
          SvgPicture.asset(AppImages.notification_appbar_icon),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => homeController.init(),
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(
            dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
            },
          ),
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const HomeAssetCard(),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: HomeQuickAccess(),
              ),
              const SizedBox(
                height: 20,
              ),
              HomeSection(
                title: S.of(context).market_today,
                child: const HomeMarketToday(),
              ),
              const SizedBox(
                height: 20,
              ),
              HomeSection(
                title: S.of(context).market_overview,
                onMore: () {},
                child: const HomeMarketOverview(),
              ),
              const SizedBox(
                height: 20,
              ),
              HomeSection(
                title: S.of(context).interested_catalog,
                onMore: () {},
                child: const HomeInterestedCatalog(),
              ),
              const SizedBox(
                height: 20,
              ),
              Image.asset(AppImages.home_banner),
            ],
          ),
        ),
      ),
    );
  }
}
