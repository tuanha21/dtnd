import 'package:dtnd/generated/l10n.dart';
import 'package:flutter/cupertino.dart';

enum HomeNav {
  home,
  market,
  asset,
  community,
  account,
}

final GlobalKey<NavigatorState> homeBaseKey = GlobalKey();

final Map<HomeNav, GlobalKey<NavigatorState>> homeNavKeys = {
  HomeNav.home: GlobalKey<NavigatorState>(),
  HomeNav.market: GlobalKey<NavigatorState>(),
  HomeNav.asset: GlobalKey<NavigatorState>(),
  HomeNav.community: GlobalKey<NavigatorState>(),
  HomeNav.account: GlobalKey<NavigatorState>(),
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
      case HomeNav.account:
        return S.of(context).account;
    }
  }
}
