import 'package:dtnd/l10n/generated/l10n.dart';
import 'package:dtnd/ui/theme/app_image.dart';
import 'package:flutter/material.dart';

enum HomeNav {
  home,
  market,
  asset,
  community,
  // account,
}

final GlobalKey<ScaffoldState> homeBaseKey = GlobalKey();

final Map<HomeNav, GlobalKey<NavigatorState>> homeNavKeys = {
  HomeNav.home: GlobalKey<NavigatorState>(),
  HomeNav.market: GlobalKey<NavigatorState>(),
  HomeNav.asset: GlobalKey<NavigatorState>(),
  HomeNav.community: GlobalKey<NavigatorState>(),
  // HomeNav.account: GlobalKey<NavigatorState>(),
};

extension HomeNavX on HomeNav {
  String label(BuildContext context) {
    switch (this) {
      case HomeNav.home:
        return S.of(context).home;
      case HomeNav.market:
        return S.of(context).market;
      case HomeNav.asset:
        return S.of(context).asset;
      case HomeNav.community:
        return S.of(context).community;
      // case HomeNav.account:
      //   return S.of(context).account;
    }
  }

  int get index {
    switch (this) {
      case HomeNav.home:
        return 0;
      case HomeNav.market:
        return 1;
      case HomeNav.asset:
        return 2;
      case HomeNav.community:
        return 3;
      // case HomeNav.account:
      //   return 4;
    }
  }

  String get iconPath {
    switch (this) {
      case HomeNav.home:
        return AppImages.home_nav_icon;
      case HomeNav.market:
        return AppImages.market_nav_icon;
      case HomeNav.asset:
        return AppImages.asset_nav_icon;
      case HomeNav.community:
        return AppImages.community_nav_icon;
      // case HomeNav.account:
      //   return AppImages.account_nav_icon;
    }
  }
}
