import 'dart:ui';

import 'package:dtnd/generated/l10n.dart';
import 'package:dtnd/ui/screen/home/home_controller.dart';
import 'package:dtnd/ui/screen/home/widget/asset_card.dart';
import 'package:dtnd/ui/screen/home/widget/home_interested_catalog.dart';
import 'package:dtnd/ui/screen/home/widget/home_market_overview.dart';
import 'package:dtnd/ui/screen/home/widget/home_market_today.dart';
import 'package:dtnd/ui/screen/home/widget/home_quick_access.dart';
import 'package:dtnd/ui/screen/home/widget/home_section.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:dtnd/ui/widget/my_appbar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController homeController = HomeController();

  @override
  void initState() {
    homeController.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: "DTND"),
      body: RefreshIndicator(
        onRefresh: () async => homeController.init(),
        child: Padding(
          padding: const EdgeInsets.all(16),
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
                const HomeQuickAccess(),
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
                HomeSection(
                  title: S.of(context).market_overview,
                  child: const HomeMarketToday(),
                ),
                const SizedBox(
                  height: 20,
                ),
                HomeSection(
                  title: S.of(context).market_today,
                  onMore: () {},
                  child: const HomeMarketOverview(),
                ),
                const SizedBox(
                  height: 20,
                ),
                Image.asset(AppImages.home_banner),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
